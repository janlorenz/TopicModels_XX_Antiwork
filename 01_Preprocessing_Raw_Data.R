library(tidyverse)
library(glue)
library(arrow)

## Post dataset XX.csv.gz and Antiwork.csv.gz are from subreddits antiwork and twoXchromosomes
# It has been retrieved from pushshift

xx_raw <- read_csv("data/XX.csv.gz") # 420.486 posts
xx_raw |> filter(!is.na(selftext)) |> nrow() # 239.744 have post text which is not NA
#xx_raw_no_na <- xx_raw %>% select_if(~sum(!is.na(.)) > 0) # This remove columns which are all NA
xx <- xx_raw |> 
 select(author, created_time, created_day, title, selftext, url, id, 
        num_comments, score, upvote_ratio, ups, downs, removed_by_category) |> 
 mutate(title_text = paste(title, replace_na(selftext, ""), sep = " "), # make a new variable title_text with title and selftext together
        num_words = str_count(title_text, '\\w+')) # count the words of the title_text
xx$num_words |> summary()
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0    13.0    69.0   166.2   229.0  7263.0 
xx |> filter(num_words > 350, is.na(removed_by_category)) |> nrow() # 61.601 posts have more than 350 words and are not removed
xx |> filter(num_words > 350, is.na(removed_by_category)) |> pull(num_words) |> summary() 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 351.0   419.0   520.0   629.4   712.0  7263.0 
xx |> filter(num_words > 350, is.na(removed_by_category)) |> 
 write_parquet("data/XXl.parquet")
system("python3 tomotopy_create_corpus.py 'XXl'") # Write a corpus (tokenization) using the python script tomotopy_create_corpus.py

aw_raw <- read_csv("data/AW.csv.gz") # 292.352 posts
aw_raw |> filter(!is.na(selftext)) |> nrow() # 132.617 posts
aw <- aw_raw |> 
 select(author, created_time, created_day, title, selftext, url, id, 
        num_comments, score, upvote_ratio, ups, downs, removed_by_category) |> 
 mutate(title_text = paste(title, replace_na(selftext, ""), sep = " "),
        num_words = str_count(title_text, '\\w+'))
#aw_raw_no_na <- aw_raw %>% select_if(~sum(!is.na(.)) > 0) # This remove columns which are all NA
aw$num_words |> summary()
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0     9.0    25.0   107.5   136.0  7875.0 
aw |> filter(num_words > 350, is.na(removed_by_category)) |> nrow() # 22.629 posts have more than 350 words and are not removed
aw |> filter(num_words > 350, is.na(removed_by_category)) |> pull(num_words) |> summary()
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 351.0   411.0   501.0   613.4   678.0  7875.0 
aw |> filter(num_words > 350, is.na(removed_by_category)) |> 
 write_parquet("data/AWl.parquet")
system("python3 tomotopy_create_corpus.py 'AWl'")

# Write counts for posts monthly
bind_row(
 xx |> mutate(`Time (monthly)`= floor_date(created_time, "month")) |> 
  group_by(`Time (monthly)`) |> summarise(`All posts` = n(), `Posts in corpus` = sum(num_words > 350 & is.na(removed_by_category))) |> 
  pivot_longer(cols = c(`All posts`, `Posts in corpus`), names_to = "Type", values_to = "Count") |> 
  mutate(Subreddit = "TwoXChromosomes"), 
 aw |> mutate(`Time (monthly)`= floor_date(created_time, "month")) |> 
  group_by(`Time (monthly)`) |> summarise(`All posts` = n(), `Posts in corpus` = sum(num_words > 350 & is.na(removed_by_category))) |> 
  pivot_longer(cols = c(`All posts`, `Posts in corpus`), names_to = "Type", values_to = "Count") |> 
  mutate(Subreddit = "Antiwork")
) |> write_csv("data/XXAW_count_posts.csv")


## Combined corpus
XXAW <- bind_rows(read_parquet("data/AWl.parquet") |> mutate(subreddit = "AW"),
                  read_parquet("data/XXl.parquet") |> mutate(subreddit = "XX"))
XXAW |> write_parquet("data/XXAW.parquet")
system("python3 tomotopy_create_corpus.py 'XXAW'")