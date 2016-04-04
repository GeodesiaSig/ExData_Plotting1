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
data_final <- mutate(data_final, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
                     Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
                     Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))
#doing the plot
png(filename = "plot3.png", units = "px", height = 480, width = 480)
with(data_final, plot(x = Date, y = Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(data_final, lines(x = Date, y = Sub_metering_1, col = "black"))
with(data_final, lines(x = Date, y = Sub_metering_2, col = "red"))
with(data_final, lines(x = Date, y = Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
