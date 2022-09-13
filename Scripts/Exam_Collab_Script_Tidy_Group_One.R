#As a group we have devided the tasks between each other
#through each others mistakes we have learnt
#The road is visible in script DYW_Exam_Script
#Now we have produced a final recipe to tidy this specific data
#---------------------- Refined script and steps -----------------------------#

#Step 1 (this can be improved)
library(tidyverse)
library(here)

#Step 2 - Reading the text file, make sure directory is correct
read_delim("exam_nontidy.txt", delim = "\t")

#Step 3 - assigning file an object
my_data <- read_delim("exam_nontidy.txt", delim = "\t")


#Step 4 - The Pipe setup of multiple tidy mutations and transfomation
#----------------Will yield to the tidiest data -------------------#

tidy_data <- my_data%>%   #Assign our transformed data to object
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%  #Eradicating duplicates by pivot
  rename(age = `1.age`)%>%        #Renaming unfortunate column name
  separate(date, 
           into = c("year", "month"),
           sep="-")%>%
  subset(select = -c(gram, year, month))%>%
  mutate(age = as.numeric(age)) %>% 
  mutate(across(.cols = age, ~round(.,digits = 3)))%>% 
  mutate(race = 
           case_when(
             race == "black" ~ "B",
             race == "white" ~ "W",
             race == "none" ~ NA_character_
           ))%>%
  mutate(sex = 
           case_when(
             sex == "female" ~ "0",
             sex == "male" ~ "1",
             sex == "none" ~ NA_character_
           ))%>%
  mutate(blood_neut_pct = if_else(blood_neut_pct <= 35, "Low", "High" )) %>% 
  mutate(blood_cult = 100*blood_cult/max(blood_cult, na.rm = TRUE)) %>% 
  mutate(blood_cult = round(blood_cult, digits = 0))%>% 
  mutate(blood_wbc = round(blood_wbc, digits = 1))
  mutate(n_age_agm = age * abm ) %>% 
  select(id,
         sex,
         age,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything())

  

#When everyone agrees, and if no more is to be added, we can code for savefile
  
view(tidy_data)
