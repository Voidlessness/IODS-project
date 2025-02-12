
# Loading the data
library(tidyverse)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Exploring the structure of the data & creating summaries
str(hd)
str(gii)
dim(gii)
dim(hd)
summary(hd)
summary(gii)

# Renaming the variables for both datasets and checking that the change is correct. I decided to use my own abbreviations.
library(dplyr)
colnames(hd)

hd <- hd %>% rename("HDR" = "HDI Rank",
                    "Ctry" = "Country",
                    "HDI" = "Human Development Index (HDI)",
                    "Life_exp" = "Life Expectancy at Birth",
                    "Exp_yr_edu" = "Expected Years of Education",
                    "Mean_yr_edu" = "Mean Years of Education",
                    "GNI" = "Gross National Income (GNI) per Capita",
                    "GNI-HDI" = "GNI per Capita Rank Minus HDI Rank")
colnames(hd)  

colnames(gii)

gii <- gii %>% rename ("GII_R" = "GII Rank",
                       "Ctry" = "Country",
                       "GII" = "Gender Inequality Index (GII)",
                       "Mat_mort_r" = "Maternal Mortality Ratio",
                       "Ad_birth_r" = "Adolescent Birth Rate",
                       "%rep_parl" = "Percent Representation in Parliament",
                       "Pop_sec_edu_f" = "Population with Secondary Education (Female)",
                       "Pop_sec_edu_m" = "Population with Secondary Education (Male)",
                       "Labforc_parr_f" = "Labour Force Participation Rate (Female)",
                       "Labforc_parr_m" = "Labour Force Participation Rate (Male)")
colnames(gii)

# Creating new variables for gii
gii <- mutate(gii, sec_edu_r = Pop_sec_edu_f/Pop_sec_edu_m, labforc_r = Labforc_parr_f/Labforc_parr_m)

# Combining the two datasets and checking its dimensions. It indeed has 195 obsevables and 19 variables!
hd_gii <- inner_join(hd, gii, by = "Ctry")
dim(hd_gii)

# Saving the data as human.csv
library(readr)
write.csv(hd_gii, file = 'C:/IODS/IODS-project/data/human.csv', row.names = FALSE)


# Reading the human.csv file
human <- read.csv(file = 'C:/IODS/IODS-project/data/human.csv')

# Exploring structure and dimensions of human.
str(human)
dim(human)
colnames(human)
# Making the GNI variable numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

colnames(human)

# Excluding uneeded variables
keepVariables <- c("Ctry", "labforc_r", "sec_edu_r", "Exp_yr_edu", "Life_exp", "GNI", "Mat_mort_r", "Ad_birth_r", "X.rep_parl")
human <- select(human, one_of(keepVariables))
colnames(human)

# Removing all rows with missing values
human <- filter(human, complete.cases(human))
tail(human, n = 10)
last <- nrow(human) - 7
human <- human[1:last, ]

# Defining rownames and country names
rownames(human) <- human$Ctry

# Removing the country column
human <- select(human, -Ctry)

# Checking for the dimensions of human. Indeed it has 155 observations and 8 variables!
dim(human)
human

write.table(human, file = 'C:/IODS/IODS-project/data/human2.txt')
read.table(file = 'C:/IODS/IODS-project/data/human2.txt', sep = "\t")
