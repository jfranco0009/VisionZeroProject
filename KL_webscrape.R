# Denver Webscraping 

# url
dv_url <- "https://www.denvergov.org/media/gis/DataCatalog/traffic_accidents/csv/traffic_accidents.csv"

# destination file

dest1 <- "/Users/kristinele/Documents/VisionZero/VisionZero/denver_data.csv"

# download file

options(timeout = 120)

download.file(dv_url, dest1)

dv_data <- read.csv("denver_data.csv")

# cleaning

library(dplyr)

clean_dv <- dv_data |> select(3,42) |> filter(FATALITIES != 0)

clean_dv$incident_id <- as.character(clean_dv$incident_id)

clean_dv$year <- substr(clean_dv$incident_id, 1, 4)

sum_dv <- clean_dv |> group_by(year) |> summarise(total_fatal = sum(FATALITIES)) |> mutate(city = "Denver")

# NYC Webscraping 

# url
nyc_url <- "https://data.cityofnewyork.us/api/views/h9gi-nx95/rows.csv?date=20231129&accessType=DOWNLOAD"

# destination file

dest2 <- "/Users/kristinele/Documents/VisionZero/VisionZero/nyc_data.csv"

# download file

download.file(nyc_url, dest2)

nyc_data <- read.csv("nyc_data.csv")

# cleaning

clean_nyc <- nyc_data |> select(1, 12) |> filter(NUMBER.OF.PERSONS.KILLED != 0)

clean_nyc$CRASH.DATE<- as.character(clean_nyc$CRASH.DATE)

clean_nyc$year <- substr(clean_nyc$CRASH.DATE, 7, 10)

sum_nyc <- clean_nyc |> group_by(year) |> summarise(total_fatal = sum(NUMBER.OF.PERSONS.KILLED)) |> mutate(city = "NYC")

# Binding data for Denver and NYC

sum_dv_nyc <- rbind(sum_dv, sum_nyc)
