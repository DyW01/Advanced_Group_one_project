#As a group we have devided the tasks between each other
#through each others mistakes we have learnt
#The road is visible in script DYW_Exam_Script
#Now we have produced a final recipe to tidy this specific data
#---------------------- Refined script and steps -----------------------------#

#Step 1 (this can be improved)
library(tidyverse)
library(here)

<<<<<<< HEAD
=======
#Step 1 improved method
install.packages("pacman")
#us this to install all together
packages <- c("tidyverse", "ggplot2", "here", "fs", "knitr")
# Install and load packages
for (p in packages) {
  if (!p %in% installed.packages()) {
    install.packages(p, dependencies = TRUE)
  }
  if (!p %in% .packages()) {
    library(p, character.only = TRUE)
  }
}
#Alternative 2
pacman::p_load(ggplot2, tidyverse, here, fs)


>>>>>>> Main_Branch_Exam_Group_One
#Step 2 - Reading the text files, make sure directory is correct
read_delim("exam_nontidy.txt", delim = "\t")
read_delim("exam_joindata.txt", delim = "\t")

<<<<<<< HEAD
#Step 3 - assigning file an object
my_data <- read_delim("exam_nontidy.txt", delim = "\t")
my_join_data <- read_delim("exam_joindata.txt", delim = "\t")

=======


#########################DIRECTORY####################################
#Ctrl+Shift+A to reformat code in the code chunks/R script file
#Ctrl+Shift+M for %>%

#getwd()  - current directory
#here()   - current directory
#setwd()  - change working directory
#ls()     - files in environment
#remove(ls()) - clears environment - OBS!
#dir()    - files in current directory
#dir_tree(here()) - draws a tree of the current directory



#########################FILES####################################

#Load file into work environment #Separate columns using delimiter ("tab" - \t)
#setwd(""), and read
read_delim("exam_nontidy.txt", delim = "\t")
#assigning file an object
my_data <- read_delim("exam_nontidy.txt", delim = "\t")
my_join_data <- read_delim("exam_joindata.txt", delim = "\t")


>>>>>>> Main_Branch_Exam_Group_One
#Step 4 - The Pipe setup of multiple tidy mutations and transfomation
#----------------Will yield to the tidiest data -------------------#

tidy_data <- my_data%>%   #Assign our transformed data to object
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%  #Eradicating duplicates by pivot
  rename(age = `1.age`)%>%        #Renaming unfortunate column name
  separate(date,                  #Better visualization be seperating column
           into = c("year", "month"),
           sep="-")%>%
<<<<<<< HEAD
  subset(select = -c(gram, year, month))%>%  #Removing excessive column
=======
  subset(select = -c(gram, month))%>%  #Removing excessive column
