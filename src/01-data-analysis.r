library(tidyverse)

school_data <- read.csv("~/nyc-schools-survey-analysis/data/clean-data/school-data.csv")

# PROCESSING dataset with necessary info for q1 and q2
school_data_question <- school_data %>% 
  select(c(-X, -num.of.sat.test.takers, -c(6:9), -total_enrollment, -selfcontained_num, -total.cohort, -lat, -long, -d75, -c(41:44))) %>% # removing unnecessary columns
  rowwise() %>% 
  mutate(
    avg_p = mean(c_across(saf_p_11: aca_p_11), 1), # average parent score
    avg_t = mean(c_across(saf_t_11: aca_t_11), 1), # average teacher score 
    avg_s = mean(c_across(saf_s_11: aca_s_11), 1), # average student score
    avg_saf = mean(c_across(starts_with("saf")), 1), #average saf score
    avg_com = mean(c_across(starts_with("com")), 1), #average com score
    avg_eng = mean(c_across(starts_with("eng")), 1), #average eng score
    avg_aca = mean(c_across(starts_with("aca")), 1), #average aca score
  )

# QUESTION 1 (q1)

#correlation matrix (converted as data frame)
cor_df <- school_data_question %>% 
  select(where(is.numeric)) %>%
  cor(use = "pairwise.complete.obs") %>%
  round(3) %>% 
  as_tibble(rownames = "variable") %>% 
  select(variable,avg_sat_score) %>% 
  filter(avg_sat_score >= 0.2 | avg_sat_score <= -0.2)

#create scatter and investigate


# Question2 (q2)

#graphs
graph1 <- school_data_question %>%
  drop_na(boro) %>%
  pivot_longer(cols = 29:31,
               names_to = "avg_group",
               values_to = "values") %>%
  ggplot(aes(x = boro, y = values, fill = avg_group)) +
  geom_boxplot() +
  labs(
    title = "Average perception on safety, respect, communication, engagement and\nacademic expectations on NYC schools",
    x = "Borough",
    y = "Response (0-10)"
  ) +
  scale_fill_manual(
    name = "Response Group",
    values = c("red", "green", "blue"),
    breaks = c("avg_p", "avg_t", "avg_s"),
    labels = c("Parents", "Teachers", "Students")
  )

graph2 <- school_data_question %>%
  drop_na(boro) %>%
  pivot_longer(cols = 32:35,
               names_to = "avg_category",
               values_to = "values") %>%
  ggplot(aes(x = boro, y = values, fill = avg_category)) +
  geom_boxplot() +
  labs(
    title = "Average perception by parents, teachers and students on different aspects\nof NYC schools",
    x = "Borough",
    y = "Response (0-10)"
  ) +
  scale_fill_manual(
    name = "Categories",
    values = c("red", "green", "blue", "yellow"),
    breaks = c("avg_saf", "avg_com", "avg_eng", "avg_aca"),
    labels = c("Safety and Respect", "Communication", "Engagement", "Academic Expectations")
  )

