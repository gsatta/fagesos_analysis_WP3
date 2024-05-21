################################################################################

#                       1_0_1- Select the necessary columns

################################################################################

library(dplyr)
# In this section all the column necessary to the analysis are selected from the data set.

# Load the combined data set previosly stored
dataframe <- read_csv("./DATA/UCO/CSV/uco_roots.csv")

# Select the necessary columns of the roots parameters
cols_fine_roots_lenght <- dataframe %>%
  select(1:3, 20:23)

cols_fine_roots_lenght <- cols_fine_roots_lenght %>%
  mutate(FRL = rowSums(select(., 4:7)))

cols_coarse_roots_lenght <- dataframe %>%
  select(1:3, 26:31)

cols_coarse_roots_lenght <- cols_coarse_roots_lenght %>%
  mutate(CRL = rowSums(select(., 4:9)))

cols_fine_roots_VOL <- dataframe %>%
  select(1:3, 42:45)

cols_fine_roots_VOL <- cols_fine_roots_VOL %>%
  mutate(FVOL = rowSums(select(., 4:7)))

cols_coarse_roots_VOL <- dataframe %>%
  select(1:3, 46:51)

cols_coarse_roots_VOL <- cols_coarse_roots_VOL %>%
  mutate(CVOL = rowSums(select(., 4:9)))

# Create a combined dataframe and add all the new columns step by step
combined_df <- dataframe %>%
  left_join(cols_fine_roots_lenght %>% select(treatment, sample, FRL), by = c("treatment", "sample")) %>%
  left_join(cols_coarse_roots_lenght %>% select(treatment, sample, CRL), by = c("treatment", "sample")) %>%
  left_join(cols_fine_roots_VOL %>% select(treatment, sample, FVOL), by = c("treatment", "sample")) %>%
  left_join(cols_coarse_roots_VOL %>% select(treatment, sample, CVOL), by = c("treatment", "sample"))

# Controlla se tutte le colonne sono state aggiunte
print(combined_df)

# Select only the columns number 1:4, 19, 25, 29, 33, 32, 34, 27, 126, 127, 128, 129, 130
selected_columns <- combined_df %>%
  select(1:3, 8, 10, 13, 15, 52:55 )

# Assing the new names to the columns
colnames(selected_columns) <- c("sample", "treatment"," inoculum","dry_solo", "length", "AvgDiam", "rootVolume", "FRL", "CRL", "FVOL", "CVOL")

# Check if the columns have a new names 
colnames(selected_columns)

# Store the selected_columns data frame in csv format
write.csv(selected_columns, "./DATA/UCO/CSV/selected_columns.csv", append = FALSE)

selected_columns <- read_csv("./DATA/UCO/CSV/selected_columns.csv") 

selected_columns$...1 <- NULL
