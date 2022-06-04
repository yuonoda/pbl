rawdata <- read.csv("rawdata.csv")
# View(rawdata)
str(rawdata)

is_living <- vector()
sex <- vector()
age <- vector()
is_married <- vector()
has_child <- vector()
family_income <- vector()
personal_income <- vector()
# ocupation <- vector()
# occupation_vectors <- []verctor()
student_type <- vector()
# ward <- vector()
ward_vectors <- list()

# 回答
qol_expectation <- vector()
peace_expectation <- vector()
exercise_expectation <- vector()
activeity_expectation <- vector()

# TODO　ダミーデータ化　職業、居住区

# data <- data.frame()
# data$Q1 <- rawdata$Q1

for (i in 1:nrow(rawdata)) {

  # 居住の目的変数を作成
  if (rawdata$TARGET[i] == "2") {
    is_living <- c(is_living, 0)
  } else {
    is_living <- c(is_living, 1)
  }

  # 性別
  if (rawdata$F1[i] == "2") {
    sex <- c(sex, 0) # 女性 = 0
  } else {
    sex <- c(sex, 1)
  }

  # 年齢
  age <- c(age, rawdata$F2S1N[i])

  # 都道府県
  # 全員神奈川なのでスキップ

  #未婚既婚
  if (rawdata$F4[i] == 1) {
    is_married <- c(is_married, 0)
  }else {
    is_married <- c(is_married, 1)
  }

  #子ども
  if (rawdata$F5[i] == 1) {
    has_child <- c(has_child, 0)
  }else {
    has_child <- c(has_child, 1)
  }

  #世帯収入
  family_income_element <- as.numeric(rawdata$F6[i]) - 1
  if (rawdata$F6[i] == "10") {
    family_income_element <- NA
  }
  family_income <- c(family_income, family_income_element)

  # 個人年収
  personal_income_element <- as.numeric(rawdata$F7[i]) - 1
  if (is.na(rawdata$F7[i]) || rawdata$F7[i] == "10") {
    personal_income_element <- NA
  }
  personal_income <- c(personal_income, personal_income_element)

  # 職業
  # TODO　なんかえらーになる
  # occupation_element <- as.numeric(rawdata$F8[i]) - 1
  # occupation <- c(occupation, occupation_element)
  # for (j in 0:as.numeric(rawdata$F8[i]) - 1) {
  #
  # }

  # 学生区分
  # 回答者が一人しかいないのでスキップ

  # 居住区
  ward_element <- as.numeric(rawdata$SC1[i]) - 1
  ward <- c(ward, ward_element)

  # 豊かな自然によるQOL上昇期待
  qol_expectation <- c(qol_expectation, as.numeric(rawdata$Q1[i]) - 1)

  # 豊かな自然による安らか期待
  peace_expectation <- c(peace_expectation, as.numeric(rawdata$Q2[i]) - 1)

  # 豊かな自然による運動・健康期待
  exercise_expectation <- c(exercise_expectation, as.numeric(rawdata$Q3[i]) - 1)

  # 豊かな自然によるアクティビティ期待
  activeity_expectation <- c(activeity_expectation, rawdata$Q4[i])

}

# data <- data.frame(
#   is_living,
#   sex,
#   age,
#   is_married,
#   has_child,
#   family_income,
#   personal_income,
#   # ward,
#   qol_expectation,
#   peace_expectation,
#   exercise_expectation,
#   activeity_expectation
# )

View(data)
# result <- glm(is_living ~ ., family = "binomial", data = data)
# step.model <- step(result)

