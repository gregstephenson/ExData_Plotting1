ParseData <- function(){
    colnametable <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", nrow=2)
    cols <- colnames(colnametable) 
    
    rawDat <- read.table("household_power_consumption.txt", sep=";", col.names=cols, na.strings="?", skip=66637, nrow=2880)
    
    rawDat$Time <- as.POSIXct(paste(rawDat$Date, rawDat$Time), format="%d/%m/%Y %H:%M:%S")
    rawDat$Date <- as.Date(rawDat$Date, format="%d/%m/%Y")
    rawDat
}