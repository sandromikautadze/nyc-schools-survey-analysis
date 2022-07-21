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

#correlation matrix (converted to data frame)
cor_df <- school_data_question %>% 
  select(where(is.numeric)) %>%
  cor(use = "pairwise.complete.obs") %>%
  round(3) %>% 
  as_tibble(rownames = "variable") %>% 
  select(variable,avg_sat_score) %>% 
  filter(avg_sat_score >= 0.2 | avg_sat_score <= -0.2)

#graphs
#sat score per borough - bar chart
graph1 <- school_data_question %>% 
  drop_na(boro) %>% 
  group_by(boro) %>% 
  summarise(avg = mean(avg_sat_score, na.rm = TRUE)) %>%
  ggplot(aes(x = boro, y = avg, fill = boro)) +
  geom_col() +
  labs(
    title = "Average SAT score per borough",
    x = "Borough",
    y = "Average SAT score (800-2100)"
  ) +
  scale_fill_manual(
    name = "Borough",
    values = c("red", "green", "blue", "yellow", "purple"),
    breaks = c("Bronx", "Brooklyn", "Manhattan", "Queens", "Staten Island"),
    labels = c("Bronx", "Brooklyn", "Manhattan", "Queens", "Staten Island")
  ) + 
  geom_text(aes(label = avg), vjust = -0.5)

# avg_sat_score vs saf_t_11, corr: 0.309
graph2 <- school_data_question %>% 
  drop_na(saf_t_11) %>% drop_na(avg_sat_score) %>%
  ggplot(aes(x = saf_t_11,  y = avg_sat_score)) +
  geom_point() +
  labs(
    title = "Average SAT score vs Teacher Safety Perception",
    x = "Teacher Safety Perception (0-10)",
    y = "Average SAT score"
  )

# avg_sat_score vs aca_s_11, corr: 0.293
graph3 <- school_data_question %>% 
  drop_na(aca_s_11) %>% drop_na(avg_sat_score) %>%
  ggplot(aes(x = aca_s_11,  y = avg_sat_score)) +
  geom_point() +
  labs(
    title = "Average SAT score vs Student Academic Expectation Perception",
    x = "Student Academic Expectation Perception (0-10)",
    y = "Average SAT score"
  )

# avg_sat_score vs saf_s_11, corr: 0.277
graph4 <- school_data_question %>% 
  drop_na(saf_s_11) %>% drop_na(avg_sat_score) %>%
  ggplot(aes(x = saf_s_11,  y = avg_sat_score)) +
  geom_point() +
  labs(
    title = "Average SAT score vs Student Safety Perception",
    x = "Student Safety Perception (0-10)",
    y = "Average SAT score"
  )


# categories per borough - box plot
graph5 <- school_data_question %>%
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

# groups per borough - box plot
graph6 <- school_data_question %>%
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

