library(tidyverse)

# importing raw data
combined <- read.csv("data/raw-data/combined.csv")
general <- read_tsv("data/raw-data/masterfile11_gened_final.txt")
district <- read_tsv("data/raw-data/masterfile11_d75_final.txt")