>>>>>>> Main_Branch_Exam_Group_One
  mutate(age = as.numeric(age)) %>%         #Defining column content as numerical
  mutate(across(.cols = age, ~round(.,digits = 3)))%>% #Keeping to three decimal
  mutate(race =                         #Abbreviating the content in column
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
  mutate(blood_cult = round(blood_cult, digits = 0))%>% #Keeping to nearest whole number
  mutate(blood_wbc = round(blood_wbc, digits = 1))%>%     #keeping 1 decimal
  mutate(age_agm = age * abm )%>%   #numeric column showing multiplication of age and abm 
  select(id,
<<<<<<< HEAD
         sex,
         age,
=======
         age,
         sex,
>>>>>>> Main_Branch_Exam_Group_One
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything()) %>%
  full_join(my_join_data,by = ("id")) #joining the join data file to the mutated my_data
<<<<<<< HEAD
  

#When everyone agrees, and if no more is to be added, we can code for savefile
  
view(tidy_data)



a <- tidy_data %>% 
  summarize_each(mean, na.rm = T) %>% 
  summarize_each(min, na.rm = T) %>% 
  summarize_each(max, na.rm = T) %>%
  summarize_each(count, na.rm = T) %>% 
  summarize_each(sd, na.rm = T)




######## Akash script DAY 8
=======

view(tidy_data)

#Can save file if required now

#--------------------------Tasks----------------------------------------------#
#DAY 6


#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
tempdata %>% 
  group_by(sex) %>% 
  summarise(max(blood_wbc, na.rm = T), min(blood_wbc, na.rm = T),mean(blood_wbc,na.rm = T),sd(blood_wbc, na.rm =T))
tempdata %>% 
  group_by(race) %>% 
  summarise(max(blood_wbc, na.rm = T), min(blood_wbc, na.rm = T),mean(blood_wbc,na.rm = T),sd(blood_wbc, na.rm =T))


#Selected column summary (blood_cult, female, etc)
tidy_data %>%       #tidyverse way
  split(.$blood_cult) %>%
  map(summary)''

#In order to make it for blood_cult == 0 use filter function (from Akash)
tidy_data %>%         
  filter(blood_cult==0) %>%
  map(summary)

#View as table the relation of blood_gluc grouped by sex
Tabel2 <- 
  tidy_data%>%
  drop_na(sex,
          blood_gluc)%>% #remove missing values to make less messy table
  group_by(sex)%>% #Now select this as the group we check glucose for
  summarize(Lower = min(blood_gluc), #Now we use summarize (NOT summary) to spesify what we look for
            Average = mean(blood_gluc),
            Upper = max(blood_gluc), 
            Difference = max(blood_gluc) - min(blood_gluc)) %>%
  arrange(Average)%>%
  view() 

#DAY 7

#Does the glucose level in blood depend on sex? 
#Assuming this task can be solved by plottiing information in table2 ?
ggplot(tidy_data,  # define data
       aes(x = as.factor(sex), y = blood_gluc)) +  # define which columns are x and y, 
  geom_boxplot()


#Does the glucose level in CSF (cerebrospinal fluid) depend on race?
>>>>>>> Main_Branch_Exam_Group_One
csf_gluc_race_grouped <- tidy_data %>%
  filter(race == "B" | race == "W" )%>%
  group_by(race)

<<<<<<< HEAD
=======


>>>>>>> Main_Branch_Exam_Group_One
#calculate sum of csf_gluc per race
csf_gluc_race_summary <- csf_gluc_race_grouped %>%
  summarise(sum =sum(csf_gluc, na.rm = TRUE))
csf_gluc_race_summary

<<<<<<< HEAD
#ggplot
my_plot1 <-
  ggplot(csf_gluc_race_summary,
         aes(x=as.factor(race), y=sum))+
  geom_col(aes(fill = race), position = position_dodge())

my_plot1_nicer <- my_plot1 +
  scale_fill_brewer(type = "div",
                    name = "Glucose in CSF") + # name of the legend
  xlab("Race") +
  ylab("CSF Glucose") +
  labs(title = "CSF Glucose",
       subtitle = "",
       caption = "data source: Group 1")
my_plot1
my_plot1_nicer
=======

#Explore your data.
#Explore and comment on the missing variables.
naniar::gg_miss_var((tempdata))
mary(tidy_data) #R base function
skimr::skim(tidy_data) #Tidyverse way

#Day 8: Analyse the dataset and answer the following questions: (each person chooses one question)
#Is there a difference in the occurrence of the disease by sex? (DYW)
#assign object to select column
tidy_data_4chisq <- tidy_data%>%
  mutate(sex = as.numeric(sex)) %>% #mutating, so that it is same type as abm (R doesn't think like a statician, so both can be numerical)
  select(abm, sex) #select the variable
#In this test, make sure both variables are same type. 
chisq.test(tidy_data_4chisq$abm, tidy_data_4chisq$sex)



#----------Using regression to find time trend in the occurrence of the disease?#
#Catagorical outcome... makes it difficult
#can view the relation by looking at proportion of disease occurence pr year
tidy_data%>% 
  filter(!is.na(year)) %>% 
  group_by(year) %>% 
  #  summarise(prop = mean(abm, na.rm=T)) %>% 
  summarise(prop = sum(abm, na.rm = T)) %>% 
  ggplot(aes(x = year, y = prop)) +
  geom_col() 

#Trying linear regression on frequency pr year
Time_trend1 <-
  tidy_data %>%
  group_by(year) %>% 
  summarise(prop = sum(abm, na.rm = T)) %>%
  lm(prop ~ year, data = .) %>%
  broom::tidy()
>>>>>>> Main_Branch_Exam_Group_One
