#load model
model_CV <- readRDS("LR_model_CV.RDS")

#5. save model (batch prediction) fro other users to use
#new dataset
nov_data <- data.frame(
  id = 1:3,
  hp = c(222, 140, 199),
  wt = c(2.5, 1.9, 3.0)
)
nov_pred <- predict(model_CV, newdata = nov_data)

#create a new dataset with prediction
nov_data$pred <- nov_pred
nov_data
write.csv(nov_data, "resultNov.csv", row.names = FALSE)
