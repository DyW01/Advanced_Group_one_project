#My branch script to tidy data
#load packages
library(tidyverse)
library ("here")

#Reading the text file
read_delim("exam_nontidy.txt", delim = "\t")

#Followinge error: 'exam_nontidy.txt' does not exist...
#Change directory in settings in the files pane

#Assign datafile to name, my_data
my_data <- read_delim("exam_nontidy.txt", delim = "\t")
my_data

#View mydata | NB! if data table is too huge, not recommended
view(my_data)

#To get more unique infor of data, use skimr func
skimr::skim(my_data)
#Also identifying missing data 
naniar::gg_miss_var((my_data))

#When SS changes feature into "sex" and "race",then
#ID duplicate problem will be resolved after abovementione

#My solution to transform feature column to "sex" and "race"
my_data$`feature type`
head(my_data$`feature type`)

#Now using pipe function to work on column
my_data$`feature type`%>%
  head()

#For example, pipe opens the line and makes it more accessible
#using pivot function to transform to wider table
#create new coloumns with information from exciting...
my_data %>%
  pivot_wider(names_from = `feature type`,
              values_from = )
