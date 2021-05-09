setwd()

library("data.table")

#read dataset, remove ?s
consumptionDT <- data.table::fread("household_power_consumption.txt",
                                   na.strings="?")

#create a new column called DateTime by combining 'Date' and 'Time', convert it to POSIXct 
consumptionDT[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#subset wanted dates (include Feb 3rd now)
consumptionDT <- consumptionDT[(DateTime >= "2007-02-01") & (DateTime <= "2007-02-03")]


#plot 4 graphs in a 2x2 grid
par(mfrow = c(2,2))
#graph 1
with(consumptionDT, plot(DateTime, Global_active_power,
                         type = "l",
                         xlab = "",
                         ylab = "Global Active Power (kilowatts)"))

#graph 2
with(consumptionDT, plot(DateTime, Voltage,
                         type = "l",
                         xlab = "datetime",
                         ylab = "Voltage"))

#graph 3 (make legend smaller so it looks better on the png)
with(consumptionDT, plot(DateTime, Sub_metering_1, type = "n",
                         xlab="",
                         ylab="Energy sub metering"))
with(consumptionDT, points(DateTime, Sub_metering_1, type = "l"))
with(consumptionDT, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(consumptionDT, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1)
       , bty="n"
       , cex=.5)

#graph 4
with(consumptionDT, plot(DateTime, Global_reactive_power,
                         type = "l",
                         xlab="datetime", 
                         ylab="Global_reactive_power"))

#copy data to a png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
