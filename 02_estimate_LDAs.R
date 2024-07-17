library(tidyverse)
library(LDAvis)
library(jsonlite)
library(glue)

## Estimate LDAs with tomotopy, functions to call the python script from R
## Needs tomotopy corpus files as produced with the python script tomotopy_create_corpus.py
## See creating script from raw data in 01_Preprocessing_Raw_Data.R
estimate_LDA_with_tomotopy <- function(data_id, k, rm_top, run_id) {
 system(paste("python3 estimate_tomotopy_LDA_savematrices.py", data_id, k, rm_top, run_id))
}
one_LDA <- function(data_id, run_id, k) {
 dir.create(glue("data/{data_id}{run_id}")) # Create the directory to store the matrices of the topic models
 estimate_LDA_with_tomotopy(data_id, k, 0, run_id)
}
# Theses are the 3 sets of 10 LDAs produced by the python scripts using tomotopy 
# They write out relevant data of the LDAs (e.g. topic-term distributions, document-topic distributions) in a subfolder
# They also write out the LDAVis as one html file in the docs folder
1:10 |> walk(\(id) one_LDA("AWl",id, 10)) # Antiwork subreddit posts 10 topics
1:10 |> walk(\(id) one_LDA("XXl",id, 10)) # TwoXChromosomes subreddit posts 10 topics
1:10 |> walk(\(id) one_LDA("XXAW15",id, 15)) # Both subreddits posts 15 topics


