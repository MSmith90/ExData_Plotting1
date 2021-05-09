setwd()

library("data.table")

#read dataset, remove ?s
consumptionDT <- data.table::fread("household_power_consumption.txt",
                                  na.strings="?")

#change consumptionDT$Date to a 'date' class and subset wanted dates
consumptionDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

consumptionDT <- consumptionDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#plot graph 1 (histogram)
with(consumptionDT, hist(Global_active_power, col = "red",
                         main = "Global Active Power",
                         xlab = "Global Active Power (kilowatts)",
                         ylab = "Frequency"))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()