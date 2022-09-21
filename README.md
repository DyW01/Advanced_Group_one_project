# Advanced Group One Project

**Daanyaal:** Hello guys! This is my branch to work on tasks delegated in the coming week. Here are my scripts and notes located, and will be transferred to merge with main branch after completion

## **`We shall pass!`**

# Files

```{r}
#├── Advanced_Group_one_project.Rproj
#├── Data
#│   ├── codebook.html
#│   ├── exam_joindata.txt
#│   └── exam_nontidy.txt
#├── Group_1_RMD.html
#├── Group_1_RMD.Rmd
#├── README.md
#└── Scripts
#    ├── Exam_Collab_Script_Tidy_Group_One.R
#    ├── Participants_scripts
#    │   ├── Day_1_to_4_scripts
#    │   ├── Day_5_to_6_scripts
#    │   └── Day_7&8
```

# [![Clean all the data](images/68747470733a2f2f692e63687a6267722e636f6d2f66756c6c2f383132303830383434382f6832453138434133372f636c65616e2d616c6c2d7468652d64617461.jpg)](https://notebooks.githubusercontent.com/view/ipynb?browser=chrome&color_mode=auto&commit=fccb1ae7fff7a9bfdb2d1a27e28ee5b5152eddf6&device=unknown&enc_url=68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f5369646465736853616d6261736976616d2f4e54554f53532d446174615363726170696e672d416e642d44617461436c65616e696e672d576f726b73686f702f666363623161653766666637613962666462326431613237653238656535623531353265646466362f44617461253230436c65616e696e672e6970796e62&logged_in=false&nwo=SiddeshSambasivam%2FNTUOSS-DataScraping-And-DataCleaning-Workshop&path=Data+Cleaning.ipynb&platform=android&repository_id=294354232&repository_type=Repository&version=101)

This meme solidifies our commitment to tidying and describing data before we go on to analyzing it.

# Exam

-   We have two cases of acute meningitis:

    -   Viral (abm = 0) vs. bacterial (abm = 1) cases.

    -   Total of 581 patients, and missing data accordingly from n amount of patients

    -   There are samples from spinal fluid, and blood #Cases from year 1968 to 1980 #Population race and sex are defined

-   Our tasks are the following:

```{r}
    -   #Day_one: Read and tidy \# Delegate tidying task among the group
    -   #Day_two: Tidy, adjust and explore
    -   #Day_three:Create plots
    -   #Day_four: Analyze
    -   #Finally we will write a report and submit
```

### Day one

```{r}
-   #For orderly working progress, following steps are required:
    -   #Delete your previous branch, and make new branch with following name:
        -   #name_of_cand_Exam_Branch
        -   #In your branch, create your script, with following name:
                  #name_of_Cand_Exam_Script
    -   #We will merge the scripts to main eventually.
  
-   #Before starting the task, do the following:
    -   #In your branch_script, load both "tidyverse" and "here" packages
    -   #then read file with read_delim () function.
    -   #within parentheses add file name
    -   #NB! don't use the "dot" function (read.file()) \| this is not\
        #tidyverse function
  
-   #The candidates will do the following:
    -   #SS seperate feature into sex and race
    -   #Akash rewriting age colum
    -   #Theo renaming date into date of birth
    -   #DYW Removing duplicated row, and merge files
    -   #Aditi, read through readme and prepare 
                  #exempted because of attendance in another appointment
```

### Day two

```{r}
    - Are there any correlated measurements? (AD)
    - Does the glucose level in blood depend on sex? (SS)
    - Does the glucose level in blood depend on race? (DYW)
    - Does the glucose level in CSF (cerebrospinal fluid) depend on sex? (SS + THEO)
    - Does the glucose level in CSF (cerebrospinal fluid) depend on race? (AK + THEO)
```

### Day three and four

```{r}
#---------------- Final tasks and devition of tasks ------------------#
-   #Explore and comment on the missing variables.
-   #Check data distrubtion (everyone)
-   #Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
-   #Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
-   #Only for persons with blood_cult == 0
-   #Only for females
-   #Only for persons older than 45
-   #Only for persons classified as black and blood_gluc higher than 120
-   #Use two categorical columns in your dataset to create a table (hint: ?count)

-   #Create plots that would help answer these questions: 
    -   #Are there any correlated measurements
  
-   #Analyse the dataset and answer the following questions: (each person chooses one question)
-   #Is there a difference in the occurrence of the disease by sex? (DYW)
-   #Does the occurrence of the disease depend on age? (SS)
-   #Is there a difference in the occurrence of the disease by race? (AD )
-   #Is there a time trend in the occurrence of the disease? (AK +THEO)
```

### Day Five

```{r}
-   #We met in Haukeland Sykehus and worked on the project together. 
-   #Discussion and code sharing on Teams due to problems accessing Github
```
