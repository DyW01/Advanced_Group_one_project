#install library "tidyverserve" and "here"
library(tidyverse)
library(here)

#read and view the datasets
read_delim(here("DATA","exam_nontidy.txt"))
view(read_delim(here("DATA","exam_nontidy.txt")))
mydata<-read_delim(here("DATA","exam_nontidy.txt"))
mydata
mydata<-read_delim(here("DATA","exam_nontidy.txt"), delim="\t")
head(mydata)

#rename variable that starts with number
mydata<-
  mydata %>%
  rename(age=`1.age`)
mydata

mydata<-
  mydata %>%
  rename(feature_type= `feature type`)
mydata

#transform the data from long tp wide
mydata<-
  mydata%>%
  pivot_wider(names_from =feature_type,
              values_from = feature_value)
mydata