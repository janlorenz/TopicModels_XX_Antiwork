import argparse
import tomotopy as tp
import pandas as pd
import re
import numpy as np
import json
import pyLDAvis

parser = argparse.ArgumentParser()
parser.add_argument("data_id", help="File id for the data in parquet format")
parser.add_argument("num_topics", help="Number of topics k")
parser.add_argument("rm_top", help="Number of topwords to remove")
parser.add_argument("run_id", help="ID for the model")
args = parser.parse_args()

# Load corpus
corpus = tp.utils.Corpus.load('data/' + args.data_id + '_corpus.bin')
corpus = tp.utils.Corpus.load('data/XXl_corpus.bin')

# Setup LDA model
mdl = tp.LDAModel(k=int(args.num_topics), alpha=0.1, eta=0.01, min_cf=5, rm_top=int(args.rm_top), corpus=corpus)
mdl.train(0)
print('Num docs:{}, Num Vocabs:{}, Total Words:{}'.format(
    len(mdl.docs), len(mdl.used_vocabs), mdl.num_words
))
print('Removed Top words: ', *mdl.removed_top_words)  # top words that are removed from the vocabs

# Let's train the model
mdl.train(2000, show_progress=True)
mdl.summary()

# Save the model
mdl.save("data/" + args.data_id + args.run_id + "/tomotopy.mdl")

# mdl = tp.LDAModel.load("data/XXl1/tomotopy.mdl")
# mdl.ll_per_word

# Matrices and vectors for LDAvis
topic_term_dists = np.stack([mdl.get_topic_word_dist(k) for k in range(mdl.k)])
doc_topic_dists = np.stack([doc.get_topic_dist() for doc in mdl.docs])
doc_topic_dists /= doc_topic_dists.sum(axis=1, keepdims=True)
doc_lengths = np.array([len(doc.words) for doc in mdl.docs])
vocab = list(mdl.used_vocabs)
term_frequency = mdl.used_vocab_freq

# Save matrices
pd.DataFrame(topic_term_dists).to_csv("data/" + args.data_id + args.run_id + '/topic_term_dists.csv', index=False)
pd.DataFrame(doc_topic_dists).to_csv("data/" + args.data_id + args.run_id + '/doc_topic_dists.csv', index=False)
pd.DataFrame(doc_lengths, columns=['doc_length']).to_csv("data/" + args.data_id + args.run_id + '/doc_lengths.csv', index=False)
pd.DataFrame(term_frequency, columns=['term_frequency']).to_csv("data/" + args.data_id + args.run_id + '/term_frequency.csv', index=False)
vocab_df = pd.DataFrame(vocab, columns=['Word'])
vocab_df.to_csv("data/" + args.data_id + args.run_id + '/vocab.csv', index=False)
with open("data/" + args.data_id + args.run_id + "/ll_per_word.txt", 'w') as file: 
  file.write(str(mdl.ll_per_word))
with open("data/" + args.data_id + args.run_id + "/perplexity.txt", 'w') as file: 
  file.write(str(mdl.perplexity))
with open("data/" + args.data_id + args.run_id +  "/alpha.txt", 'w') as file: 
  file.write(str(mdl.alpha))
with open("data/" + args.data_id + args.run_id +  "/eta.txt", 'w') as file: 
  file.write(str(mdl.eta))
  

# LDAVis from pyLDAvis
prepared_data = pyLDAvis.prepare(
    topic_term_dists, 
    doc_topic_dists, 
    doc_lengths, 
    vocab, 
    term_frequency,
    start_index=1, # tomotopy starts topic ids with 0, pyLDAvis with 1
    sort_topics=False # IMPORTANT: otherwise the topic_ids between pyLDAvis and tomotopy are not matching!
)
pyLDAvis.save_html(prepared_data, "docs/" + args.data_id + args.run_id + '.html')
# pyLDAvis.save_json(prepared_data, "data/" + args.data_id + args.run_id + '.json')
