#BOSTON
# Define URL
boston_url <- "https://data.boston.gov/dataset/d326a4e3-75f2-42ac-9b32-e2920566d04c/resource/92f18923-d4ec-4c17-9405-4e0da63e1d6c/download/tmp1u21fr8k.csv"

# Define destination for file
destfile1 <- "/Users/jeniahfranco/Documents/SDS 270 /VisionZeroProject/vision0/VisionZeroProject/boston_data.csv"


#download file and save in specified destination
options(timeout = 240)
download.file(boston_url, destfile1)

# Naming Data
boston_data <- read.csv("boston_data.csv")
# cleaning
library(dplyr)
clean_boston <- boston_data|> select(1, )
clean_boston$date_time <- substr(clean_boston$date_time, 1, 4)
sum_boston<- clean_boston |>
  group_by(date_time) |>
  summarise(total_fatal = n()) |>
  mutate(city = "Boston")





