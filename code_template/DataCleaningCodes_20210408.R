input <- read.csv("C:/R/tutoring/code_template/tutoring_data_20210408.csv")

# subsetting
# Extract by name
input$GroupID

# extract by position (same as above)
input[[1]]

# print unique values in a column
unique(input$CommonName)

#remove column - all of these do the same thing
input2 <- subset(input, select = -GroupID.y) #by name
input2b <- subset(input, select = -(8)) #by col number
input2c <- input[, -8] #bracket subset by col number

#remove multiple columns - all of these do the same thing
input3 <- subset(input, select = -c(1:3, 6, 7:8)) #by col number
input3b <- subset(input, select = -c(GroupID, UTM_E, UTM_N, ImageDate, GroupID.y, dummy.na)) #by col name
input3c <- input[, -c(1:3, 6, 7:8)] #bracket subset by col number

#subset column by condition. these both do the same thing
Location151_0 <- subset(input, LocationName == "151_0")
Location151_0b <- input[input$LocationName == "151_0",]

#get rid of duplicated rows
#input has a duplicated row, use the unique() function to create a new dataframe the duplicated rows
NROW(input) #13 NROW function tells you number of rows
input.no.dups <- unique(input) #create a new dataframe without dups using the unique function
NROW(input.no.dups) #12

#duplicate column
input$GroupID.new <- as.character(input$GroupID) #duplicates column as character
input$GroupID.new[input$LocationName == "49_0"] <- "49_0_new" #change groupID for LocationName 49_0 to 49_0_new

#add columns with binary condition
input$deer <- 0 #this creates a new column called deer that is all zeros
input$deer[input$CommonName == "Mule.Deer"] <- 1 #this assigns rows where CommonName is Mule Deer a 1

#add column with binary with multiple conditions
input$recreator <- 0 #this creates a new column called recreator that is all zeros
input$recreator[input$CommonName == "Car.Truck.SUV" | # | represents "or"
                  input$CommonName == "Mountain.Bike" |
                  input$CommonName == "On.foot.non.mechanized"
] <- 1 #assign 1 to common names that indicate recreation

#lets add a binary column with "and" conditions. we'll assign a 1 to cars in GroupID 151
input$Cars151 <- 0
input$Cars151[input$GroupID == 151 & input$CommonName =="Car.Truck.SUV"] <- 1

#add row that sums multiple columns
input$summed <- rowSums(input[,3:5]) #creates a new row "summed" that sums columns 3 to 5 

#date/time
input$Date_Time_POSIXct <- as.POSIXct(input$ImageDate, "%m/%d/%Y %H:%M:%S", tz = "MST") #key for what these codes mean: https://www.flutterbys.com.au/stats/tut/tut3.4.html

#add day of year
library(lubridate)
input$Image_day_of_year <- yday(input$Date_Time_POSIXct) #yday() is lubridate function that creates day of year from POSIX date

#sort records by site, and then chronologically (by time field...not image name/number):
input <- input[with(input, order(LocationName, Date_Time_POSIXct )),]

#turn NAs into zeros is.na() function
input$dummy.na[is.na(input$dummy.na)] <- 0 
