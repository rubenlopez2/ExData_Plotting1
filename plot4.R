#Working directory is set where the data file is at

#Read the data looking only for the 1st and 2nd of Feb 2007
Data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = F, sep = ';')
#Add the column names
colnames(Data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
#Create a new column with the concatenated date-time values and formats them appropiately
Data <- cbind(Data,datetime=paste(Data$Date,Data$Time,sep=" "))
Data$datetime <- strptime(Data$datetime, "%d/%m/%Y %H:%M:%S")
#Create a pgn file 
png(filename = "plot4.png", width = 480, height = 480)
#Set up the parameters to make 4 graphs in a 2x2 configuration
par(mfrow=c(2,2))
#1st graph
plot(Data$datetime, Data$Global_active_power, type="l", ylab = "Global Active Power", xlab= "")
#2nd graph
plot(Data$datetime, Data$Voltage, type="l",ylab="Voltage",xlab="datetime")
#3rd graph
plot(x = Data$datetime, y= Data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(x = Data$datetime, y= Data$Sub_metering_2, col="red")
lines(x = Data$datetime, y= Data$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), lty= "solid",bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#4th graph
plot(Data$datetime, Data$Global_reactive_power, type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()