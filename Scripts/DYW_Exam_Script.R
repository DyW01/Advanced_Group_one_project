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




#Aditi 
data_untidy <-
  data_untidy %>% 
  mutate(race = 
           case_when(
             race == "black" ~ "B",
             race == "white" ~ "W",
             race == "none" ~ NA_character_
           ))







#Aditi and Shwesin

data_untidy %>% 
  count(race)

race_change %>% 
  count(race)


#arrange 
data_untidy <-
  data_untidy %>% 
  #  arrange(id) %>% - arranging in ascending order
  arrange(desc(id))


#creating new columns by using a separator 
data_untidy <-
  data_untidy %>% 
  separate(date, 
           into = c("year", "month"),
           sep="-")

#Drop columns
data_untidy <-
  data_untidy %>% 
  subset(select = -c(gram, year, month))

head(data_untidy)

#Rounding off decimal points for numeric
mutate_data <-
  data_untidy %>% 
  #  mutate(across(where(is.numeric), ~ round(., 2)))
  mutate(age = as.numeric(age)) %>% 
  mutate(across(.cols = age, ~round(.,digits = 3)))



