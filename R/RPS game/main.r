# Rock paper scissors game 
# Pao Ying Chup
# Author : Wanicha M.
# Datarockie Bootcamp 06
# 2022

# You vs Opponent
# Input: you can choose rock, paper or scissors.
# Rock beats scissors
# Scissors beats paper 
# Paper beats rock
# The output determines the winner...




RPS = function(x){
  tie <- 0
  win <- 0
  lose <- 0
  
  
  idx <- sample(1:3, 1) #random for computer
  #To know 1,2,3 are what ...> define
  comp_input <- choices[idx]

 
  if (x == comp_input) {
    print(paste(x,"vs",comp_input))
    print("Tie")
    tie <- tie + 1 
  } else {
    if (x == "paper") {
      if (comp_input == "scissors") {
        print(paste(x,"vs",comp_input))
        print("You lose!")
        lose <- lose + 1
      } else {
        print(paste(x,"vs",comp_input))
        print("Yay, You win!")
        win <- win + 1
      }
    } else if (x == "rock") {
      if (comp_input == "paper") {
        print(paste(x,"vs",comp_input))
        print("You lose!")
        lose <- lose + 1
      } else {
        print(paste(x,"vs",comp_input))
        print("Yay, You win!")
        win <- win + 1
      }
    } else {
      if (comp_input == "rock") {
        print(paste(x,"vs",comp_input))
        print("You lose!")
        lose <- lose + 1
      } else {
        print(paste(x,"vs",comp_input))
        print("Yay, You win!")
        win <- win + 1
      }
    }
  } 
  return(c(win,lose,tie))
  
 
}


result <- c(0,0,0)
while (TRUE){
  print("Welcome to rock-paper-scissors game")
  print("Are you ready for a game?")
  print("Let's get started!!!")
  
  
  choices <- c("rock", "paper", "scissors")
  print("YOU vs COMPUTER")
  print("Enter: rock / paper / scissors ")
  player <- tolower(readLines("stdin",1))
  
  while (!(player %in% choices)){
    print("That's not a valid play. Check your spelling!")
    print("Enter: rock / paper / scissors")
    player <-tolower(readLines("stdin",1))
  } 
  
  user_res <- RPS(player)
  result <- result + user_res
  
  print("Play Again? (y/n)")
  ans <- tolower(readLines("stdin",1))
  while (!(ans %in% c("y", "n"))){
    print("That's not valid. Check your spelling!")
    print("y for yes, n for no")
    ans <- tolower(readLines("stdin",1))
  } 
  
  if (ans == "n") {
    scores <- paste("Your Score: ",
      "# of win(s):", result[1],
      "# of lose(s):", result[2],
      "# of tie(s):", result[3], sep="\n")
    cat(scores)
    break
  }
}
