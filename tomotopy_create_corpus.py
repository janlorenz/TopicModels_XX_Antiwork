import argparse
import tomotopy as tp
import pandas as pd
import nltk
from nltk.corpus import stopwords
import re
import numpy as np

parser = argparse.ArgumentParser()
parser.add_argument("data_id", help="File id for the data in parquet format")
args = parser.parse_args()

df = pd.read_parquet('data/' + args.data_id + '.parquet')

# Preprocess the text data
stop_words = set(stopwords.words('english'))
stop_words.update(['https', 'http', 'www', 'amp', 'com', 'org', '_', 'x200b', 'gt', 'r', 'png', 'en', 'gov', 'webp', 'nbsp', 'v', 'utm_source', 'html', 'jpg', 'utm_medium', 'pjpg', 'edu', 'web2x', 'utm_name', 'ios_app', 'edu', 'htm', 'pdf', ])
# Top words that are removed from the vocabs XX:
# like know would get time feel really want one even said told never go back think people going got things
# Take all but: people time
#
# Top words that are removed from the vocabs AW:
# work job time get like would people one day even company working told know got back manager pay go want
# Take all but: work job time people day company working manager pay
# 
# Results in new stopwords:
# like know would get feel really want one even said told never go back think going got things
# added a few more stopwords that are not relevant but appeared in topics during testing
stop_words.update(['like', 'know', 'would', 'could', 'get', 'feel', 'really', 'want', 'one', 'even', 'said', 'told', 'never', 'go', 'back', 'think', 'going', 'got', 'things', 'thing', 'also', 'went', 'much'])
# Because we are interested in cognitive identities we include some of the stopwords again
# In testing we tried also "i" and "me" but they were dominating too much
word_to_remove_from_stop_words = ['we', 'our', 'other', 'ours', 'ourselves', 'ourself']
for word in word_to_remove_from_stop_words:
    stop_words.discard(word) 

def clean_text(text):
    text = re.sub(r'\W', ' ', text)
    text = re.sub(r'\s+', ' ', text)
    text = text.lower()
    text = [word for word in text.split() if word not in stop_words]
    return text

df['title_text_clean'] = df['title_text'].apply(clean_text)
texts = df['title_text_clean']

# Create a corpus
corpus = tp.utils.Corpus()
for text in texts:
    corpus.add_doc(text)

# Save the corpus
corpus.save('data/' + args.data_id + '_corpus.bin')