# Author: Wanicha Mueangcharoen
# R homework 1 : chatbot for ordering pizza
# 8-10 dialogues
# Note: at the end of a conversation, it needs to summarize the order

## Variable
  pizza_menu <- c("Hawaiian",
                  "RICHY HAMMY",
                  "Peperoni",
                  "Hokkaido Super Cheese",
                  "Cheese Lover",
                  "Super Deluxe")
  sizes <- c("Regular", "Large")
  crusts <- c("Cheesy", "Pan", "Thin & Crispy")
  r_prices <- c(299, 410, 390, 399, 299, 399)
  l_prices <- r_prices * 1.75
  prices_list <- list(R = r_prices,
                      L = l_prices)
  delivery_method <- c("Delivery", "Pick-Up")

#---------------


track_order <- function(){
  print("What's your order number?")
  ordernumber <- readLines("stdin", n=1)
  print(".......Loading.........")
}



bye <- function(){
  print("Thank You!")
  
}

dialogue1 <- function(){
  print("How can I help you today?")
  print("1. Order pizza")
  print("2. Track order")
  print("3. Reorder")
  print("4. Chat with us")
  optionA <- readLines("stdin", n=1)
  match_options <- c(1,2,3,4)
  while(!(optionA) %in% match_options){
    print("Sorry, I didn't catch that. Could you please try again?")
    optionA <- readLines("stdin", n=1)
  }
  #}
  if (optionA == 1) {
    order_pizza()
  } else {
    if (optionA == 2){
      print("Ok. Let's track your order!")
      track_order()
      
    } else {
      if (optionA == 3){
        print("Please choose pizza from your history.")
        print("Oops! There is something wrong.")
        bye()
        
      } else {
        if(optionA == 4){
          print("Let me loop in one of our customer service right away!")
          print("We'll be right with you very soon.") 
          bye()
        } else {
          print("Sorry, I didn't catch that. Could you please try again?")
        }
      }
    }
  }
}




#--------------

order_pizza <- function(){
  print("Here is our menu for today:")
  menu_df <- data.frame(Pizza = pizza_menu,
                        Regular = r_prices,
                        Large = l_prices)
  print(menu_df)
  comma_crusts <- paste(crusts, collapse = ", ")
  cat("Crust: ", comma_crusts,"\n")
  
 
  print("Step 1: Choose the toppings by typing number(1-6)")
  toppings_range <- c(1,2,3,4,5,6)
  count_menu <- 0
  while (count_menu >= 0) {
    select_pizza <- readLines("stdin", n=1)
    count_menu <- count_menu + 1
    #dummy =  match(select_pizza,toppings_range)
    if (select_pizza %in% toppings_range ) {
      #print("Selected")
      
      count_size <- 0
      while (count_size >= 0) {
        print("Step 2: Select size of your pizza")
        print("Type...")
        print("       1 for Regular (10in)")
        print("       2 for Large (12in)")
        select_size <- readLines("stdin", n=1)
        #select_size <- lapply(select_size, toupper)
        sizes_range <- c(1,2)
        count_size <- count_size + 1
        if (select_size %in% sizes_range ) {
          #print("Selected")
          
          count_crust <- 0
          while (count_crust >= 0) {
            print("Step 3: Select crust")
            print("Type...")
            print("       1 for Cheesy Crust")
            print("       2 for Pan crust")
            print("       3 for Thin & Crispy crust")
            select_crust <- readLines("stdin", n=1)
            count_crust <- count_crust + 1
            crust_choices <- c(1,2,3)
            if (select_crust %in% crust_choices ) {
              
              
              break
            } 
            else {
              print("Wrong input. Please select again.")
            }
            
          }
          select_crust <- as.numeric(select_crust) #put here to avoid "NAs introduced by coercion"
          #return(c(select_pizza, select_size, select_crust))
          
          
          break
        } 
        else {
          print("Wrong input. Please select again")
        }
        
        #suppressWarnings(select_pizza <- as.numeric(select_pizza))
      }
      select_size <- as.numeric(select_size) #put here to avoid "NAs introduced by coercion"
    
      break
    } 
    else {
      print("Wrong input. Please select again by typing number from 1 to 6")
    }
    
    #suppressWarnings(select_pizza <- as.numeric(select_pizza))
  }
  select_pizza <-as.numeric(select_pizza) #put here to avoid "NAs introduced by coercion"
  #select_size <- as.numeric(select_size) #put here to avoid "NAs introduced by coercion"
  return(c(select_pizza, select_size, select_crust))
}


