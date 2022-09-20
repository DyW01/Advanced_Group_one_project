# Exam description

Practical task in groups (4-5 persons).

You will create a GitHub repository or use the one you have created during the course. There, you need to collaborate, keep history of changes, push commits, etc. The log will be evaluated by us to check that each of you worked on a part of the final report.

The repository should contain:

-   *any scripts you have been using during the course* (choose one version or create a new one based on everyone's versions)
-   *any notes or log files you think were useful*
-   *the .Rproj file*
-   *nice folder structure*
-   *final .Rmd report and the .html or .md output*

## Data

You will receive an `exam_data.txt` file and the codebook describing the dataset (`codebook_exam_data.html`).

## Tasks

1.  Create an RStudio project.

    -   create a nice folder structure, e.g., data, scripts folders, and put the dataset in `data`, create a new R script or Rmarkdown file in `scripts`
    -   write a README and update its content as you go on

2.  Day 5: Read and tidy the dataset.\
    *(try to divide this task between the group members)*

    -   write all the commands and document!

    -   *tips:*

        -   some columns may need to be separated
        -   some columns can be duplicated
        -   some column names can contain spaces or start with numbers
        -   some columns can include values from various features/measurements

3.  Day 6: Tidy, adjust, and explore.\
    *(try to divide this task between the group members)*

    -   Remove unnecessary columns from your dataframe: `month, year, gram`
    -   Make necessary changes in variable types
    -   Create a set of new columns:
        -   A column showing whether `blood_neut_pct` is higher than 35 or not: values High/Low
        -   A numeric column showing `blood_cult` as a percentage of highest possible value (11)
        -   A column showing sex as `0/1` (and `NA` for missing, if any)
        -   A numeric column showing multiplication of `age` and `abm` for each person
    -   Set the order of columns as: `id, age, sex` and other columns
    -   Arrange ID column of your dataset in order of increasing number or alphabetically.
    -   Read and join the additional dataset to your main dataset.
    -   Connect above steps with pipe.
    -   Explore your data.
    -   Explore and comment on the missing variables.
    -   Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
    -   Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
        -   Only for persons with `blood_cult == 0`
        -   Only for females
        -   Only for persons older than 45
        -   Only for persons classified as black and blood_gluc higher than 120
    -   Use two categorical columns in your dataset to create a table (hint: ?count)

4.  Day 7: Create plots that would help answer these questions: *(each person chooses min.one question)*

    -   Are there any correlated measurements?
    -   Does the glucose level in blood depend on sex?
    -   Does the glucose level in blood depend on race?
    -   Does the glucose level in CSF (cerebrospinal fluid) depend on sex?
    -   Does the glucose level in CSF (cerebrospinal fluid) depend on race?

5.  Day 8: Analyse the dataset and answer the following questions: *(each person chooses one question)*

    -   Is there a difference in the occurrence of the disease by sex?
    -   Does the occurrence of the disease depend on age?
    -   Is there a difference in the occurrence of the disease by race?
    -   Is there a time trend in the occurrence of the disease?

6.  Write a short report in an Rmd format.\
    *(divide writing the report)*

General tips:

-   document, track changes (commit often!)
-   use descriptive names, don't cram the code on a small space
-   be active with commiting, commenting, etc.
-   you can have many short scripts - one per each task, or two-three longer scripts logically divided and neatly commented

## What can be used?

Everything! Google if you get stuck, use books, blogs, R-docs...!

*NB: if you have any technical issues, contact us!*

## Evaluation

-   We expect a clean history of changes and a nice structure of files.

-   Documentation of the scripts needs to be informative.

-   The code style will not be evaluated, but might influence our mood while performing evaluation ;)

-   In the end, we would like to receive a repository that includes:

    -   README file
    -   input data (and any other data if you generated during the coding)
    -   scripts where you were trying things out
    -   final .Rmd report (you may also include .html output or we can knit it ourselves)
    -   any documentation files, if you chose to have those
    -   .Rproj file

## Grading

The project will be evaluated individually and you will get an exhaustive description of your work, taking into account:

    - cleanliness of the files and file structure,
    - usage of the functions to complete the tasks described above,
    - the overall content of the final report.
