#day5 examscript 


#SS sapearte feature column into race and sex 
#Akash is rewriting 1-age to age 
#Theo is r  values_to = "",enaming date into date of birth 
#Daniel is remvoving duplicates 


separate(col = "feature_value",  #this does not work becasue it is character 
         into = c ("sex", "race"),
         sep = "_")

myData <-read_delim("exam_nontidy.txt", delim = "\t")
  
  myData %>%
  pivot_longer (names_to = "sex",
              
                cols = 4)
  
  

  library ("tidyverse")
  read_delim("exam_nontidy.txt", delim = "\t")
  view (read_delim("exam_nontidy.txt", delim = "\t"))
  
  
  myData <-read_delim("exam_nontidy.txt", delim = "\t")
  
  
  
  myData %>%
    pivot_wider(names_from = "feature type", values_from = race) #does not work, there is no object 'race'
  
  myData %>%
    pivot_wider(names_from = "feature type", values_from = "race") #does not work 
  

  
  
  view (read_delim("exam_nontidy.txt", delim = "\t"))
  
  myData %>%   #this works!!!!
    pivot_wider(names_from = "feature type", values_from = "feature_value")
  
  myData<-
  myData %>%  
    pivot_wider(names_from = "feature type", values_from = "feature_value")
  
 
    
  print(colnames("sex"))
  
  print(colnames("race"))
  
  print(colnames("id"))
  
  myData<-
  myData %>% 
    select(id, date,race, sex,  everything()) 
  
  
  myData<-
    myData %>% 
    select(id,) 
    
  #Aditi Branch
  #--------------------------------------------#
  #Day 5
  #--------------------------------------------#
  
  #Install and load packages
  # install.packages("tidyverse")
  library(tidyverse)
  library(here)
  #Change working directory
  #ls() - files in environment
  #remove(ls()) - removes all files in environment OBS!
  #dir() - files in directory
  
  #Load file into work environment
  #Separate columns using delimiter ("tab" - \t)
  
  read_delim("exam_nontidy.txt", delim = "\t")
  data_untidy <- read_delim("exam_nontidy.txt", delim = "\t")
  new_data <- read_delim("exam_nontidy.txt", delim = "\t")
  
  #view(data_untidy) - not recommended for large datasets
  head(data_untidy) # columns store values as <chr> which need to be converted to <numeric>
  summary(data_untidy)
  glimpse(data_untidy)
  data_untidy %>% 
    distinct()
  data_untidy %>% 
    count(date)
  
  #Duplicates
  data_untidy %>% 
    count(id, sort = TRUE)
  
  #Maximum and Minimum
  data_untidy %>% 
    summarize(max(blood_wbc, na.rm = T), 
              min(blood_wbc, na.rm = T), 
              mean(blood_wbc,na.rm = T))
  
  
  #Select
  data_untidy %>% 
    select(age_1, sex) %>% 
    head()
  
  #Change order of columns
  data_untidy <-
    data_untidy %>% 
    select(id, sex, race, starts_with("csf"), starts_with("blood"))
  
  data_untidy <- 
    data_untidy %>% 
    select(id, sex, race, everything())
  
  
  #Provides summary statistics - missing, complete, n and sd
  #https://www.rdocumentation.org/packages/skimr/versions/2.1.4
  skimr::skim(data_untidy) 
  
  #Graph showing frequency of missing for each variable
  naniar::gg_miss_var((data_untidy))
  
  
  
  #-------------------------------------#
  #The table is currently in the cross-sectional format. 
  #Multiple occurence of same ID.
  #-------------------------------------#
  
  data_untidy$`feature type` %>% 
    head()
  
  
  #Rename column name to "feature_type"
  #A good practice to change names which start with numbers or have spaces
  #data_untidy <- rename(data_untidy, feature_type = `feature type`)
  data_untidy <-
    data_untidy %>% 
    rename(feature_type = `feature type`,
           age_1 = `1.age`)
  
  #Pivot "feature type" into "sex" and "race"
  data_untidy <- pivot_wider(data_untidy, names_from = feature_type, values_from = feature_value )
  
  #Date - two columns - year and month
  
  
  #Turning a string column into numeric 
  data_untidy <-
    data_untidy %>% 
    mutate(csf_prot = as.numeric(csf_prot))
  
  
  #Creating a new ID column
  data_untidy <-
    data_untidy %>% 
    mutate(ID_new = 1:n())
  
  #Comparison of two columns
  data_untidy %>% 
    select(id, ID_new) %>% 
    mutate(if_else(
      as.character(id) == as.character(ID_new), "equal", "different"
    ))
  
  #Removes column "ID_new"
  new_data <- subset(data_untidy, 
                     select = -c(ID_new))
  remove(new_data) #removes dataset from the evironment
  
  
  
  
  #--------------------------------------------#
  #Day 6
  #--------------------------------------------#
  
  
  #Two ways of using if-else statements 
  data_untidy <-
    data_untidy %>% 
    mutate(sex = ifelse(sex == "female", "F", "M"))
  
  
  new_data <-
    data_untidy %>% 
    mutate(race = 
             case_when(
               race == "black" ~ "B",
               race == "white" ~ "W",
               race == "none" ~ NA_character_
             ))
  
  
  
  #arrange
  
  
  #Join two datasets 
  
  