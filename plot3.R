setwd()

library("data.table")

#read dataset, remove ?s
consumptionDT <- data.table::fread("household_power_consumption.txt",
                                   na.strings="?")

#create a new column called DateTime by combining 'Date' and 'Time', convert it to POSIXct 
consumptionDT[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#subset wanted dates (include Feb 3rd now)
consumptionDT <- consumptionDT[(DateTime >= "2007-02-01") & (DateTime <= "2007-02-03")]

#plot graph 3 (3 line graphs on one canvas)
with(consumptionDT, plot(DateTime, Sub_metering_1, type = "n",
                         xlab="",
                         ylab="Energy sub metering"))
with(consumptionDT, points(DateTime, Sub_metering_1, type = "l"))
with(consumptionDT, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(consumptionDT, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()