mydata<-as.data.frame(read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE))
str(mydata)

for (i in 3:8){
    mydata[,i]<-as.numeric(mydata[,i])
}

str(mydata)
head(mydata$Voltage)

mydata[,1]<-as.Date(mydata[,1], "%d/%m/%Y" )

library(chron)
mydata[,2]<-chron(times=mydata[,2])

library(dplyr)
projectdata<-mydata%>%
    filter(Date=="2007-02-01" |Date=="2007-02-02")


datetime<-strptime(paste(projectdata$Date, projectdata$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

globalActivePower<-projectdata$Global_active_power

voltage<-projectdata$Voltage


Sub_metering_1<-projectdata$Sub_metering_1
Sub_metering_2<-projectdata$Sub_metering_2
Sub_metering_3<-projectdata$Sub_metering_3

globalReactivePower<-projectdata$Global_reactive_power


Sys.setlocale("LC_TIME", "English")
png("./data/plot4.png")  

par(mfrow=c(2,2))


plot(datetime, globalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(datetime, voltage, type="l", ylab="Voltage", xlab="datetime")

plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, Sub_metering_2, type="l", col="red")
lines(datetime, Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(datetime, globalReactivePower, type="l", ylab="Global_reactive_power", xlab="datetime")
axis(2, at=seq(0, 0.5, by=0.1), labels =seq(0.0, 0.5, by=0.1) )

dev.off()

