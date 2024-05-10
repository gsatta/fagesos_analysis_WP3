################################################################################

#                       1_0- GET THE DATA- SUBER UNISS

################################################################################
library(readxl); library(readr)

# Load the xls file
data_0 <- read_csv("./DATA/UNISS/CSV/selected_columns.csv")

data_0$...1 <- NULL

head(data_0)

colnames(data_0)
# [1] "treatment"  "inoculum"   "sample_Id" 
# [4] "plant"      "length"     "avgDiam"   
# [7] "rootVolume" "lenPerVol"  "FRL"       
# [10] "CRL"        "FRS"        "CRS"       
# [13] "FVOL"     

colnames(data_0) <- c("treatment", "inoculum", "id","plant", "length", "AvgDiam", "VOLT",
                    "lenPerVol", "FRL", "CRL", "FRS", "CRS", "FVOL")

write_csv(data_0, "./DATA/UNISS/CSV/selected_columns_adj.csv", append = F)
















# Calcola la mediana di length per ogni combinazione di inoculum e treatment
median_length <- aggregate(length ~ inoculum + treatment, data = data, FUN = median)

# Visualizza il risultato
print(median_length)
