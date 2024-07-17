library(tidyverse)
library(glue)
library(arrow)

# Script to read in all LDAs for a specific id (XXl, AWl, XXAW15) and save as one df for further analysis
read_more_LDAs_into_df_save_RDS <- function(id, nums, k) tibble(id = paste0(id,nums)) |>
 mutate(topic_term_dists = map(id, ~read_csv(glue("data/{.}/topic_term_dists.csv")) |> # This step takes time because it is a wide csv
                                t() |> as_tibble() |> set_names(paste0("T", 1:k))),
        doc_topic_dists = map(id, ~read_csv(glue("data/{.}/doc_topic_dists.csv")) |>
                               set_names(paste0("T", 1:k))),
        perplexity = map_dbl(id, ~read_lines(glue("data/{.}/perplexity.txt"))[1] |> as.numeric()),
        ll_per_word = map_dbl(id, ~read_lines(glue("data/{.}/ll_per_word.txt"))[1] |> as.numeric()),
        alpha = map(id, ~read_lines(glue("data/{.}/alpha.txt")) |> str_split(" ") |> unlist() |>
                     str_replace("\\[","") |> str_replace("\\]","") |> as.numeric() |>
                     na.exclude() |> as_tibble()),
        eta =  map_dbl(id, ~read_lines(glue("data/{.}/eta.txt"))[1] |> as.numeric())
 )
# For "XXl"
if (!file.exists("data/XXl_LDAs.rds")) {
  XXl_LDAs <- read_more_LDAs_into_df_save_RDS("XXl", 1:10, 10)
  saveRDS(XXl_LDAs, "data/XXl_LDAs.rds")
}
# For "AWl"
if (!file.exists("data/AWl_LDAs.rds")) {
  AWl_LDAs <- read_more_LDAs_into_df_save_RDS("AWl", 1:10, 10)
  saveRDS(AWl_LDAs, "data/AWl_LDAs.rds")
}
# For "XXAW15"
if (!file.exists("data/XXAW15_LDAs.rds")) {
  XXAW15_LDAs <- read_more_LDAs_into_df_save_RDS("XXAW15", 1:10, 15)
  saveRDS(XXAW15_LDAs, "data/XXAW15_LDAs.rds")
}

# For "AWl"
AWl_LDAs <- readRDS("data/AWl_LDAs.rds")
AWl <- read_parquet("data/AWl.parquet")
AWl_LDAs |> filter(ll_per_word == max(ll_per_word))
AWl_LDAs |> filter(perplexity == min(perplexity))
# AWl Consistently model 10 is selected as best model

# For "XXl"
XXl_LDAs <- readRDS("data/XXl_LDAs.rds")
XXl <- read_parquet("data/XXl.parquet")
XXl_LDAs |> filter(ll_per_word == max(ll_per_word))
XXl_LDAs |> filter(perplexity == min(perplexity))
# XXl Consistently model 5 is selected as best model

# For "XXAW15"
XXAW15_LDAs <- readRDS("data/XXAW15_LDAs.rds")
XXAW15 <- read_parquet("data/XXAW.parquet")
XXAW15_LDAs |> filter(ll_per_word == max(ll_per_word))
XXAW15_LDAs |> filter(perplexity == min(perplexity))
# XXAW15 Consistently model 4 is selected as best model


## Comparing Topic Similarity

# Cosine Similarity
cossim <- function(A,B) (sum(A*B))/sqrt((sum(A^2))*(sum(B^2)))
# Kullback-Leibler divergence
KL <- function(A,B) sum(A * log(A/B))
# Jensen-Shannon divergence
JS <- function(A,B) (KL(A,(A+B)/2) + KL(B,(A+B)/2))/2

## Within LDA
df <- XXAW15_LDAs$topic_term_dists[[4]]
sim <- expand_grid(V = names(df), W = names(df)) |> 
 mutate(cossim = map2_dbl(V, W, ~cossim(df[[.x]], df[[.y]])), 
        KL = map2_dbl(V, W, ~KL(df[[.x]], df[[.y]])), 
        JS = map2_dbl(V, W, ~JS(df[[.x]], df[[.y]])))
sim |> select(V,W,cossim) |> pivot_wider(names_from = W, values_from = cossim) 
sim |> select(V,W,KL) |> pivot_wider(names_from = W, values_from = KL) 
sim |> select(V,W,JS) |> pivot_wider(names_from = W, values_from = JS) 

tibble(freq = df$T7, vocab = vocab_XXAW$Word) |> arrange(desc(freq)) |> head(10)
tibble(freq = df$T13, vocab = vocab_XXAW$Word) |> arrange(desc(freq)) |> head(10)
tibble(freq = df$T1, vocab = vocab_XXAW$Word) |> arrange(desc(freq)) |> head(10)

