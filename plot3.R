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

plot3 <- function(){
    dat <- ParseData()
    par(mfrow=c(1,1), mar=c(3,4,2,1))
    plot(dat$Time, dat$Global_active_power, type="n", main = "", xlab="",ylab="Energy Sub Metering", ylim=c(0,38))
    lines(dat$Time, dat$Sub_metering_1, type="l", col="black")
    lines(dat$Time, dat$Sub_metering_2, type="l", col="red")
    lines(dat$Time, dat$Sub_metering_3, type="l", col="blue")
    cols <- colnames(dat)
    legend("topright", cols[7:9], lty=c(1,1,1), col=c("black", "red", "blue"))
    dev.copy(png, file = "plot3.png")
    dev.off()
}