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
  
  myData <- myData %>%
    rename(age = `1.age`) 
    
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
  
 
   tidy_data <-  #it works but made the data crazy 
    
    tidy_data %>% 
    pivot_wider(names_from = "date",
                values_from = "date",
    )
   
   
   tidy_data %>% 
  tidy_data %>% 
  separate(date,  
           into = c ("year", "month"),
           sep = "-")
  

tidy_data = tidy_data[,grep("^7", names (tidy_data))]

tidy_data <- myData

myData<-
myData %>% 
  separate(date,  
           into = c ("year", "month"),
           sep = "-")
         
tidy_data<-
  tidy_data %>% 
  separate(date,  
           into = c ("year", "month"),
           sep = "-")

view (tidy_data)

drop <- c("gram")

tidy_data<-
  
  drop <- c("gram")
  
view (tidy_data)

remove(drop)
tidy_data <- myData

tidy_data <- 
  
  tidy_data %>%
  subset (select = -c (gram))

view (tidy_data)

tidy_data <- 
  
  tidy_data %>%
  subset (select = -c (month))

view (tidy_data)

tidy_data <- 
  
  tidy_data %>%
  subset (select = -c (year))

view (tidy_data)


head(tidy_data) 
summary(tidy_data)
glimpse(tidy_data)

tidy_data <- 
  tidy_data %>%
  
mutate (age = as.numeric(age))%>%
  mutate(across(.col=age, ~round(.,digits =3)))

tidy_data <- 
  tidy_data %>%
  
  mutate (blood_wbc = as.numeric(blood_wbc))%>%
  mutate(across(.col=blood_wbc, ~round(.,digits =3)))



#create temporary dataset 
tempdata<- tidy_data
tidy_data %>%
  tempdata$blood_neut_pct2 <- c("m", "m", "f", "f", "m") 

remove (tempdata)

# Add a new column called blood_neut_pct2 to tidy_data
tempdata<- tidy_data
tidy_data %>%
tidy_data$blood_neut_pct2 <- c("m", "m", "f", "f", "m")


tidy_data <-
  tidy_data %>% 
  mutate(blood_neut_pct = if_else(blood_neut_pct >35, "High", "Low"))


