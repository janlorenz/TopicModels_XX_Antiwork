library(tidyverse)
library(LDAvis)
library(jsonlite)
library(glue)

## Estimate LDAs with tomotopy
estimate_LDA_with_tomotopy <- function(data_id, k, rm_top, run_id) {
 system(paste("python3 estimate_tomotopy_LDA_savematrices.py", data_id, k, rm_top, run_id))
}
one_LDA <- function(data_id, run_id) {
 dir.create(glue("data/{data_id}{run_id}"))
 estimate_LDA_with_tomotopy(data_id, 10, 0, run_id)
}
1:10 |> walk(\(id) one_LDA("AWl",id))
2:10 |> walk(\(id) one_LDA("XXl",id))
#1:10 |> walk(\(id) one_LDA("XXAW",id))
#1:10 |> walk(\(id) one_LDA("XXAW20l",id))
#1:10 |> walk(\(id) one_LDA("XXAW15ll",id))
1:10 |> walk(\(id) one_LDA("XXAW15",id))

## LDAVis
load_lda_json <- function(jsonfilename) {
 data <- fromJSON(jsonfilename)
 data$topic_term_dists <- data$topic_term_dists / rowSums(data$topic_term_dists) # renormalize rows of phi	so that they sum precisely to 1
 data$doc_topic_dists <- data$doc_topic_dists / rowSums(data$doc_topic_dists)# renormalize rows of theta so that they sum precisely to 1
 # Create the JSON data for LDAvis
 json <- createJSON(phi = data$topic_term_dists,
                    theta = data$doc_topic_dists,
                    doc.length = data$doc_lengths,
                    vocab = data$vocab,
                    term.frequency = data$term_frequency)
 return(json)
}
serVis(json, open.browser = TRUE)