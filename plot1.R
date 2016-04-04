#preparing source file
library(dplyr, lubridate)
url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = url_data, destfile = basename(url_data))
unzip(basename(url_data))
datos <- tbl_df(read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";"))
datos <- mutate(datos, Date = dmy(Date))
data_final <- filter(datos, Date ==  ymd("2007-02-01") | Date == ymd("2007-02-02"))
rm(datos)
data_final <- mutate(data_final, Global_active_power = as.numeric(as.character(Global_active_power)))


#doing the plot
attach(data_final)
png(filename = "plot1.png", units = "px", height = 480, width = 480)
hist(Global_active_power, col = "red", 
     main = "Global active power", 
     xlab = "Global active power (kilowatts)")
dev.off()


