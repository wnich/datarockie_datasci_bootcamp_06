# Classification
# noted
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes
head(df)

# Target: diabetes
glimpse(df)

df %>% 
  count(diabetes) %>%
  mutate(pct = n/sum(n))

mean(complete.cases(df))

# Build Model
split_data <- train_test_split(df)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

set.seed(42)
crtl <- trainControl(method="cv",
                     number = 5,
                     verboseIter = T)

## build knn model
model <- train(diabetes ~ ., 
               data = train_data,
               method = "knn",
               metric = "Accuracy",
               trControl = crtl)

p <- predict(model, newdata=test_data)

mean(p == test_data$diabetes) #mildly overfit

## build another model
## random forrest 
# easy
# slow
set.seed(42) #always for RF
rf_model <- train(diabetes ~ ., 
                  data = train_data,
                  method = "rf",
                  metric = "Accuracy",
                  trControl = crtl)

p2 <- predict(rf_model, newdata=test_data)

mean(p2 == test_data$diabetes)


## build decision tree model
set.seed(42)
tree_model <- train(diabetes ~ ., 
                    data = train_data,
                    method = "rpart",
                    metric = "Accuracy",
                    trControl = crtl)

p3 <- predict(tree_model, newdata=test_data)

mean(p3 == test_data$diabetes)


## build logistic regression model
set.seed(42)
logit_model <- train(diabetes ~ ., 
                     data = train_data,
                     method = "glm",
                     metric = "Accuracy",
                     trControl = crtl)

p4 <- predict(logit_model, newdata=test_data)

mean(p4 == test_data$diabetes)



#Evaluate these 4 at the same time

list_models <- list(
  knn = model,
  glm = logit_model,
  rpart = tree_model,
  rf = rf_model
)

result_models <- resamples(list_models)

summary(result_models)
