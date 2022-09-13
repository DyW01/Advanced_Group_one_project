#---------------------------The base script provided by and merged with contribution by DYW -----#

#First step in making good script, is introducing code to load the packages
#run codde below: 

library(tidyverse)
library ("here")

#Reading the text file
read_delim("exam_nontidy.txt", delim = "\t")

#Followinge error: 'exam_nontidy.txt' does not exist...
#Change directory in settings in the files pane

#Assign datafile to name, my_data
my_data <- read_delim("exam_nontidy.txt", delim = "\t")
my_data

#You can view by the function "view(name_of_dataframe), but NB! if data table is too huge, not recommended


#To get more unique information of data, use skimr func
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
              values_from = feature_value)
              

#check the results are true (the new columns are at the end) by view function
#and look at the selected column
myData$`1.age`

#Now rename column 1.age to age be using function rename
myData <- myData %>%
  rename(age = `1.age`)
#View changes


#trying to combine the aformentioned solution
#Now to test if my combination by pipe is correct
#I will tranform the nontidy "my_data" (and not myDATA) to tidy_data
tidy_data <- my_data%>%
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%
  rename(age = `1.age`)

view(tidy_data)

#------Aditi_Exam_Branch ---------- TIDY RACE column--------------------------- #

tidy_data%>%
  count(race)

#Renaming the content of colomn 
tidy_data <-
  tidy_data %>% 
  mutate(race = 
           case_when(
             race == "black" ~ "B",
             race == "white" ~ "W",
             race == "none" ~ NA_character_
           ))

View(tidy_data)

<<<<<<< HEAD
#-------------THEO/DYW contribution ------------#

#Firstly renaming the content of sex column
=======
#----------------Theo and DyW---------------------------#
#The task was "a column showing sex as 0/1 (and NA for missing, if any)"
#either solve with if
tidy_data %>% 
  mutate(n_sex = if_else(sex == "F", 1, 0)) 

#however, better solution would be the following: 
>>>>>>> 10aa4382315066193e8bb4471e626471532adcaf
tidy_data <-
  tidy_data %>% 
  mutate(sex = 
           case_when(
             sex == "female" ~ "0",
             sex == "male" ~ "1",
             sex == "none" ~ NA_character_
           ))

<<<<<<< HEAD
#Task is to show blood_cult as a percentage of highest possible value (11)
#Make sure and mutate colomn blood_cult as numeric 
tidy_data <-tidy_data%>%
  mutate(blood_cult = as.numeric(blood_cult))

#First duplicate blood_cult (NOT WORKING)
tidy_data <- tidy_data%>%
  mutate(blood_cult = blood_cult)

=======

#-----------------Aditi and Shwesin-----------------------------------#

#-------------------------Rearanging and removing unnescessary column ----#

#Starting by overviewing the coloumn race and counting
tidy_data %>% 
  count(race)

race_change %>% 
  count(race)


#arrange in ascending order
tidy_data <-
  tidy_data %>% 
  #  arrange(id) %>% - arranging in ascending order
  arrange(asc(id))


#creating new columns by using a separator 
tidy_data <-
  tidy_data %>% 
  separate(date, 
           into = c("year", "month"),
           sep="-")

#Drop columns
tidy_data <-
  tidy_data %>% 
  subset(select = -c(gram, year, month))

head(data_untidy)

#Rounding off decimal points for numeric
mutate_data <-
  tidy_data %>% 
  #  mutate(across(where(is.numeric), ~ round(., 2)))
  mutate(age = as.numeric(age)) %>% 
  mutate(across(.cols = age, ~round(.,digits = 3)))


#----------------DYW -------------------#
#to abovementioned data, adding the blood_cult to percentage mutation
mutate_data <-
  mutate_data %>%
    mutate(blood_cult = 100*blood_cult/max(blood_cult, na.rm = TRUE)) %>% 


#-----Finally merging all the content into one ------#
#in the below pipe setup, the abovementioned steps are refined and combined
#assigning the data as merged_exam_data
#first mutation in coloumn n_blookd_neut_pt
#second mutaiont is percentage in coloum blood_count, and so on

merged_exam_data <- 
 tidy_data %>% 
  mutate(n_blood_neut_pct = if_else(blood_neut_pct <= 35, "Low", "High" )) %>% 
  mutate(n_blood_cult = 100*blood_cult/max(blood_cult, na.rm = TRUE)) %>% 
  mutate(n_blood_cult = round(n_blood_cult, digits = 0)) %>% 
  mutate(n_sex = if_else(sex == "F", 1, 0)) %>% 
  mutate(n_age_agm = age * abm ) %>% 
  select(id,
         sex,
         age,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything()) %>% 
  arrange(id) %>% 
  full_join(join_data, by = "id")


#However, if we wish to continue on from the step where we assigned mutate_data, following code can run: 

merged_exam_data <- 
 tidy_data %>% 
  mutate(n_blood_neut_pct = if_else(blood_neut_pct <= 35, "Low", "High" )) %>% 
  mutate(n_age_agm = age * abm ) %>% 
  select(id,
         sex,
         age,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything()) %>% 
  arrange(id) %>% 
  full_join(join_data, by = "id")

#-------------------------------------------#
#other solutions:
>>>>>>> 10aa4382315066193e8bb4471e626471532adcaf
