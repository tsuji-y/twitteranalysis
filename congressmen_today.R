###############パッケージの読み込み###############
library(rtweet)
library(tidyverse)
library(readtext)
library(quanteda)

###############リスト内部のデータを取得###############
id <- lists_users("Sale6891699293") %>% # リストからツイートを取得
  filter(name=="congressmen_116") %>%
  .$list_id


today <- Sys.Date() #今日の日付を取得
tweets <- lists_statuses(id, n = 200, include_rts = TRUE)

dat_today <- tweets %>% # 今日のツイートを収集
  filter(as.Date(as.POSIXct(tweets$created_at), foramt="%Y/%m/%d") == today)


tw_corp <- corpus(dat_today) # コーパスの作成
tw_toks <- tokens(tw_corp, remove_punct = TRUE) # トークン化
tw_dfm <- dfm(tw_toks, remove = stopwords()) # dfmの作成
textplot_wordcloud(tw_dfm, max_words = 100) # ワードクラウドを描画