ParseData <- function(){
    ## Keep column names intact
    colnametable <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", nrow=2)
    cols <- colnames(colnametable) 
    
    ## Read relevant lines from data file
    rawDat <- read.table("household_power_consumption.txt", sep=";", col.names=cols, na.strings="?", skip=66637, nrow=2880)
    
    ## Parse times and dates to actual times and dates
    rawDat$Time <- as.POSIXct(paste(rawDat$Date, rawDat$Time), format="%d/%m/%Y %H:%M:%S")
    rawDat$Date <- as.Date(rawDat$Date, format="%d/%m/%Y")
    
    rawDat
}

plot1 <- function(){
    dat <- ParseData()
    hist(dat$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
    
    ## Output to .png
    dev.copy(png, file = "plot1.png")
    dev.off()
}