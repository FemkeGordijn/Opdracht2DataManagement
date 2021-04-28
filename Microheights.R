getwd()
setwd("C:/Users/fherr/OneDrive/Data Management")
library("data.table")
library("dplyr")
Microheights <- fread("Querymicroheightskleineletters.csv")
Historyofwork <- fread("Queryhistoryofwork.csv")
colnames(Historyofwork) <- c("occupation", "occupationalCategory")
colnames(Microheights) <- c("bdec", "occupation", "ht_n", "avg_height")
Historyofwork <- Historyofwork[-c(1, 2),]
Microheights <- Microheights[-c(1, 2),] # Remove the first two rows.
Microheights_and_Historyofwork <- merge(Microheights, Historyofwork, by = "occupation", all = T)
Microheights_and_Historyofwork <- Microheights_and_Historyofwork[which(Microheights_and_Historyofwork$occupation != "NA"),]
Microheights_and_Historyofwork <- Microheights_and_Historyofwork[which(Microheights_and_Historyofwork$bdec != "NA"),]  # Remove everything but the hiscode code
Microheights_and_Historyofwork <- filter(Microheights_and_Historyofwork, !grepl("status|relation|product", occupationalCategory))
Microheights_and_Historyofwork$occupationalCategory <- gsub("[a-z]", "", Microheights_and_Historyofwork$occupationalCategory) # remove all letters.
Microheights_and_Historyofwork$occupationalCategory <- gsub("[[:punct:]]", "", Microheights_and_Historyofwork$occupationalCategory) # remove all punctuation characters, especially /
setwd("C:/Users/fherr/OneDrive/Data Management")
write.table(Microheights_and_Historyofwork, file = "Microheights_and_Historyofwork5.csv", quote = FALSE, sep = ",", col.names = TRUE, row.names =  FALSE) # save dataframe as csv file.
