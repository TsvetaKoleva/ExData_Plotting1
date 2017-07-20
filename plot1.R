
unzip("./data/powercons.zip", exdir="./data")
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

hist(projectdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "./data/plot1.png") 
dev.off()

