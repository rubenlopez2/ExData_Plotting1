#Working directory is set where the data file is at

#Read the data looking only for the 1st and 2nd of Feb 2007
Data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = F, sep = ';')
#Add the column names
colnames(Data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
#Create a new column with the concatenated date-time values and formats them appropiately
Data <- cbind(Data,datetime=paste(Data$Date,Data$Time,sep=" "))
Data$datetime <- strptime(Data$datetime, "%d/%m/%Y %H:%M:%S")
#Create a pgn file 
png(filename = "plot2.png", width = 480, height = 480)
#Line graph
plot(Data$datetime, Data$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab= "")
dev.off()