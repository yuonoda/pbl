library(dplyr)
rawdata <- read.csv("rawdata.csv")

# 不要な変数を指定して削除する
# F3: 都道府県はすべて同じなので除外した
# F9: 学生は1名のみなので除外した
excluded_vars <- c("SAMPLEID", "clid", "F3", "F9")
data <- select(rawdata, -excluded_vars)

# 2値変数を0か1にする
data$TARGET <- as.integer(data$TARGET - 1) #居住者:0, 非居住者:1
data$F1 <- as.integer(data$F1 - 1) # 男:0, 女:1
data$F4 <- as.integer(data$F4 - 1) # 未婚:0, 既婚:1
data$F5 <- as.integer(data$F5 - 1) # 子なし:0, 子あり:1

# 欠損値の整理
# わからない・無回答などの回答を欠損値として、値を順序尺度として扱えるようにする
for (i in 1:nrow(data)) {
    # 世帯年収
    if (data$F6[i] == 10) {
      data$F6[i] <- NA
    }

    # 個人年収
    if (is.na(data$F7[i]) | data$F7[i] == 10) {
      data$F7[i] <- NA
    }
}

# 職業の回答をダミー変数にする

# 居住区をダミー変数にする

View(data)