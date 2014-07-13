#Working directory is set where the data file is at

#Read the data looking only for the 1st and 2nd of Feb 2007
Data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = F, sep = ';')
#Add the column names
colnames(Data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
#Create a new column with the concatenated date-time values and formats them appropiately
Data <- cbind(Data,datetime=paste(Data$Date,Data$Time,sep=" "))
Data$datetime <- strptime(Data$datetime, "%d/%m/%Y %H:%M:%S")
#Create a pgn file 
png(filename = "plot3.png", width = 480, height = 480)
#First line
plot(x = Data$datetime, y= Data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
#Second line
lines(x = Data$datetime, y= Data$Sub_metering_2, col="red")
#Third line
lines(x = Data$datetime, y= Data$Sub_metering_3, col="blue")
#Set up the legend
legend("topright", col = c("black", "red", "blue"), lty= "solid",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()