#Working directory is set where the data file is at

#Read the data looking only for the 1st and 2nd of Feb 2007
Data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = F, sep = ';')
#Add the column names
colnames(Data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

#Create a pgn file 
png(filename = "plot1.png", width = 480, height = 480)
#Histogram with red bars
hist(Data$Global_active_power, col ="Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()