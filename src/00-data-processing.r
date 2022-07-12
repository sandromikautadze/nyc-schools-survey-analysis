library(tidyverse)

# IMPORTING raw data
combined <- read.csv("data/raw-data/combined.csv")
general <- read_tsv("data/raw-data/masterfile11_gened_final.txt")
district <- read_tsv("data/raw-data/masterfile11_d75_final.txt")

# CLEANING 
# keeping columns on aggregate survey responses on the 4 categories and removing
# columns on number of respondents, rates, etc.
general_reduced <- general %>%
  select(1:32) %>% #keeping aggregate data columns
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr")) #removing rate columns
district_reduced <- district %>%
  select(1:32) %>%
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr"))