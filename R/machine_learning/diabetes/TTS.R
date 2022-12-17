# function TTS
# to use: open then source
train_test_split <- function(data, train_size = 0.8){
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size = n*train_size ) #get random เอามาให้ 1 ตัว
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train_data, test_data)) #send back 
}
