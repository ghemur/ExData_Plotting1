# plot1.R

# readr needed for read_delim
library(readr)
# Read the semicolon-separated file, with specified column types
powerData <- read_delim("data/household_power_consumption.txt",
                        delim = ";",
                        col_types = "ccnnnnnnn",
                        na = c("?"))

# Checkif the data looks OK
str(powerData)
summary(powerData)
names(powerData)

# Process the data - change to DateTime, filter the dates of interest,
# select just the columns needed for the plot
library(dplyr)
library(lubridate)

gap <- mutate(powerData, DateTime = dmy_hms(paste(Date, " ", Time), tz="America/Los_Angeles")) %>%
    filter(DateTime >= "2007-02-01" & DateTime < "2007-02-03") %>%
    select(DateTime, Global_active_power)
str(gap)

# Alternative 1 - build plot, then copy into file
# Disadvantage: the copy may not be accurate
hist(gap$Global_active_power,
     col="red", bg="transparent",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.copy(png, file="plot1.1.png", width=480, height=480)
dev.off()

# Alternative 2 - create the appropriate graphics file device, then build the plot
png("plot1.png", width=480, height=480)
hist(gap$Global_active_power,
     col="red", bg="transparent",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

