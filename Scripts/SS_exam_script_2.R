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

#seperating column date into year and month
tidy_data<-
  tidy_data %>% 
  separate(date,  
           into = c ("year", "month"),
           sep = "-")

#remvoing unwanted col
tidy_data <- 
  tidy_data %>%
  subset (select = -c (gram))



tidy_data <- 
  tidy_data %>%
  subset (select = -c (month))

tidy_data <- 
  tidy_data %>%
  subset (select = -c (year))

#removing decimals from age
tidy_data <- 
  tidy_data %>%
  mutate (age = as.numeric(age))%>%
  mutate(across(.col=age, ~round(.,digits =3)))

#removing decimals from blood_wbc
tidy_data <- 
  tidy_data %>%
  mutate (blood_wbc = as.numeric(blood_wbc))%>%
  mutate(across(.col=blood_wbc, ~round(.,digits =3)))

#creating new column (not for this data)
tempdata<- tidy_data
  tempdata$blood_neut_pct2 <- c("m", "m", "f", "f", "m")
  
  
  # What are the names of columns in the tidy_data dataframe?
  names(tidy_data) 
  
  # Return the blood_neut_pct column of tidy_data
  tidy_data$ blood_neut_pct 
  
  # Create duplicate of column with new name
   tidy_data$blood_neut_pct2 <- tidy_data$blood_neut_pct  
   
  #categorizing blood_neut_pct into high and low 
    tidy_data <-
    tidy_data %>%
     mutate(blood_neut_pct2 = if_else(blood_neut_pct2 >35, "High", "Low"))
    
  # Create duplicate of column with new name
    tidy_data$sex2 <- tidy_data$sex  
    
 #  A column showing sex as `0/1` (and `NA` for missing, if any) 
 tempdata <-
      tempdata %>% 
      mutate(sex2 = if_else(sex == "female", 0, 1,na.rm=TRUE)) 
 
 #A numeric column showing multiplication of `age` and `abm` for each person
         tidy_data<-
   tidy_data %>% 
   mutate(agexabm = 1:n()) #cannot use this 
 
          tidy_data <- 
   tidy_data %>%
   subset (select = -c (agexabm)) #remvoing the col i created
 
 #A numeric column showing multiplication of `age` and `abm` for each person         
  tempdata$agexabm <- tempdata$age 
  tempdata$agexabm <- with (tempdata, age * abm)
  tempdata$agexabm <- tempdata$age * tempdata$abm
            
  tempdata <-
    tempdata %>% 
    mutate(agexabm = as.numeric(agexabm))         

  #Set the order of columns as: `id, age, sex` and other columns
  tempdata <- 
    tempdata %>%
  select(id, age, sex, everything())
  
 # Arrange ID column of your dataset in order of increasing number or alphabetically.
  tempdata %>% 
    arrange(id)
  
 # Read and join the additional dataset to your main dataset. I cannot do this!!
 # https://www.geeksforgeeks.org/joining-of-dataframes-in-r-programming/#:~:text=In%20R%20we%20use%20merge,similarly%20like%20join%20in%20DBMS.
  tempdata = merge(x = "exam_nontidy.txt", y = "exam_joindata.txt", by = "id", "csf_gluc",
             all = TRUE)
  tempdata <-
    tempdata %>%
  full_join(y = "exam_joindata.txt", by = "id")

 # Connect above steps with pipe. 
  
  #Explore your data.
  #Explore and comment on the missing variables.
  naniar::gg_miss_var((tempdata))
  
  
  #Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
  tempdata %>% 
    group_by(sex) %>% 
    summarise(max(blood_wbc, na.rm = T), min(blood_wbc, na.rm = T),mean(blood_wbc,na.rm = T),sd(blood_wbc, na.rm =T))
  tempdata %>% 
    group_by(race) %>% 
    summarise(max(blood_wbc, na.rm = T), min(blood_wbc, na.rm = T),mean(blood_wbc,na.rm = T),sd(blood_wbc, na.rm =T))
  
  
  #Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
     Only for persons with `blood_cult == 0`
  Only for females
  Only for persons older than 45
  Only for persons classified as black and blood_gluc higher than 120
  Use two categorical columns in your dataset to create a table (hint: ?count) 
  
  remove (tempdata)
  tempdata <- tidy_data
  
  
  head(tidy_data$blood_neut_pct) 
  summary(tidy_data$blood_neut_pct)
  glimpse(tidy_data$blood_neut_pct)
  