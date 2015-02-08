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

plot2 <- function(){
    dat <- ParseData()
    head(dat$Time)
    plot(dat$Time, dat$Global_active_power, type="l", main = "", xlab="",ylab="Global Active Power (kilowatts)", col="black")
    dev.copy(png, file = "plot2.png")
    dev.off()
}

