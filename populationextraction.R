
# Load the readr package for reading CSV files
library(readr)

# Specify the path to your CSV file
file_path <- "~/Documents/SDS 270 /VisionZeroProject/vision0/VisionZeroProject/Population data/QuickFacts Dec-04-2023.csv"

# Read the CSV file into a dataframe, using a more descriptive variable name
population_df <- read_csv(file_path)

# Extract the Boston city population and create a new dataframe
# Ensure the column name matches exactly as in your CSV file
bos_population_data <- data.frame(BostonPopulation = population_df[1, "Boston city, Massachusetts"])

# Print the new dataframe with Boston city population
print(bos_population_data)


# Load required libraries
library(readr)
library(dplyr)
library(ggplot2)

# Reading the Boston population data
population_df <- read_csv("~/Documents/SDS 270 /VisionZeroProject/vision0/VisionZeroProject/Population data/QuickFacts Dec-04-2023.csv")
boston_population <- as.numeric(gsub(",", "", population_df[1, "Boston city, Massachusetts"]))

# Process the fatality data s
boston_url <- "https://data.boston.gov/dataset/d326a4e3-75f2-42ac-9b32-e2920566d04c/resource/92f18923-d4ec-4c17-9405-4e0da63e1d6c/download/tmp1u21fr8k.csv"
destfile1 <- "/Users/jeniahfranco/Documents/SDS 270 /VisionZeroProject/vision0/VisionZeroProject/boston_data.csv"
download.file(boston_url, destfile1)
boston_data <- read.csv(destfile1)
clean_boston <- boston_data %>% select(1) 
clean_boston$date_time <- substr(clean_boston$date_time, 1, 4)
sum_boston <- clean_boston %>%
  group_by(date_time) %>%
  summarise(total_fatal = n()) %>%
  mutate(city = "Boston")

# Calculate proportion of fatalities per capita
proportion_data <- sum_boston %>% 
  mutate(proportion_fatal = total_fatal / boston_population * 100)

# Visualization
ggplot(proportion_data, aes(x = date_time, y = proportion_fatal, group = 1)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "Yearly Proportion of Fatalities in Boston",
       x = "Year",
       y = "Fatalities per Capita (%)")




