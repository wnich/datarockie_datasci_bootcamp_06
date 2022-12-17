'''
---
HW
title: "Titanic predictive model"
author: "Wanicha M."
date: "2022-10-24"
---
'''

library(titanic)
head(titanic_train)
#y is survive --0 = no = die, 1 = yes = survived
#1. clean up data
## age col has NA. We will remove them
titanic_train <- na.omit(titanic_train)
## Convert the data type of the Survived column to factor 
## So conf. mtx will display died, survived instrad of 0,1
titanic_train <- titanic_train %>% 
  mutate(Survived = factor(Survived,
                           levels = c(0, 1),
                           labels = c("died", "survived")))
nrow(titanic_train)

#2. split data
set.seed(40) #lock result
n <- nrow(titanic_train) 
id <- sample(1:n, size = n*0.7) #70:30
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

#3. train
#predict survive
model <- glm(Survived ~ Pclass + Age, data = train_data, family = "binomial")
summary(model)
# Predict the probability of survival using Train Data
pred_train <- predict(model, type = "response") #probability
##set threshold ถ้าคน่าจะเป็น >0.5 then survived
train_data$pred <- if_else(pred_train >= 0.5, "survived", "died")
# Survived vs. Predicted Survived of Train Data
train_data %>% 
  head(10)

#4. test
pred_test <- predict(model, newdata = test_data, type = "response") #probability
##set threshold ถ้าคน่าจะเป็น >0.5 then survived
test_data$pred <- if_else(pred_test>= 0.5, "survived", "die")
# Survived vs. Predicted Survived of Test Data
test_data %>% 
  head(10)


#5. eval model
## 5.1 Train
## Train Confusion Matrix
conf_mtx_train <- table(train_data$pred,train_data$Survive, dnn = c("predicted", "actual") ) 

## Model Evaluation Train
### accuracy: 
accuracy_train <- (conf_mtx_train[1,1] + conf_mtx_train[2,2])/ sum(conf_mtx_train) #row 1 col 1
precision_train <- conf_mtx_train[2,2] / (conf_mtx_train[2,2] + conf_mtx_train[2,1])  #actual yes, pred yes
recall_train <- conf_mtx_train[2,2] / (conf_mtx_train[2,2] + conf_mtx_train[1,2])
F1_train <- 2*(precision_train*recall_train)/(precision_train+recall_train)
cat("accuracy_train:", accuracy_train)
cat("precision_train:", precision_train)
cat("recall_train:",  recall_train)
cat("F1_train:", F1_train ) 

# Train Model Summary DF
Train <- data.frame(Model = "Train",
                    Accuracy = accuracy_train,
                    Precision = precision_train,
                    Recall = recall_train,
                    F1_Score = F1_train)

cat("Train Confusion Matrix \nwhere died = 0, survived = 1:\n")
print(conf_mtx_train)
cat("..........\n")
cat("Train Model Evaluation:\n")
print(Train)

##5.2 Model Evaluation Test
## Test Confusion Matrix
conf_mtx_test <- table(test_data$pred,test_data$Survive, dnn = c("predicted", "actual") ) 

### accuracy: 
accuracy_test <- (conf_mtx_test[1,1] + conf_mtx_test[2,2])/ sum(conf_mtx_test) #row 1 col 1
precision_test <- conf_mtx_test[2,2] / (conf_mtx_test[2,2] + conf_mtx_test[2,1])  #actual yes, pred yes
recall_test <- conf_mtx_test[2,2] / (conf_mtx_test[2,2] + conf_mtx_test[1,2])
F1_test<- 2*(precision_test*recall_test)/(precision_test+recall_test)
cat("accuracy_train:", accuracy_test)
cat("precision_train:", precision_test)
cat("recall_train:",  recall_test)
cat("F1_train:", F1_test ) 

# Test Model Summary DF
Test <- data.frame(Model = "Test",
                    Accuracy = accuracy_test,
                    Precision = precision_test,
                    Recall = recall_test,
                    F1_Score = F1_test)

cat("Test Confusion Matrix \nwhere died = 0, survived = 1:\n")
print(conf_mtx_test)
cat("..........\n")
cat("Test Model Evaluation:\n")
print(Test)


##6. Summary
# Bind the Train DF and Test DF together
# bind_rows() เทียบเท่ากับการเขียน UNION ALL
Train_Test <- bind_rows(Train, Test)
Train_Test
###long
graph_tt <- Train_Test %>% 
  gather(Accuracy:F1_Score, # from col "Accuracy" to "F1_Score"
         key   = "eva_type", # col_name
         value = "RMSE") #value col_name


bargraph <- ggplot(data = graph_tt) +
  geom_bar(aes(x = eva_type,
               y = RMSE, #value
               fill = Model,
               color = Model),
           stat = "identity",
           position = position_dodge()) +
  theme(legend.title=element_blank())
bargraph