qty_ask <- function(){
  a=as.numeric(readLines("stdin", n=1))
  suppressWarnings(a <- as.numeric(a)) #put here to avoid "NAs introduced by coercion"
  
}

quality <- function(){
  count_qty <- 0
  while (count_qty >= 0) {
    print("Step 4: Quality")
    print("How many pizza?")
    #print( paste("How many", pizza_menu[select_pizza],"pizza (", sizes[select_size],")" , "would you like?") )
    #get_qty <- readLines("stdin", n=1)
    get_qty <-as.numeric(readLines("stdin", n=1))
    #get_qty <- qty_ask()
    count_qty <- count_qty + 1
    #dum <- is.numeric(get_qty) & !is.na(get_qty)
    if(is.numeric(get_qty)& !is.na(get_qty)){
      
      if(get_qty >= 1 & get_qty <= 99 ){
        break
      } 
      else {
        print("Sorry, I didn't catch that. Could you please try again? The limit quantity of each pizza is 99.")
      }
      
    } else {
      print("Sorry. Please try again...")
      
      
    }
    
  }
  get_qty <- as.numeric(get_qty)
  return(c(get_qty))
}  



run_f <- function(){

  

  
  price <- 0
  total_price <- 0
  pizza_list <- c()
  side_item_list <- c()
  size_list <- c()
  pizza_price_list <- c()
  side_item_price_list <- c()
  size_price_list <- c()
  pizza_qty_price <- c()

  print("Hello Pizza Lover ❤")
  print("Please enter your name")
  cust_name = readLines("stdin", n=1)
  text <- paste("Hello", cust_name, ".", "Welcome to the Mizzy Pizza" )
  print(text)
  
 while(TRUE){
   d <- order_pizza()
   select_pizza <- d[1]
   select_size <- d[2]
   select_crust <- d[3]
  
   q <- quality()
   get_qty <- q[1]
   
   
   
  pizza_list <- c(pizza_list,pizza_menu[select_pizza])
  pizza_price_list <- c(pizza_price_list,r_prices[[select_pizza]])
  size_list <- c(size_list,sizes[[select_size]])
  size_price_list <- c(size_price_list,prices_list[[select_size]][[select_pizza]])
  pizza_qty_price <- size_price_list*get_qty
   #print( pizza_price_list)
   #print(size_price_list)
  print( paste("qty of", get_qty,"is ฿", pizza_qty_price))
   #print( paste("How many", pizza_menu[select_pizza],"pizza (", sizes[select_size],")" , "would you like?") )
 
# }
  
  
  # Delivery or Pickup
  delivery_fee <- 49
  print("Step 5: Delivery method")
  print("Pickup or Delivery?")
  print("Delivery fee 49 baht")
  print("Type...")
  print("       P for pick-up")
  print("       D for delivery")
  # delivered_selected <- readLines("stdin", n=1)
  # delivered_selected <- lapply(delivered_selected, toupper)
  #
  delivered_selected <- toupper(readLines("stdin", n=1))
#  delivered_selected <- lapply(readLines("stdin", n=1), toupper)
  total_price <- pizza_qty_price

  
  while (!(delivered_selected %in% c("P","D"))) {
    
    print("Wrong input. Please type either  P for pick-up or D for delivery")
    delivered_selected <- readLines("stdin", n=1)
  }  
  if (delivered_selected == "D") {
    print("Delivery")
    total_price <- total_price + delivery_fee
    print("Please add your delivery address")
    address <- readLines("stdin", n=1)
    print("Your order is in process...")
    #break
    }
   else{
      print("Your pick-up will be ready in about 30 minutes after you place your order.")
    }
    
   
  
  
  print("The order will be taking 30 min for cooking. Thank you.")
  print(paste("Total price is",total_price," Thai Baht")) 
   
  
 # ### Order Summary
  print("***** Your order summary: *****")
  print(paste("customer_name:",cust_name))
  print("Pizza details:")
  print(paste(pizza_list,"| Crust:",crusts[select_crust],"| Size",size_list,"| Qty.",get_qty,"| Price:",pizza_qty_price,"Thai Baht")) ##
#  print(paste("Delivery method:",delivered_selected))
  
  if (delivered_selected == "D") {
    print(paste("Delivery method:",delivery_method[1]))
    print(paste("Delivery address:",address))
  } else {
    print(paste("Delivery method:",delivery_method[2]))
    }
  print(paste("Total price:",total_price," Thai Baht"))
  
  print("Thank you. Enjoy your meal!  :) ")
  q()
 }  
}

run_f()
  
  









