#--------------------------Exploring data script ------------------------------#
#--------------------------------Necessary work preperation------------------#
#Load nescessary packages
library(tidyverse)
library(here)
library(ggplot2)
library(patchwork)

#Read files and assign them as objects
myData <- read_delim("exam_nontidy.txt", delim = "\t")
myJoindata <- read_delim("exam_joindata.txt", delim = "\t")

#tidy the data and join 
#[NB in this tidy pip, blood_cult as percentage in own column]
#[NB additionally mutated variable blood_gluc and ]

tidy_data <- myData%>%   #Assign our transformed data to object
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%  #Eradicating duplicates by pivot
  rename(age = `1.age`)%>%        #Renaming unfortunate column name
  separate(date,                  #Better visualization be seperating column
           into = c("year", "month"),
           sep="-")%>%
  subset(select = -c(gram, year, month))%>%  #Removing excessive column
  mutate(age = as.numeric(age),       #Defining column content as numerical
         blood_wbc = as.numeric(blood_wbc),
         blood_cult = as.numeric(blood_cult))%>%
  mutate(across(.cols = age, ~round(.,digits = 3)), #Keeping to three decimal
         across(.cols = blood_wbc, ~round(.,digits = 1)))%>%
  mutate(race =                         #Abbreviating the content in column
           case_when(
             race == "black" ~ "B",
             race == "white" ~ "W",
             race == "none" ~ NA_character_
           ))%>%
  mutate(sex = 
           case_when(
             sex == "female" ~ "F",
             sex == "male" ~ "M",
             sex == "none" ~ NA_character_
           ))%>%
  mutate(blood_neut_pct = if_else(blood_neut_pct <= 35, "Low", "High" )) %>% 
  mutate(percentage_blood_cult = (blood_cult = 100*blood_cult/max(blood_cult, na.rm = TRUE))) %>%
  mutate(percentage_blood_cult = round(blood_cult, digits = 0))%>% #Keeping to nearest whole number
  mutate(age_agm = age * abm )%>%   #numeric column showing multiplication of age and abm 
  select(id,
         age,
         sex,
         race,
         starts_with("csf"),
         starts_with("blood"),
         starts_with("percentage"),
         everything()) %>%
  full_join(myJoindata,by = ("id")) #joining the join data file to the mutated tidy_data

#------------------------------Start exploring data--------------------------#
#------------------- Final tasks and devition of tasks -------------------------#
#Explore and comment on the missing variables.
#Check data distrubtion, stratify (categorical column to report min, max, mean and sd of a numeric column and ovbservation). Use pipe

#testing summary (NOT summarize) which gives the abovementioned for whole tidy_data as tibble 
summary(tidy_data)

#testing summary of selected column (blood_cult, female, etc)
tidy_data%>%
  summary(tidy_data$blood_cult, blood_cult = 0) #persons with blood_cult == 0 [NOT WORKING with argument blood_cult == 0

tidy_data%>%
  summary(tidy_data$sex, sex = 0, #Only for females [From here and down it is working]
          tidy_data$age, age> 45, #Only for persons older than 45
          tidy_data$race, race = B, #Only black
          tidy$blood_gluc, blood_gluc > 120, #Only glucose over 120
          tidy_data$blood_cult) #Only for females



#Use two categorical columns in your dataset to create a table (hint: ?count)
#[Found a method without count...]
Tabel1 <-
  tidy_data%>%
  drop_na(sex,   #remove missing values to make less messy table
          race,
          blood_gluc)%>%
  group_by(race, sex)%>% #two categorical columns to look by
  summarize(High = max(blood_gluc)) %>% #Sum how many have high blood_glu in groups
  pivot_wider(names_from = sex, #pivot_wider to make more sensible table
              values_from = High)%>%
  view()

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

#Does the glucose level in blood depend on sex? 
#Assuming this task can be solved by plottiing information in table2 ?
#NEED HELP
ggplot(tidy_data,  # define data
       aes(x = as.factor(sex), y = blood_gluc)) +  # define which columns are x and y, 
  geom_col(position = position_dodge())

#Day 8: Analyse the dataset and answer the following questions: (each person chooses one question)
#Is there a difference in the occurrence of the disease by sex? (DYW)

#Look at this tomorrow


