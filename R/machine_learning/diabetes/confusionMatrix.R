## build logistic regression model
# predict diabetes
ctrl <- trainControl(method="cv",
                     number = 5,
                     verboseIter = T)

set.seed(42)
logit_model <- train(diabetes ~ ., 
                     data = train_data,
                     method = "glm",
                     metric = "Accuracy",
                     trControl = ctrl)

#evaluate
p4_new <- predict(logit_model, newdata=test_data)

#eva
confusionMatrix(p4_new, test_data$diabetes)

#interested in positive class (เป็น)
confusionMatrix(p4_new, test_data$diabetes,
                positive = "pos")

mean(p==test_data$diabetes)


#prec_recall
confusionMatrix(p4_new, test_data$diabetes,
                positive = "pos",
                mode = "prec_recall")
