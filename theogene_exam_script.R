#Make new brach


#Loading library

library(tidyverse)
library(here)

#Reading the data file

read_delim("exam_nontidy.txt", delim =" \t")

#Now the dataset is loaded in my working directory 


#Viewing the dataset:
view(read_delim("exam_nontidy.txt", delim =" \t"))





#Theo will re-name variable date into date of birth


#...........................................
#Work on group project 13 Sept 2022


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
#ID duplicate problem will be resolved after abovementioned

#My solution to SS assignment is to transform from long to wide table
#`feature type` to "sex" and "race" and insert value from feature_value


#I just want to find the column and observe head values
my_data$`feature type`
head(my_data$`feature type`)

#Now using pipe transform them stepwise with pivot_wider

myData <- my_data %>%
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,
  )

#check the results are true (the new columns are at the end)
view(myData)
#and look at the selected column
myData$`1.age`

#Now rename column 1.age to age be using function rename
myData <- myData %>%
  rename(age = `1.age`)
#View changes
View(myData)

#trying to combine the aformentioned solution
#Now to test if my combination by pipe is correct
#I will tranform the nontidy "my_data" (and not myDATA) to tidy_data
tidy_data <- my_data%>%
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%
  rename(age = `1.age`)

view(tidy_data)



#--------------------- my script for nunction of the group

#show sex as 0/, na

my_data%>% 
  skimr::skim(tidydata)

summary(tidydata)
View(tidy_data)
#Show data on sex
tidy_data %>% 
  mutate(sex = case_when(
    sex == "female" ~ "0",
    sex == "male" ~ "1",
    sex == "none"~ "missing"))
  
 .......................
 
 #Task 2
 tidy_data %>% 
   
  multiplication 
 
 



