#load library and set working directory
library("data.table")
setwd("~/Mydocs/Coursera/project1/plots")
#loading data and making subset with appropriate dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# making date type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
# setting time period
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
# making plot
png("plot1.png", width=480, height=480)
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
