################################################################################

#                           1_0- GET THE DATA- SUBER_UNISS

################################################################################
library(readxl); library(readr)

# Load the xls file
data_0 <- readxl::read_excel("./DATA/UNITUS/XLS/data_castagno2.xlsx")

head(data_0)

colnames(data_0)
# [1] "id"                      
# [2] "inoculum"                
# [3] "treatment"               
# [4] "AnalysedRegionArea(cm2)" 
# [5] "AnalysedRegionWidth(cm)" 
# [6] "AnalysedRegionHeight(cm)"
# [7] "Length(cm)"      OK        
# [8] "ProjArea(cm2)"           
# [9] "SurfArea(cm2)"  OK          
# [10] "AvgDiam(mm)"  OK           
# [11] "RootVolume(cm3)"    OK     
# [12] "Tips"                    
# [13] "Forks"                   
# [14] "Crossings"     

# Elimina le colonne: Tips, Forks e Crossing, "AnalysedRegionArea(cm2)", "AnalysedRegionWidth(cm)", "AnalysedRegionHeight(cm)"
data <- subset(data_0, select = c( "id", "inoculum", "treatment", "Length(cm)", 
                                   "SurfArea(cm2)", "AvgDiam(mm)", "RootVolume(cm3)"))

colnames(data) <- c("id", "inoculum", "treatment", "length", "RSF", "AvgDiam", "VOLT")

write_csv(data, "./DATA/UNITUS/CSV/data_castagno2_0.csv")





# Calcola la mediana di length per ogni combinazione di inoculum e treatment
median_length <- aggregate(length ~ inoculum + treatment, data = data, FUN = median)

# Visualizza il risultato
print(median_length)
