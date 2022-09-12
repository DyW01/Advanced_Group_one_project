#---- Load nescessary data------#

library(tidyverse)

here()
#no function named here
#that is why it is not working

#Load package "here", then run it again
library(here)
here()

#load data into R (make sure it is not opened in other program)
read_csv(here("Data", "konsultasjoner.csv"))

#assigning data to object, observe environment

my_data<- read_csv(here("Data", "konsultasjoner.csv"))
my_data


#reading data with function read.delim, since the data is tab delimited
my_data <- read_delim(here("Data", "konsultasjoner.csv"))
my_data


#---- Viewing data------#
head(my_data)
#can set amount of rows and tails
head(my_data,7)
tail(my_data,15)
#alder entries have ranges 

#---- other ways of viewing data------#
#view mydata, but not with large data, will make it crash
view(my_data)

#Summary gives another way of looking at data, for this data not too usefull
summary(my_data)

#tidyverse function glimpse, this will show them as a list
glimpse(my_data)

#skimr function shows very important information (missing values, colomns etc)
#unique value (for instance catagorical value etc)
skimr::skim(my_data)

#identifying missing data with following function
naniar::gg_miss_var((my_data))


#accessing data in colomns with $ sign
my_data$alder
head(my_data$alder, 6)

#Using pipe, we start from the inside (aka variable) and working outwards with
#the functions we wish to apply to the variable. Thus a better setup
my_data$alder %>%
head()

#For exammyle, pipe opens the line and makes it more accessible
#using pivot function to transform to longer table
my_data %>%
  pivot_longer(names_to = "Year",
                values_to = "nConsultation",
                cols = 4:12)

#another way to do it
my_data %>%
  pivot_longer(names_to = "Year",
                values_to = "nConsultation",
                cols = `2012`:`2020`)

view(my_data)
#So far the data has not been changed, thus you can only veiw on console
#The above mentioned changes has to be assigned to the data

my_data <-
  my_data %>%
  pivot_longer(names_to = "Year",
               values_to = "nConsultation",
               cols = 4:12)
#now you can view the changes
View(my_data)

#Now this will make it wider....
my_data %>%
  pivot_wider(names_from = "Year",
              values_from = "nConsultation",)

#Further, it is also important to be able to seperate data
my_data %>%
  separate(col = alder,
           into = c("minage", "maxAge"),
                   sep = "-")
#the warning message tells me that the values are not fitting 
#check the values, and you will see that "dash" is making a problem

#You can also rename the colomns, here you do not need quotation for the newname
#this is because it is created in the same space 
my_data <-
  my_data %>%
  rename (alder = age,
          kjonn = gender,
          diagnose = diagnosis)

view(my_data)

#distinct function removes duplicated coloumns 
my_data %>%
  distinct()

my_data %>%
  count(alder)

#The file is still the same, but changes are applied to the "object" in R
#if we now want to save it, then use following  should be applied
filename <- paste0("tidy_consultations_", sys.date(),".txt")
write_delim(my_data,
            file = here("Data", "my_data_12_09_22"), delim = "\t")
  