# 2 Strategies in pairwise comparisons to name topics
# 1. For each pair (i,j) of LDAs find for each topic in LDA i the most similar topic in LDA j
# Ideally this should result in a permutation of the topics in LDA i which is identical for the 
# permutation of the topics in LDA j in the pair (j,i)
# 2. For each pair (i,j) of LDA create a (0,1)-matrix of similarities through a threshold similarity
# The threshold could be below the lowest within LDA similarity

## Compare 2 LDAs
similar_topics <- function(df1, df2, measure = "JS", decision = "none", 
                           threshold = 0.1, as_matrix = FALSE) {
 # decision == "threshold": Topic v in LDA 1 is similar to topic w in LDA 2 
 # decision == "min": For Topic v in LDA 1 we select the topic w in LDA 2 which is most similar
 sim <- expand_grid(V = names(df1), W = names(df2)) |> 
  mutate(similarity = case_when(
   measure == "cossim" ~ map2_dbl(V, W, ~cossim(df1[[.x]], df2[[.y]])),
   measure == "KL" ~ map2_dbl(V, W, ~KL(df1[[.x]], df2[[.y]])),
   measure == "JS" ~ map2_dbl(V, W, ~JS(df1[[.x]], df2[[.y]]))),
   similarity = case_when(
    decision == "none" ~ similarity,
    decision == "threshold" ~ ifelse(similarity > threshold, 0, 1),
    decision == "min" ~ ifelse(similarity == min(similarity), 1, 0)),
   .by = 'V'
  )
 if(as_matrix) sim |> pivot_wider(names_from = W, values_from = similarity)
 else sim
}
sth <- similar_topics(XXAW15_LDAs$topic_term_dists[[4]], XXAW15_LDAs$topic_term_dists[[1]], 
               measure = "JS", decision = "threshold", threshold = 0.10, as_matrix = FALSE)
# This summary shows for each topic in LDA 1 
# the number of topics in LDA 4 which are similar (below threshold)
sth |> group_by(W) |> summarise(sum = sum(similarity)) #|> filter(sum > 0)
smin <- similar_topics(XXAW15_LDAs$topic_term_dists[[4]], XXAW15_LDAs$topic_term_dists[[1]], 
               measure = "JS", decision = "min", threshold = 0.1, as_matrix = FALSE) 
# This summary shows for each topic in LDA 1 
# the number of topics in LDA 4 which have it as most similar
smin |> group_by(W) |> summarise(sum = sum(similarity)) #|> filter(sum == 1)


simtop_vec <- function(LDA, i, j, decision = "threshold") similar_topics(LDA$topic_term_dists[[i]], LDA$topic_term_dists[[j]], 
               measure = "JS", decision = decision, threshold = 0.10, as_matrix = FALSE) |> 
 group_by(W) |> summarise(sum = sum(similarity)) |> rename(topic = W)
XXAW15_Top4SimThresh <- c(1:3,5:10) |> map(\(x) simtop_vec(XXAW15_LDAs, i = 4, j = x, decision = "threshold")) |> 
 reduce(left_join, by = "topic") |> set_names(c("topic", paste0("XXAW15_LDA", c(1:3,5:10)))) |> slice(c(1,8:15,2:7))
XXAW15_Top4SimThresh |> write_csv("data/XXAW15_Top4SimThresh.csv")
XXAW15_Top4SimMin <- c(1:3,5:10) |> map(\(x) simtop_vec(XXAW15_LDAs, i = 4, j = x, decision = "min")) |> 
 reduce(left_join, by = "topic") |> set_names(c("topic", paste0("XXAW15_LDA", c(1:3,5:10)))) |> slice(c(1,8:15,2:7))
XXAW15_Top4SimMin |> write_csv("data/XXAW15_Top4SimMin.csv")

XXAW15_Top4SimThresh |> summarise(across(starts_with("XXAW15_LDA"), ~sum(.x))) 
XXAW15_Top4SimMin |> summarise(across(starts_with("XXAW15_LDA"), ~sum(.x == 1)))
XXAW15_Top4SimMin |> summarise(across(starts_with("XXAW15_LDA"), ~sum(.x == 2)))
## row sum columns
XXAW15_Top4SimThresh |> mutate(sum = rowSums(select(XXAW15_Top4SimThresh, starts_with("XXAW15_LDA")) |> 
                                              mutate_all(~ifelse(.x == 1, 1, 0))))
XXAW15_Top4SimMin |> mutate(sum = rowSums(select(XXAW15_Top4SimMin, starts_with("XXAW15_LDA")) |> 
                                              mutate_all(~ifelse(.x == 1, 1, 0))))
