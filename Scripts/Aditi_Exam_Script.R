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
data_untidy <- read_delim("exam_nontidy.txt", delim = "\t")
new_data    <- read_delim("exam_nontidy.txt", delim = "\t")

#view(data_untidy) - not recommended for large datasets
head(data_untidy)
glimpse(data_untidy)

#########################SUMMARY STATS####################################
#columns store values as <chr> which need to be converted to <numeric>
data_untidy %>%
  distinct()
data_untidy %>%
  count(date)
summary(data_untidy)

data_untidy %>%
  summarize(max(blood_wbc, na.rm = T),
            min(blood_wbc, na.rm = T),
            mean(blood_wbc, na.rm = T))

#checking for duplicates
data_untidy %>%
  count(id, sort = TRUE)


#Provides summary statistics - missing, complete, n and sd
#<https://www.rdocumentation.org/packages/skimr/versions/2.1.4>
skimr::skim(data_untidy)

#Graph showing frequency of missing for each variable
naniar::gg_miss_var((data_untidy))



#########################COLUMNS####################################

#Rename column name to "feature_type"
#A good practice to change names which start with numbers or have spaces
data_untidy <-
  new_data %>%
  rename(feature_type = `feature type`,
         age = `1.age`)

#Pivot "feature type" into "sex" and "race" data_untidy \<-
data_untidy <-
  data_untidy %>%
  pivot_wider(names_from  = feature_type,
              values_from = feature_value)

#viewing chosen columns
data_untidy %>%
  select(id, age, date) %>%
  head()


#changing order of columns
#not ending with everything() removes the other columns
data_untidy <-
  data_untidy %>%
  select(id,
         sex,
         race,
         starts_with("csf"),
         starts_with("blood"),
         everything())

#Turning a string column into numeric
data_untidy <-
  data_untidy %>%
  mutate(csf_prot = as.numeric(csf_prot))


#Rounding off decimal points for numeric
data_untidy <-
  data_untidy %>%
  # mutate(across(where(is.numeric), \~ round(., 2)))
  mutate(across(.cols = age, ~ round(., digits = 3))) %>%
  mutate(age = as.numeric(age))

#Creating a new ID column
data_untidy <-
  data_untidy %>%
  mutate(ID_new = 1:n())

#Comparison of two columns
data_untidy %>%
  select(id, ID_new) %>%
  mutate(if_else(as.character(id) == as.character(ID_new), "equal", "different"))

#Removes column "ID_new"
data_untidy <- subset(data_untidy, select = -c(ID_new))


#creating new columns by using a separator
data_untidy <-
  data_untidy %>%
  separate(date, into = c("year", "month"), sep = "-")

#removes dataset from the evironment
#remove(new_data)


#Ifelse and case_when 
data_untidy <-
  data_untidy %>%
  mutate(sex = if_else(sex == "female", "F", "M")) %>%
  mutate(race = case_when(
    race == "black" ~ "black",
    race == "white" ~ "white",
    race == "none" ~ NA_character_
  ))

#Arranging/sorting
data_untidy <-
  data_untidy %>%
  arrange(id)
#  arrange(desc(id))


head(data_untidy)


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
data_untidy <-
  data_untidy %>%
  subset(select = -c(gram, year, month))

merged_exam_data <- 
  data_untidy %>% 
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

#Data exploration
file <- merged_exam_data
skimr::skim(file) 
naniar::gg_miss_var(file)


