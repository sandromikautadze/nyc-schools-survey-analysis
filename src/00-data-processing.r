library(tidyverse)

# IMPORTING raw data
combined <- read.csv("data/raw-data/combined.csv")
general <- read_tsv("data/raw-data/masterfile11_gened_final.txt")
district <- read_tsv("data/raw-data/masterfile11_d75_final.txt")

# CLEANING 
general_reduced <- general %>%
  select(1:32) %>% #keeping aggregate data columns
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr")) %>% # removing rate columns
  filter(schooltype == "High School") # keeping high school rows
district_reduced <- district %>%
  select(1:32) %>%
  select(-starts_with("rr"), -starts_with("N"), -starts_with("nr")) %>%
  filter(studentssurveyed == "Yes")
combined_reduced <- combined %>%
  select(-c(4:6)) #removing columns on specific SAT section scores

# renaming column names lower case and underscore separated (just personal preference)
colnames(combined_reduced) <- colnames(combined_reduced) %>% str_to_lower()

# combining by rows general and district into a new data frame
survey <- bind_rows(general_reduced, district_reduced)

# removing columns after NA-value inspection
survey <- survey %>% select(-highschool)
combined_reduced <- combined_reduced %>% select(c(-number.of.exams.with.scores.3.4.or.5, high_score_percent))

# joining data frames
school_data_raw <- combined_reduced %>% left_join(survey, by = "dbn")
# final cleaning
school_data <- school_data_raw %>%
  select(c(-bn, -schoolname, -schooltype, -studentssurveyed))

#saving dataset in project folder
write.csv(school_data, "~/nyc-schools-survey-analysis/data/clean-data/school-data.csv")


