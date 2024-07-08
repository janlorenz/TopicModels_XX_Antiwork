library(tidyverse)
library(glue)
library(arrow)

## Post dataset XX.csv.gz and Antiwork.csv.gz are from subreddits antiwork and twoXchromosomes
# It has been retrieved from pushshift

xx_raw <- read_csv("data/XX.csv.gz")
xx <- xx_raw |> 
 select(author, created_time, created_day, title, selftext, url, id, 
        num_comments, score, upvote_ratio, ups, downs, removed_by_category) |> 
 mutate(title_text = paste(title, replace_na(selftext, ""), sep = " "),
        num_words = str_count(title_text, '\\w+'))
xx |> filter(num_words > 350, is.na(removed_by_category)) |> 
 write_parquet("data/XXl.parquet")
system("python3 tomotopy_create_corpus.py 'XXl'")

aw_raw <- read_csv("data/AW.csv.gz")
aw <- aw_raw |> 
 select(author, created_time, created_day, title, selftext, url, id, 
        num_comments, score, upvote_ratio, ups, downs, removed_by_category) |> 
 mutate(title_text = paste(title, replace_na(selftext, ""), sep = " "),
        num_words = str_count(title_text, '\\w+'))
aw |> filter(num_words > 350, is.na(removed_by_category)) |> 
 write_parquet("data/AWl.parquet")
aw |> filter(num_words > 175, is.na(removed_by_category)) |> 
 write_parquet("data/AWll.parquet")
system("python3 tomotopy_create_corpus.py 'AWll'")

XXAW <- bind_rows(read_parquet("data/AWl.parquet") |> mutate(subreddit = "AW"),
                  read_parquet("data/XXl.parquet") |> mutate(subreddit = "XX"))
XXAW |> write_parquet("data/XXAW.parquet")
system("python3 tomotopy_create_corpus.py 'XXAW'")

XXAWl <- bind_rows(read_parquet("data/AWll.parquet"),read_parquet("data/XXl.parquet"))
XXAWl |> write_parquet("data/XXAWl.parquet")
system("python3 tomotopy_create_corpus.py 'XXAWl'")
