#As a group we have devided the tasks between each other
#through each others mistakes we have learnt
#The road is visible in script DYW_Exam_Script
#Now we have produced a final recipe to tidy this specific data
#---------------------- Refined script and steps -----------------------------#

#Step 1 (this can be improved)
library(tidyverse)
library(here)

#Step 2 - Reading the text files, make sure directory is correct
read_delim("exam_nontidy.txt", delim = "\t")
read_delim("exam_joindata.txt", delim = "\t")

#Step 3 - assigning file an object
my_data <- read_delim("exam_nontidy.txt", delim = "\t")
my_join_data <- read_delim("exam_joindata.txt", delim = "\t")

#Step 4 - The Pipe setup of multiple tidy mutations and transfomation
#----------------Will yield to the tidiest data -------------------#

tidy_data <- my_data%>%   #Assign our transformed data to object
  pivot_wider(names_from = `feature type`,
              values_from = feature_value,)%>%  #Eradicating duplicates by pivot
  rename(age = `1.age`)%>%        #Renaming unfortunate column name
  separate(date,                  #Better visualization be seperating column
           into = c("year", "month"),
           sep="-")%>%
  subset(select = -c(gram, year, month))%>%  #Removing excessive column
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
         sex,
         age,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything()) %>%
  full_join(my_join_data,by = ("id")) #joining the join data file to the mutated my_data


#When everyone agrees, and if no more is to be added, we can code for savefile

view(tidy_data)
#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
tidy_data %>%                               # Summary by group sex
  split(.$sex) %>%
  map(summary)

tidy_data %>%                               # Summary by group race
  split(.$race) %>%
  map(summary)

#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
#Only for persons with blood_cult == 0
tidy_data %>%         
  filter(blood_cult==0) %>%
  map(summary)
#Only for females
tidy_data %>%         
  filter(sex==0) %>% 
  map(summary)
#Only for persons older than 45
tidy_data %>%         
  filter(age>45) %>% 
  map(summary)
#Only for persons classified as black and blood_gluc higher than 120
tidy_data %>%         
  filter(race==0) %>% 
  filter(blood_gluc>120) %>%
  map(summary)

#Use two categorical columns in your dataset to create a table (hint: ?count)
tidy_data %>% 
  count(sex, race)


####day 7-Akash's part#########################
#######Does the glucose level in CSF (cerebrospinal fluid) depend on race?#############
library(tidyverse)
library(patchwork)

#Does the glucose level in CSF (cerebrospinal fluid) depend on race?
csf_gluc_race_grouped <- tidy_data %>%
  filter(race == "B" | race == "W" )%>%
  group_by(race)



#calculate sum of csf_gluc per race
csf_gluc_race_summary <- csf_gluc_race_grouped %>%
  summarise(sum =sum(csf_gluc, na.rm = TRUE))
csf_gluc_race_summary





#ggplot
my_plot1 <-
  ggplot(csf_gluc_race_summary,
         aes(x=as.factor(race), y=sum))+
  geom_col(aes(fill = race), position = position_dodge())




my_plot1




my_plot1_nicer <- my_plot1 +
  scale_fill_brewer(type = "div",
                    name = "Glucose in CSF") + # name of the legend
  xlab("Race") +
  ylab("CSF Glucose") +
  labs(title = "CSF Glucose",
       subtitle = "",
       caption = "data source: Group 1")
my_plot1_nicer