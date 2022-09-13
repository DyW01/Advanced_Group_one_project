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
    
  