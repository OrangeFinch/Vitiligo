#setwd("Z:/Vitiligo") #for university 
setwd("~/Documents/Informaticks/Vitiligo/Scripts") #for home 
exprSet <- read.csv(file = "exprSet.csv", head = TRUE, sep = " ")
C_name <- colnames(exprSet)
experiment <- c(1:40)
skin <- c(1:40)
number <- c(1:40)
skin_factor <- c(1:40)
type_of_skin <- data.frame(experiment = C_name, number = number, skin = skin, skin_factor = skin_factor)
type_of_skin$skin <- replace(type_of_skin$skin, type_of_skin$number[1:10], "NST")
type_of_skin$skin <- replace(type_of_skin$skin, type_of_skin$number[11:20], "LST")
type_of_skin$skin <- replace(type_of_skin$skin, type_of_skin$number[21:30], "NLST")
type_of_skin$skin <- replace(type_of_skin$skin, type_of_skin$number[31:40], "PLST")


type_of_skin$skin_factor <- factor(type_of_skin$skin, labels = c(1,2,3,4)) 
boxplot(exprSet, col = type_of_skin$skin_factor, names = type_of_skin$skin)


