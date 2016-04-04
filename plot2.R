#preparing source file
library(dplyr, lubridate)
url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = url_data, destfile = basename(url_data))
unzip(basename(url_data))
datos <- tbl_df(read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";"))
datos <- mutate(datos, Date = dmy(Date))
data_final <- filter(datos, Date ==  ymd("2007-02-01") | Date == ymd("2007-02-02"))
rm(datos)
data_final <- mutate(data_final, Global_active_power = as.numeric(as.character(Global_active_power)),
                     Time = hms(as.character(Time)))

data_final$Date <- update(data_final$Date, hour = data_final$Time@hour, minute = data_final$Time@minute)

#doing the plot
png(filename = "plot2.png", units = "px", height = 480, width = 480)
with(data_final, plot(x = Date, y = Global_active_power,type = "n", ylab = "Global active power (kilowatts)", xlab = ""))
with(data_final, lines(x = Date, y = Global_active_power))
dev.off()
