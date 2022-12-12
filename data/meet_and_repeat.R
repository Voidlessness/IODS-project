# Joni Haikonen, data wrangling exercise 6 12.12.21

library(tidyverse)
library(dplyr)


# Loading the data and checking its structure and dimension

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep = '\t', header = TRUE)

str(BPRS) 
str(RATS)
dim(BPRS)
dim(RATS)

# Categorical variables turned to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID) 
RATS$Group <- factor(RATS$Group)

#Converting the data to long form and adding variables "week" to BPRS and "time" to RATS

BPRS_long <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% 
  mutate(weeks = as.integer(substr(weeks, 5, 5))) %>%
  arrange(weeks) 
RATS_long <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)

# Comparing the wide and long data structures
str(BPRS) 
str(BPRS_long)
str(RATS) 
str(RATS_long)


#Saving the data

saveRDS(BPRS_long, "data/BPRS_long.rds")
saveRDS(RATS_long, "data/RATS_long.rds")
