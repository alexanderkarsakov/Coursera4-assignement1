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
png("plot2.png", width=480, height=480)
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
