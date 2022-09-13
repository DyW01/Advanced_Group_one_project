#-----SCRIPT for konsultasjon ----- #
#DO NOT RUN HERE, Copy everything and work on seperate branch or project#

#---- Load nescessary data------#

library(tidyverse)

here()
#no function named here
#that is why it is not working

#Load package "here", then run it again
library(here)
here()

#load data into R (make sure it is not opened in other program)
read_csv(here("Data_konsult", "konsultasjoner.csv"), delim = "\t")

#assigning data to object, observe environment

my_kons_data <- read_csv(here("Data_konsult", "konsultasjoner.csv"))
my_kons_data

my_kons_data <- read_delim(here("Data_konsult", "konsultasjoner.csv"), delim = "\t")
my_kons_data

#---- Viewing data------#
head(my_kons_data)
#can set amount of rows and tails
head(my_kons_data,7)
tail(my_kons_data,15)
#alder entries have ranges 

#---- other ways of viewing data------#
#view mydata, but not with large data, will make it crash
view(my_kons_data)

#Summary gives another way of looking at data, for this data not too usefull
summary(my_kons_data)

#tidyverse function glimpse, this will show them as a list
glimpse(my_kons_data)

#skimr function shows very important information (missing values, colomns etc)
#unique value (for instance catagorical value etc)
skimr::skim(my_kons_data)

#identifying missing data with following function
naniar::gg_miss_var((my_kons_data))


#accessing data in colomns with $ sign
my_kons_data$alder
head(my_kons_data$alder, 6)

#Using pipe, we start from the inside (aka variable) and working outwards with
#the functions we wish to apply to the variable. Thus a better setup
my_kons_data$alder %>%
  head()

#For example, pipe opens the line and makes it more accessible
#using pivot function to transform to longer table
my_kons_data %>%
  pivot_longer(names_to = "Year",
               values_to = "nConsultation",
               cols = 4:12)

#another way to do it
my_kons_data %>%
  pivot_longer(names_to = "Year",
               values_to = "nConsultation",
               cols = `2012`:`2020`)

view(my_kons_data)
#So far the data has not been changed, thus you can only veiw on console
#The above mentioned changes has to be assigned to the data

my_kons_data <-
  my_kons_data %>%
  pivot_longer(names_to = "Year",
               values_to = "nConsultation",
               cols = 4:12)
#now you can view the changes
View(my_kons_data)

#Now this will make it wider....
my_kons_data %>%
  pivot_wider(names_from = "Year",
              values_from = "nConsultation",)

#Further, it is also important to be able to seperate data
my_kons_data %>%
  separate(col = alder,
           into = c("minage", "maxAge"),
           sep = "-")
#the warning message tells me that the values are not fitting 
#check the values, and you will see that "dash" is making a problem

#You can also rename the colomns, here you do not need quotation for the newname
#this is because it is created in the same space 
my_kons_data <-
  my_kons_data %>%
  rename (alder = ager,
          kjonn = gender,
          diagnose = diagnosis)

view(my_kons_data)

#distinct function removes duplicated coloumns 
my_kons_data %>%
  distinct()

my_kons_data %>%
  count(alder)

#The file is still the same, but changes are applied to the "object" in R
#if we now want to save it, then use following  should be applied
filename <- paste0("tidy_consultations_", sys.date(),".txt")
write_delim(my_kons_data,
            file = here("Data_konsult", "my_kons_data_13_09_22"), delim = "\t")



#------------ Day 6 -------------------- # 
#now trying to tidy and mutate our column

#Changes column order
my_kons_data <- my_kons_data %>% 
  select(gender, age, everything()) 
view (my_kons_data)


#Next task, mutating content within cell from kvinner to K, and if not M for male

my_kons_data <-
  my_kons_data %>% 
  mutate(gender = if_else(gender == "Kvinner", "F", "M"))

view (my_kons_data)

#mutating to create new ID column
my_kons_data <-
  my_kons_data %>% 
  mutate(ID = 1:n())

#mutating to year to numeric 
my_kons_data<- my_kons_data %>% 
  mutate(Year = as.numeric(Year),
         nConsultation = as.numeric(nConsultation))


# After abovemention we can make new column for coonsultation before and after '15
# Also adding a step with pipe, to make ID be the first column 
# additionally changing order of nConsultation
# lastly showing nConsultaion in decreasing order
my_kons_data <-
  my_kons_data %>% 
  mutate(consBefore2015 = if_else(Year >= 2015, "No", "Yes"))%>%
  select(ID, nConsultation, everything()) %>%
  arrange(desc(nConsultation))

view(my_kons_data)
my_kons_data <-
  
  
  #Count to make sure transformation was correct and view if you can
  my_kons_data %>%
  count

View(my_kons_data)

#checking for missing value, shows in graf
naniar::gg_miss_var(my_kons_data)

#To check for missing value specific to each gender
naniar::gg_miss_var(my_kons_data, facet = gender)


#summarize
my_kons_data%>%
  summarise(mean(nConsultation, na.rm = T),
            mean(nConsultation > 1000), na.rm = T)

#summarize by specific group
my_kons_data%>%
  group_by(gender)%>%
  summarise(max(nConsultation, na.rm = T), min(nConsultation > 1000), na.rm = T)

my_kons_data%>%
  group_by(gender)%>%
  summarise(mean(nConsultation, na.rm = T))

my_kons_data%>%
  group_by(gender)%>%
  summarise(meanConsultaions = mean(nConsultation, na.rm = T))


#Filtering data
my_kons_data%>%
  filter(Year = 2015)

#The error message now tells you what to do, basically use == instead of =

my_kons_data%>%
  filter(Year == 2015)

#We are not assigning, as we are just checking. By assigning we would transform
#To really check if this work, you can count year, to see if it matches 

#First just count year, than the combined expression
my_kons_data%>%
  count(Year)

my_kons_data%>%
  filter(Year == 2015)%>%
  count(Year)

# There is also another way to check within a range (Be aware of ">" and "<")
my_kons_data%>%
  filter(Year > 2016 & Year <2019)%>%
  count(Year)

#now to filter for range, with the sign | meaning or
my_kons_data%>%
  filter(age == "0-5" | age == "6-15" | age == "16-19")%>%
  count(age)
#it is also possible to filter by comma
my_kons_data%>%
  filter(age == "0-5",Year >= 2016)%>%
  count(age)

#Filter for missing value
my_kons_data%>%
  filter(is.na(nConsultation))
#This will reveal that the missing data is in men, as they dont have underlivsplager
