#--------------------------------------------#
#Day 5
#--------------------------------------------#

#########################PACKAGES####################################
##https://statsandr.com/blog/an-efficient-way-to-install-and-load-r-packages/

#Alternative 1
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
#Loading file into the environment
#Data manipulation

#Load file into work environment #Separate columns using delimiter ("tab" - \t)
#setwd("C:/Users/asi006/Downloads/RMED/Advanced_Group_one_project/Data")
read_delim("exam_nontidy.txt", delim = "\t")
tidy_data <- read_delim("exam_nontidy.txt", delim = "\t")
new_data    <- read_delim("exam_nontidy.txt", delim = "\t")

#view(tidy_data) - not recommended for large datasets
head(tidy_data)
glimpse(tidy_data)

#########################SUMMARY STATS####################################
#columns store values as <chr> which need to be converted to <numeric>
tidy_data %>%
  distinct()
tidy_data %>%
  count(date)
summary(tidy_data)

tidy_data %>%
  summarize(max(blood_wbc, na.rm = T),
            min(blood_wbc, na.rm = T),
            mean(blood_wbc, na.rm = T))

#checking for duplicates
tidy_data %>%
  count(id, sort = TRUE)


#Provides summary statistics - missing, complete, n and sd
#<https://www.rdocumentation.org/packages/skimr/versions/2.1.4>
skimr::skim(tidy_data)

#Graph showing frequency of missing for each variable
naniar::gg_miss_var((tidy_data))



#########################COLUMNS####################################

#Rename column name to "feature_type"
#A good practice to change names which start with numbers or have spaces
tidy_data <-
  new_data %>%
  rename(feature_type = `feature type`,
         age = `1.age`)

#Pivot "feature type" into "sex" and "race" tidy_data \<-
tidy_data <-
  tidy_data %>%
  pivot_wider(names_from  = feature_type,
              values_from = feature_value)

#viewing chosen columns
tidy_data %>%
  select(id, age, date) %>%
  head()


#changing order of columns
#not ending with everything() removes the other columns
tidy_data <-
  tidy_data %>%
  select(id,
         sex,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything())

#Turning a string column into numeric
tidy_data <-
  tidy_data %>%
  mutate(csf_prot = as.numeric(csf_prot))


#Rounding off decimal points for numeric
tidy_data <-
  tidy_data %>%
  # mutate(across(where(is.numeric), \~ round(., 2)))
  mutate(across(.cols = age, ~ round(., digits = 3))) %>%
  mutate(age = as.numeric(age))

#Creating a new ID column
tidy_data <-
  tidy_data %>%
  mutate(ID_new = 1:n())

#Comparison of two columns
tidy_data %>%
  select(id, ID_new) %>%
  mutate(if_else(as.character(id) == as.character(ID_new), "equal", "different"))

#Removes column "ID_new"
tidy_data <- subset(tidy_data, select = -c(ID_new))


#creating new columns by using a separator
tidy_data <-
  tidy_data %>%
  separate(date, into = c("year", "month"), sep = "-")

#removes dataset from the evironment
#remove(new_data)


#Ifelse and case_when 
tidy_data <-
  tidy_data %>%
  mutate(sex = if_else(sex == "female", "F", "M")) %>%
  mutate(race = case_when(
    race == "black" ~ "black",
    race == "white" ~ "white",
    race == "none" ~ NA_character_
  ))

#Arranging/sorting
tidy_data <-
  tidy_data %>%
  arrange(id)
#  arrange(desc(id))


head(tidy_data)


#########################MERGING####################################
join_data <- read_delim("exam_joindata.txt", delim = "\t")

join_data <-
  join_data %>%
  arrange(id) %>%
  head()

#merging data - using id column
merged_data <-
  full_join(tidy_data, join_data, by = "id") %>%
  arrange(id)


#########################COMBINING USING PIPELINE####################################
#Drop columns
tidy_data <-
  tidy_data %>%
  subset(select = -c(gram, year, month))

tidy_data <- 
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
  arrange(id)

%>% 
  full_join(join_data, by = "id")

#Data exploration
file <- merged_exam_data
skimr::skim(file) 
naniar::gg_miss_var(file)


summarize(consultations_gp)


tidy_data %>%
  group_by(race) %>% 
  summarise(across(where(is.numeric), mean))

            
    
    max( na.rm = T),
            min( na.rm = T),
            mean( na.rm = T))


head(tidy_data)


# Comment on the missing variables
# Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
# Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
#   Only for persons with `blood_cult == 0`
# Only for females
# Only for persons older than 45
# Only for persons classified as black and blood_gluc higher than 120
# Use two categorical columns in your dataset to create a table (hint: ?count)


###########################DECLUTTER AND EXPLAIN GRAPHS############################


#4. Day 7: Create plots that would help answer these questions:
#  _(each person chooses min.one question)_
#- Are there any correlated measurements?
#  - Does the glucose level in blood depend on sex?
#  - Does the glucose level in blood depend on race?
#  - Does the glucose level in CSF (cerebrospinal fluid) depend on sex?
#  - Does the glucose level in CSF (cerebrospinal fluid) depend on race?
  
#  4. Day 8: Analyse the dataset and answer the following questions:
#  _(each person chooses one question)_

#- Is there a difference in the occurrence of the disease by sex?
#  - Does the occurrence of the disease depend on age?
#  - Is there a difference in the occurrence of the disease by race?
#  - Is there a time trend in the occurrence of the disease?












