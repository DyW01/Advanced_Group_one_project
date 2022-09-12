#loadin library

library(tidyverse)
library ("here")
#checking the directory
here()

#Reading the text file, working first on nontidy
read_delim("exam_nontidy.txt", delim = "\t")
#if it doesnt work, change directory by "setting" in file window

#View it to understand what to work with
view(read_delim("exam_nontidy.txt", delim = "\t"))

#Now to seperate the tasks with the tidy process
#SS seperate feature into sex and race
#Akash rewriting age colum
#Theo renaming date into date of birth
#DYW Removing duplicated row

my_data <- read_delim("exam_nontidy.txt", delim = "\t")

view(my_data)

skimr::skim(my_data)

