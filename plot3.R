library("data.table")
setwd("~/Mydocs/Coursera/project1/plots")
#loading data and making subset with appropriate dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# making date type
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# setting time period
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
# making plot
png("plot3.png", width=480, height=480)
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
dev.off()
