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

## Plot3() called by plot 4, left as a seperate function for neatness

plot3 <- function(dat){
    plot(dat$Time, dat$Global_active_power, type="n", main = "", xlab="",ylab="Energy Sub Metering", ylim=c(0,38))
    lines(dat$Time, dat$Sub_metering_1, type="l", col="black")
    lines(dat$Time, dat$Sub_metering_2, type="l", col="red")
    lines(dat$Time, dat$Sub_metering_3, type="l", col="blue")
    cols <- colnames(dat)
    legend("topright", cols[7:9], lty=c(1,1,1), col=c("black", "red", "blue"))
}

plot4 <- function(dat){
    dat <- ParseData()
    
    par(mfrow=c(2,2), mar=c(4,4,1,1))
    plot(dat$Time, dat$Global_active_power, type="l", main = "", xlab="",ylab="Global Active Power", col="black")
    plot(dat$Time, dat$Voltage, type="l", main = "", xlab="datetime",ylab="Voltage", col="black", ylim=c(230,250))
    plot3(dat)
    plot(dat$Time, dat$Global_reactive_power, type="l", main = "", xlab="datetime", ylab="Global_reactive_power", col="black", ylim=c(0.0,0.5))
    
    dev.copy(png, file = "plot4.png")
    dev.off()
}