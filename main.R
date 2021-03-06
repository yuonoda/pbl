library(dplyr)
rawdata <- read.csv("rawdata.csv")

# 不要な変数を指定して削除する
# F3: 都道府県はすべて同じなので除外した
# F9: 学生は1名のみなので除外した
excluded_vars <- c("SAMPLEID", "clid", "F3", "F9")
data <- select(rawdata, -excluded_vars)

# 2値変数を0か1にする
data$TARGET <- ifelse(data$TARGET == 1, as.integer(1), as.integer(0)) #居住者:1, 非居住者:0
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
# F8_1 = 公務員 ~ F8_12 = 無職として、会社員(事務系)を基準として除外する
for (i in 1:12) {
  # 会社員(事務系)を除外
  if (i == 3) { next }

  # ダミー変数名を作る
  var <- paste0('F8_', i)


  # そのダミー変数の値と一致するときに1、そうでなければ0
  data[var] <- ifelse(data$F8 == i, as.integer(1), as.integer(0))
}
data <- select(data, -"F8")

# # 居住区をダミー変数にする
# # SC1_1 = 鶴見区 ~ SC1_18 = 瀬谷区 として、金沢区は基準として除外する
# for (i in 1:18) {
#
#   # 金沢区を基準として除外する
#   if (i == 10) { next }
#
#   # ダミー変数名を作る
#   var <- paste0("SC1_",i)
#
#   # そのダミー変数の値と一致するときに1、そうでなければ0
#   data[var] <- ifelse(data$SC1 == i, as.integer(1), as.integer(0))
# }
data <- select(data, -"SC1")

View(data)
glm(TARGET ~ . - F2S1N - F1 - F4 - F5 - F6 - F7 - F8_1 - F8_8 - F8_10 - F8_12 - F8_9
  - Q2 - Q3 - Q6 - Q9 - Q10 - Q12 - Q13  - Q16 -Q17 - Q18 - Q19 - Q20 - Q21 - Q22 - Q23 - Q24 - Q25 - Q26 - Q27 - Q28 - Q29 - Q30 - Q31  - Q32 - Q33 - Q34 - Q35 - Q36 ,
    data=data, family="binomial")