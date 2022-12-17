
#decision tree

tree_model <- train(diabetes ~ .,
                    data = train_data,
                    method = "rpart")
#plot chart
library(rpart.plot)
rpart.plot(tree_model$finalModel)

varImp(tree_model)


#random forest
## train random forests
set.seed(99)
# want to use mtry 3,5,7,8
# myGrid <- expand.grid(mtry = 2:4) #or datafram ก็ได้
grid_rf <- expand.grid(mtry = c(3,5,7,8))

ctrl <- trainControl(method = "cv", 
                     number = 5,
                     verboseIter = TRUE)

rf_model <- train(diabetes ~ .,
                    data = train_data,
                    method = "rf",
                  trControl = ctrl,
                  tuneGrid = grid_rf)




