# Joni Haikonen, 13.11.22, Data Wrangling Exercise


library(tidyverse)
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)
dim(learning2014)
str(learning2014)

# The above data has 183 rows and 60 columns. str() prints out the data frame in the console.

library(dplyr)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

 
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)
 
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(lrn14, one_of(keep_columns))

learning2014 <- filter(learning2014, Points > 0)
dim(learning2014)
#Data now has 166 rows and 7 columns
str(learning2014)
library(readr)
write.csv(learning2014, file = 'C:/IODS/IODS-project/data/analysis_dataset.csv', row.names = FALSE)
read.csv(file = 'C:/IODS/IODS-project/data/analysis_dataset.csv')
analysis_dataset <- read.csv(file = 'C:/IODS/IODS-project/data/analysis_dataset.csv')
str(analysis_dataset)
head(analysis_dataset)
