################################################################################

#                       1_0- GET THE DATA- SUBER UNISS

################################################################################
library(readxl); library(readr); library(readxl)

# Load the xls file
data_0 <- read_xlsx("./DATA/UCO/2nd Mesocosm experiment UCO.xlsx", sheet = "roots")

data_0$...1 <- NULL

head(data_0)

colnames(data_0)

write_csv(data_0, "./DATA/UCO/CSV/uco_roots.csv", append = F)
