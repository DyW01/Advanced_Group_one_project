#My branch script to tidy data
#load packages
library(tidyverse)
library ("here")

#Reading the text file
read_delim("exam_nontidy.txt", delim = "\t")

#FOllowinge error: 'exam_nontidy.txt' does not exist in current working directory ('C:/Users/Icebe/OneDrive/Skrivebord/R statistics course/Tasks and other files/Advanced_Group_one_project').
#Change directory in settings within the files pane

#View                                                                  