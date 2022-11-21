# Joni Haikonen, 20.11.22, Data Wrangling Exercise

library(tidyverse)
# creating objects mat and por from the downloaded CSV files.
mat <- read.csv(file = 'C:/IODS/IODS-project/data/student-mat.csv', sep = ";", header = TRUE)
por <- read.csv(file = 'C:/IODS/IODS-project/data/student-por.csv', sep = ";", header = TRUE)

# First I just print out the datasets to look at them.
por
mat

# Exploring the dimensions of the data. mat has 395 columns and 33 rows, por has 649 rows and 33 columns.
# Also checking the column names with colnames()
dim(mat)
dim(por)
str(mat)
str(por)
colnames(mat)
colnames(por)

# Combining the datasets and glimpsing at the data
library(dplyr)
free_cols <- c("failures", "paid", "absences", "G1", "G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))
colnames(mat_por)
glimpse(mat_por)
dim(mat_por)

# print out the column names of 'mat_por'
colnames(mat_por)

# create a new data frame with only the joined columns
alc <- select(mat_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
free_cols

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(mat_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data

glimpse(alc)

# creating a new column called "alc_use" which has the average of weekday and weekend use of alcohol
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# defining a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)
#having a glimpse at the data. It indeed has 370 observations!
glimpse(alc)

# Saving the data as a .csv file

library(readr)
write.csv(alc, file = 'C:/IODS/IODS-project/data/alc_data.csv', row.names = FALSE)

# Making sure the data is readable and accurate.
alc_data <- read.csv(file = 'C:/IODS/IODS-project/data/alc_data.csv', sep = ",", header = TRUE)
dim(alc_data)
