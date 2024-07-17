# LDA Topics Models in Posts from Antiwork and TwoXChromosomes


## Data: All posts, selected posts (\> 350 words), 3 corpora (Antiwork, TwoXChromosomes, Antiwork+TwoXChromosomes)

All posts from the subreddits
[Antiwork](https://www.reddit.com/r/antiwork/) and
[TwoXChromosomes](https://www.reddit.com/r/TwoXChromosomes/) have been
collected using the data dumps of pushshift in 2023. This includes post
from the very beginning of the subreddits until the end of 2022.

For both data sets we then selected relevant variables, in particular
the `title` string and the `selftext` string which is the post’s text.
We joined both stings into one sting and counted the words. Then we
selected only those posts where title and text together have more than
350 words (additionally posts should not be marked as removed from
reddit in the dataset). The strings in these texts where then used to
construct a corpus for the topic models. (That means we tokenized the
text and removed stop words with a slighlty customized selection of
words as documented in the script `tomotopy_create_corpus.py`.)

For **Antiwork** there were 292.352 posts in the raw data. 132.617 of
these have a non-empty seleftext. Combining title and selftext
**22.629** posts have more than 350 words and build the documents in the
Antiwork corpus. The number of words of the texts in the documents of
the corpus range from 351 to 7875 (with mean 629.4 and median 520
words).

For **TwoXChromosomes** there were 420.486 posts in the raw data.
239.744 of these have a non-empty seleftext. Combining title and
selftext **61.601** posts have more than 350 words and build the
documents in the TwoXChromosomes corpus. The number of words of the
texts in the documents of the corpus range from 351 to 7263 (with mean
613.4 and median 501 words).

Number of posts in Antiwork and TwoXChromosomes:

![](README_files/figure-commonmark/unnamed-chunk-2-1.png)

The number of posts in Antiwork before 2018 is quite low. Only
occasionally one per month ended up in our corpus:

![](README_files/figure-commonmark/unnamed-chunk-3-1.png)

Finally we combined the two corpora into one corpus
**Antiwork+TwoXChromosomes** with **84.230** documents.

The Antiwork corpus has a vocabulary of 26.704 words, the
TwoXChromosomes corpus has a vocabulary of 37.322 words and the combined
corpus has a vocabulary of 44.649 words.

## 10 LDA topic models for each corpus

We have created 10 topic models for each corpus (Antiwork,
TwoXChromosomes and Antiwork+TwoXChromosomes) using the LDA model
estimated with `tomotopy`. For the Antiwork and the TwoXChromosomes
corpus we estimated LDAs with 10 topics. For the combined corpus we
estimated LDAs with 15 topics.

The following table shows the links to the visualizations of the topics
of all LDAs constructed with `pyLDAvis`. The visualizations are
interactive and allow to explore the topics and the words in the topics.
There is a parameter $\lambda$ which can be adjusted to show the words
of the topics arranged by the most common words in the topic
($\lambda = 1$), by the most common words as a fraction of their
appearance in the whole corpus ($\lambda = 0$) or a mix between the two.
The links below show the topic’s words with $\lambda = 0.5$.

| Antiwork LDAs                                                                                              | TwoXChromosomes LDAs                                                                                            | Antiwork+TwoXChromosomes LDAs                                                                                               |
|------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| [Antiwork 1](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl1.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 1](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl1.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 1](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW151.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 2](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl2.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 2](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl2.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 2](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW152.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 3](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl3.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 3](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl3.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 3](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW153.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 4](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl4.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 4](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl4.html#topic=0&lambda=0.5&term=)     | [**Antiwork+TwoXChromosomes 4**](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW154.html#topic=0&lambda=0.5&term=) |
| [Antiwork 5](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl5.html#topic=0&lambda=0.5&term=)       | [**TwoXChromosomes 5**](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl5.html#topic=0&lambda=0.5&term=) | [Antiwork+TwoXChromosomes 5](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW155.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 6](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl6.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 6](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl6.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 6](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW156.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 7](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl7.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 7](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl7.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 7](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW157.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 8](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl8.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 8](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl8.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 8](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW158.html#topic=0&lambda=0.5&term=)     |
| [Antiwork 9](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl9.html#topic=0&lambda=0.5&term=)       | [TwoXChromosomes 9](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl9.html#topic=0&lambda=0.5&term=)     | [Antiwork+TwoXChromosomes 9](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW159.html#topic=0&lambda=0.5&term=)     |
| [**Antiwork 10**](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl10.html#topic=0&lambda=0.5&term=) | [TwoXChromosomes 10](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl10.html#topic=0&lambda=0.5&term=)   | [Antiwork+TwoXChromosomes 10](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW1510.html#topic=0&lambda=0.5&term=)   |

For each LDA perplexity scores and log-likelihood per word are
calculated. The numbers are shown in a table in the Appendix below. The
lower the perplexity and the higher the log-likelihood per word, the
better the model. Based on these numbers we can select the best fitting
LDA for each corpus. Consistently between the two measures, the best
fitting LDA for Antiwork is 10, for TwoXChromosomes it is 5, and for
Antiwork+TwoXChromosomes 4. Those are highlighted in the table above and
used as the main reference in the following.

The others LDAs serve to assess the robustness of the results because
LDAs tend to not be converging to exactly the same solution when run
again.

## Subreddit Identity Topics

For both subreddits one topic can be interpreted as the subreddit
identity topic.

### Antiwork

[Antiwork LDA 10, Topic
3](https://janlorenz.github.io/TopicModels_XX_Antiwork/AWl10.html#topic=3&lambda=0.5&term=)  
is about “we” “our” “us” “workers” “society” as top words and also has
the words “strike” “capitalism” “movement” and others in it. It is also
the topic with the word “we” scoring highest and by the context this
seems to relate to a collective “we” of the subreddit or a community
transcending it.

The Antiwork identity topic appears very similar as
[Antiwork+TwoXChromosomes 4, Topic
4](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW154.html#topic=4&lambda=0.5&term=)

### TwoXChromosomes

[TwoXChromosomes LDA 5, Topic
6](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXl5.html#topic=6&lambda=0.5&term=)  
is about “women” “men” “woman” “people” “male” as top words and also has
the words “feminism” “sexism” “trans” and others in it. The word “we” is
not in the top words (although it is also not marginal in the topic).
This is because other topics have the word “we” in it but these are the
topics about family and relationships where the context of the “we”
indicates that “we” relates to family or the relationship and not to a
group identity of the subreddit.

The TwoXChromosomes identity topic appears very similar in
[Antiwork+TwoXChromosomes 4, Topic
12](https://janlorenz.github.io/TopicModels_XX_Antiwork/XXAW154.html#topic=12&lambda=0.5&term=)

# FROM HERE WORK IN PROGESS

## Robustness of LDAs

So, many of the topics in LDA 4 have a one-to-one correspondence with
topics in many other LDAs. Typically 13 out of 15 topics from LDA4
appear in each other LDA (not always the same) as a clear one-to-one
correspondance. Over all other 9 LDA all topics in the majority of these
9 LDAs as a one-to-one correspondance with the topic in LDA4, often in 8
or 9 out of nine.

…

## Antiwork LDA 10

``` r
doc_topic <- AWl_LDAs$doc_topic_dists[[10]]
AW_top <- AW |> bind_cols(doc_topic)
AW_top |> mutate(year = year(created_time)) |> 
 group_by(year) |> summarise(across(paste0("T", 1:10), sum)) |> 
 pivot_longer(cols = paste0("T", 1:10), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:10))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 scale_fill_manual(values = pals::glasbey(10)) +
 labs(title = "Presence of topics over all documents by year")
```

![](README_files/figure-commonmark/unnamed-chunk-4-1.png)

## TwoXChromosomes LDA 10

``` r
doc_topic <- XXl_LDAs$doc_topic_dists[[5]]
XX_top <- XX |> bind_cols(doc_topic)
XX_top |> mutate(year = year(created_time)) |> 
 group_by(year) |> summarise(across(paste0("T", 1:10), sum)) |> 
 pivot_longer(cols = paste0("T", 1:10), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:10))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 scale_fill_manual(values = pals::glasbey(10)) +
 labs(title = "Presence of topics over all documents by year")
```

![](README_files/figure-commonmark/unnamed-chunk-5-1.png)

## Antiwork+TwoXChromosomes LDA 4: Topics and documents

Most topics are typical for one of the subreddits. (All this is for LDA
4.)

``` r
doc_topic <- XXAW15_LDAs$doc_topic_dists[[4]]
XXAW_top <- XXAW |> bind_cols(doc_topic)
XXAW_top |> group_by(subreddit) |> summarise(across(paste0("T", 1:15), sum)) |> 
 pivot_longer(cols = -subreddit, names_to = "topic", values_to = "count") |> 
 ggplot(aes(y=factor(topic, levels = paste0("T", 1:15)) |> fct_rev(), x=count, fill=subreddit)) + 
 geom_col(position = "stack") +
 facet_wrap(~subreddit) + labs(y = "", title = "Presence of topics over all documents by subreddit") + 
 guides(fill = "none")
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
XXAW_top |> arrange(desc(num_comments)) |> select(subreddit, everything()) |> head(20)
```

    # A tibble: 20 × 31
       subreddit author   created_time        created_day title selftext url   id   
       <chr>     <chr>    <dttm>              <chr>       <chr> <chr>    <chr> <chr>
     1 AW        This_Ma… 2021-11-30 18:19:42 Tuesday     "I j… "About … http… r5tn…
     2 AW        TheKitt… 2022-01-09 10:54:34 Sunday      "Put… "See ti… http… rzp7…
     3 AW        WaterFi… 2021-12-31 23:37:38 Friday      "I w… "Wat\n\… http… rt69…
     4 AW        Shaolin… 2022-06-27 18:06:12 Monday      "Piz… "I work… http… vm1s…
     5 AW        [delete… 2022-01-28 01:18:20 Friday      "Res… "Hello … http… seec…
     6 AW        eirfair  2021-11-11 13:16:38 Thursday    "I s… "EDIT: … http… qrl3…
     7 AW        Caterpi… 2022-12-14 13:32:32 Wednesday   "My … "Note: … http… zlr1…
     8 AW        [delete… 2021-12-11 13:29:04 Saturday    "Mod… "\\[**U… http… rdzs…
     9 AW        nowutz   2021-12-29 04:59:17 Wednesday   "Don… "I sobb… http… rqzp…
    10 AW        --Savat… 2022-04-01 21:01:11 Friday      "My … "I spen… http… tu1f…
    11 AW        Wide-Mu… 2022-02-27 07:22:20 Sunday      "Got… "I am c… http… t2ip…
    12 AW        simsacc… 2022-01-21 19:34:49 Friday      "The… "**PLEA… http… s9iv…
    13 AW        Ability… 2021-11-14 14:32:33 Sunday      "It … "It onl… http… qtqz…
    14 AW        endersg… 2022-06-25 11:38:42 Saturday    "The… "\\-Alm… http… vkd7…
    15 XX        Lionoras 2020-11-16 11:50:27 Monday      "No!… "Just b… http… jv5h…
    16 AW        Throwaw… 2022-01-12 22:11:09 Wednesday   "I a… "I saw … http… s2ig…
    17 AW        DrWarEa… 2022-01-02 15:06:28 Sunday      "The… "I don'… http… rubf…
    18 AW        [delete… 2022-01-06 20:20:46 Thursday    "The… "Throwa… http… rxny…
    19 AW        BilbosB… 2021-10-27 18:58:34 Wednesday   "Fir… "This s… http… qh3u…
    20 AW        i_love_… 2021-12-24 12:29:03 Friday      "Doe… "It's k… http… rnld…
    # ℹ 23 more variables: num_comments <dbl>, score <dbl>, upvote_ratio <dbl>,
    #   ups <dbl>, downs <dbl>, removed_by_category <chr>, title_text <chr>,
    #   num_words <int>, T1 <dbl>, T2 <dbl>, T3 <dbl>, T4 <dbl>, T5 <dbl>,
    #   T6 <dbl>, T7 <dbl>, T8 <dbl>, T9 <dbl>, T10 <dbl>, T11 <dbl>, T12 <dbl>,
    #   T13 <dbl>, T14 <dbl>, T15 <dbl>

``` r
XXAW_top |> mutate(year = year(created_time)) |> 
 group_by(year) |> summarise(across(paste0("T", 1:15), sum)) |> 
 pivot_longer(cols = paste0("T", 1:15), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:15))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 scale_fill_manual(values = pals::glasbey(15)) +
 labs(title = "Presence of topics over all documents by year")
```

![](README_files/figure-commonmark/unnamed-chunk-8-1.png)

``` r
XXAW_top |> mutate(year = year(created_time)) |> 
 group_by(year) |> summarise(across(paste0("T", 1:15), mean)) |> 
 pivot_longer(cols = paste0("T", 1:15), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:15))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 scale_fill_manual(values = pals::glasbey(15)) +
 labs(title = "Relative frequency of topics over all documents by year")
```

![](README_files/figure-commonmark/unnamed-chunk-9-1.png)

``` r
XXAW_top |> mutate(year = year(created_time)) |> 
 group_by(year,subreddit) |> summarise(across(paste0("T", 1:15), sum)) |> 
 pivot_longer(cols = paste0("T", 1:15), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:15))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 facet_wrap(~subreddit, ncol = 1, scales = "free_y") +
 scale_fill_manual(values = pals::glasbey(15)) +
 labs(title = "Presence of topics over all documents by year and subreddit")
```

    `summarise()` has grouped output by 'year'. You can override using the
    `.groups` argument.

![](README_files/figure-commonmark/unnamed-chunk-10-1.png)

``` r
XXAW_top |> mutate(year = year(created_time)) |> 
 group_by(year,subreddit) |> summarise(across(paste0("T", 1:15), mean)) |> 
 pivot_longer(cols = paste0("T", 1:15), names_to = "topic", values_to = "count") |>
 mutate(topic = factor(topic, levels = paste0("T", 1:15))) |> 
 ggplot(aes(x = year, y = count, fill=topic)) + 
 geom_col(position = "stack") +
 facet_wrap(~subreddit, ncol = 1, scales = "free_y") +
 scale_fill_manual(values = pals::glasbey(15)) +
 labs(title = "Relative frequency of topics over all documents by year and subreddit")
```

    `summarise()` has grouped output by 'year'. You can override using the
    `.groups` argument.

![](README_files/figure-commonmark/unnamed-chunk-11-1.png)

## Users

All users with more than 10 posts in the dataset are shown below.

``` r
XXAW |> count(subreddit, author, sort = TRUE)  |> filter(n > 10) |> arrange(subreddit) |> kable()
```

| subreddit | author               |     n |
|:----------|:---------------------|------:|
| AW        | \[deleted\]          |   649 |
| AW        | *Raspootin*          |    39 |
| AW        | Nickzreg             |    25 |
| AW        | capnbarky            |    22 |
| AW        | Send_Me_Bee_Stuff    |    16 |
| AW        | BadassPlaya2517      |    15 |
| AW        | ournextarc           |    13 |
| AW        | Waja_wurr90          |    12 |
| AW        | Wilsthing1988        |    11 |
| AW        | jcrosse1917          |    11 |
| AW        | nobodynewknew        |    11 |
| XX        | \[deleted\]          | 10386 |
| XX        | AceZeroXYZ           |    40 |
| XX        | carlinha1289         |    31 |
| XX        | Help_Me_Reddit01     |    29 |
| XX        | Murtlepos            |    27 |
| XX        | Lionoras             |    24 |
| XX        | shygirlturnedsassy   |    20 |
| XX        | superpony123         |    20 |
| XX        | MagzalaAstrallis     |    19 |
| XX        | bunnydigs            |    19 |
| XX        | throwaway99111123    |    18 |
| XX        | Franchesca8899       |    17 |
| XX        | PinkGreyGirl         |    17 |
| XX        | rejs7                |    17 |
| XX        | MisogynyisaDisease   |    16 |
| XX        | SilverScreen2019     |    16 |
| XX        | zazzlekdazzle        |    16 |
| XX        | Crystal_wolf04       |    15 |
| XX        | newprofilewhodis1352 |    15 |
| XX        | Some-call-me-ada     |    14 |
| XX        | Bluellan             |    13 |
| XX        | PurpleFlame8         |    13 |
| XX        | VisionsOfLife        |    13 |
| XX        | catniagara           |    13 |
| XX        | depressedkittyfr     |    13 |
| XX        | irishtrashpanda      |    13 |
| XX        | lil_staal            |    13 |
| XX        | Easteuroblondie      |    12 |
| XX        | ScrumptiousCookie123 |    12 |
| XX        | callmekanga          |    12 |
| XX        | tama_gotchi          |    12 |
| XX        | Soft_Reference_6490  |    11 |
| XX        | monieo               |    11 |

These are users who posted in both subreddits. Shown are the twenty
users with most posts in both subreddits.

``` r
XXusers <- XXAW |> filter(subreddit == "XX") |> count(author, name = "XX_n") 
AWusers <- XXAW |> filter(subreddit == "AW")  |> count(author, name = "AW_n")
XXusers |> inner_join(AWusers, by = "author") |> arrange(desc(XX_n + AW_n)) |> write_csv("XXAWusers.csv")
XXusers |> inner_join(AWusers, by = "author") |> arrange(desc(XX_n + AW_n)) |> head(20) |> kable()
```

| author               |  XX_n | AW_n |
|:---------------------|------:|-----:|
| \[deleted\]          | 10386 |  649 |
| newprofilewhodis1352 |    15 |    4 |
| catniagara           |    13 |    3 |
| tempted_temptress    |     9 |    6 |
| Easteuroblondie      |    12 |    2 |
| Minute-Jello-1919    |     1 |    9 |
| CurrentSingleStatus  |     5 |    4 |
| Delta4o              |     6 |    3 |
| Marblue              |     8 |    1 |
| annieduty            |     2 |    7 |
| braveguppy           |     5 |    3 |
| copper_rainbows      |     7 |    1 |
| krazyforlove         |     7 |    1 |
| BakerLovePie         |     6 |    1 |
| Larry-Man            |     6 |    1 |
| LongNectarine3       |     6 |    1 |
| Petallic             |     4 |    3 |
| super_soprano13      |     6 |    1 |
| EQOA_Fanatic         |     1 |    5 |
| MandrakeThePancake   |     5 |    1 |

``` r
AceZeroXYZ <- XXAW_top |> filter(author == "AceZeroXYZ") |> 
 select(subreddit, created_time, created_day, url, title, url, num_comments, score, 
        T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, selftext) 
write_csv(AceZeroXYZ, "AceZeroXYZ.csv")
```

## Appendix

### Perplexity and log-likelihood per word for all LDA models

| LDA                | Perplexity | Log-likelihood per word |
|:-------------------|-----------:|------------------------:|
| Antiwork 1         |   6004.324 |               -8.700235 |
| Antiwork 2         |   6034.415 |               -8.705234 |
| Antiwork 3         |   5989.324 |               -8.697734 |
| Antiwork 4         |   6037.625 |               -8.705766 |
| Antiwork 5         |   6026.343 |               -8.703896 |
| Antiwork 6         |   6033.344 |               -8.705057 |
| Antiwork 7         |   6052.660 |               -8.708253 |
| Antiwork 8         |   6009.007 |               -8.701015 |
| Antiwork 9         |   5952.494 |               -8.691566 |
| Antiwork 10        |   5917.345 |               -8.685643 |
| TwoXChromosomes 1  |   5902.384 |               -8.683112 |
| TwoXChromosomes 2  |   5863.708 |               -8.676537 |
| TwoXChromosomes 3  |   5910.039 |               -8.684408 |
| TwoXChromosomes 4  |   5976.158 |               -8.695533 |
| TwoXChromosomes 5  |   5827.158 |               -8.670285 |
| TwoXChromosomes 6  |   5856.752 |               -8.675351 |
| TwoXChromosomes 7  |   5855.450 |               -8.675128 |
| TwoXChromosomes 8  |   5857.814 |               -8.675532 |
| TwoXChromosomes 9  |   5830.822 |               -8.670913 |
| TwoXChromosomes 10 |   5889.506 |               -8.680927 |
| XXAW151            |   6401.640 |               -8.764309 |
| XXAW152            |   6496.871 |               -8.779076 |
| XXAW153            |   6388.455 |               -8.762248 |
| XXAW154            |   6290.604 |               -8.746812 |
| XXAW155            |   6394.564 |               -8.763203 |
| XXAW156            |   6402.499 |               -8.764444 |
| XXAW157            |   6425.186 |               -8.767981 |
| XXAW158            |   6421.309 |               -8.767377 |
| XXAW159            |   6378.506 |               -8.760689 |
| XXAW1510           |   6412.032 |               -8.765932 |
