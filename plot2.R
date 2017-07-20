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
Sys.setlocale("LC_TIME", "English")
plot(datetime, globalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file = "./data/plot2.png") 
dev.off()
