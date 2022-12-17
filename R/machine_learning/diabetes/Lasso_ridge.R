library(mlbench)
library(caret)
library(dplyr)
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

#Diabetes
#Lasso Ridge example
#glmnet models: lasso, ridge
## modified from logistic regression model
set.seed(42)
crtl <- trainControl(method="cv",
                     number = 5,
                     verboseIter = T)

grid <- expand.grid(alpha = c(0,1),  #0 = ridge, 1 = lasso
                    #get help by using seq(0,1, by=0.03)
                    lambda = seq(0,1, by=0.03)) #means [0,1] inc by 0.03

glmnet_model <- train(diabetes ~ ., 
                     data = train_data,
                     method = "glmnet",
                     metric = "Accuracy",
                     trControl = crtl,
                     tuneGrid = grid)
#Evaluate
p4 <- predict(glmnet_model, newdata=test_data)

#eva
#interested in positive class (เป็น)
confusionMatrix(p4, test_data$diabetes,
                positive = "pos")

mean(p4 == test_data$diabetes)

#see which is the best model
glmnet_model
