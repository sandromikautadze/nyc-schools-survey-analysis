library(tidyverse)

# IMPORTING raw data
combined <- read.csv("data/raw-data/combined.csv")
general <- read_tsv("data/raw-data/masterfile11_gened_final.txt")
district <- read_tsv("data/raw-data/masterfile11_d75_final.txt")

# CLEANING 
general_reduced <- general %>%
  select(1:32) %>% #keeping aggregate data columns
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr")) %>% # removing rate columns
  filter(schooltype %in% c("Middle / High School", "High School", "Elementary / Middle / High School")) # keeping high school rows
district_reduced <- district %>%
  select(1:32) %>%
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr"))
combined_reduced <- combined %>%
  select(-c(4:6)) #removing columns on specific SAT section scores

# renaming column names lower case and underscore separated (just personal preference)
colnames(combined_reduced) <- colnames(combined_reduced) %>% str_to_lower()

