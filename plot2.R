setwd()

library("data.table")

#read dataset, remove ?s
consumptionDT <- data.table::fread("household_power_consumption.txt",
                                   na.strings="?")

#create a new column called DateTime by combining 'Date' and 'Time', convert it to POSIXct 
consumptionDT[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#subset wanted dates
consumptionDT <- consumptionDT[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]


#plot graph 2 (line graph)
with(consumptionDT, plot(DateTime, Global_active_power,
                         type = "l",
                         xlab = "",
                         ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()