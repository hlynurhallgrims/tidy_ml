library(rsample)


library(tidyverse)
library(tidymodels)


library(dslabs)


gap <- gapminder %>% 
  as_tibble()

gap_split <- initial_split(gap, prop = 0.75)

training_data <- training(gap_split)

cv_split <- vfold_cv(training_data, v = 5)

cv_split %>% 
  mutate(train = splits %>% 
           map(~training(.)),
         validate = splits %>% 
           map(~testing(.))) 
  