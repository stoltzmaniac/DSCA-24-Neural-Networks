library('tidyverse')
library('caret')

set.seed(123)

dat_train = read_csv('train_data.csv') %>%
  mutate(label = as.factor(label))

# For predicting 1st number
m = matrix(unlist(dat_train[1,-1]),nrow=28,byrow=TRUE)
rotate = t(apply(m,2,rev))
image(rotate, col = grey.colors(255))

# What is it supposed to be?
dat_train[1,1]


train_control = trainControl(method = 'cv')

model_nn = train(
  dat_train %>% select(-label),
  dat_train$label,
  method = 'nnet'
)

saveRDS(model_nn, "./model_nn.rds")
