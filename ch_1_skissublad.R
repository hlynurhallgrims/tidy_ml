library(tidyverse)
library(dslabs)

gappy <- dslabs::gapminder %>% 
  as_tibble()

nested <- gappy %>% 
  group_by(country) %>% 
  nest()

nested

nested %>% 
  unnest(data)

nested %>%
  mutate(pop_mean = data %>%
    map_dbl(.x = ., .f = ~ mean(.x$population, na.rm = TRUE)))

nested %>%
  mutate(pop_mean = data %>%
    map_dbl(~ mean(.$population, na.rm = TRUE)))

gappy %>% 
  group_by(country) %>% 
  mutate(pop_mean = mean(population, na.rm = TRUE))

gap_models <- nested %>%
  mutate(model = data %>% map(~lm(formula = life_expectancy~year, data = .)))

algeria_model <- gap_models$model[[1]]

summary(algeria_model)

gappy %>% 
  filter(is.na(population))
