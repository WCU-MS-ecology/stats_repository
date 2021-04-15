# Part 1: Setting Working Directory
# To assign a working directory (where Rstudio finds your script (*R) and data (*.csv or *.xlsx) files)
# In Rstudio: Go to "Files" tab in lower right-hand window to navigate to the file location of your data file. From the "tool bar" in this window, click "more" and set this folder as your working directory. 
# In R: Go to "session" on the upper tool bar and select "Set working directory". On a Mac you can use cmd-D to change the working directory.
# To see where your current working directory is type: 
getwd()

# Part 2: Sending commands from code editor window (upper left window) to R (lower left window)
# In the code editor highlight the command you wish to run
# Click "run" icon located in the upper right hand corner of the code editor window OR press "ctrl + enter" (PC users) OR "command + enter" (Mac users)

# Part 3: Importing data into R
# Importing a ".csv" file
# In Rstudio in the "Workspace History" window (upper right hand corner): 1) Click on the "Import Dataset" icon, 2) Select "From text (base)." (for csv files), 3) Select your file from your folder
# To view your dataset enter: 
# View(mydata)
View(treedata)

# To view a variable in a dataset enter: 
# mydata$variable
treedata$species

# May need to attach the dataset to a variable by entering: 
# attach(mydata)
attach(treedata)

# This allows you to type just the variable name without entering the dataset name.
# variable
species

# Part 4: Creating a histogram in R
# Histograms can be created in R using the function hist(x) where x is a numeric vector of values to be plotted.
# Enter in R: hist(x)
hist(treedata$dbh)

# To generate a histogram with a specified number of bins enter in R: hist(x, breaks = #bins)
hist(treedata$dbh, breaks = 50)

# To add a title, y-axis label, and color:
# hist(mydata,main="titel name,xlab="x variable",border="color", col="color",xlim=c(0,120),las=1,breaks=5)
hist(dbh,main="Tree size for urban parks", xlab="Tree dbj", border="blue",col="green",xlim=c(0,120),las=1,breaks=5)

# More information about histograms can be found here: https://www.datacamp.com/community/tutorials/make-histogram-basic-r?utm_source=adwords_ppc&utm_campaignid=1565261270&utm_adgroupid=67750485268&utm_device=c&utm_keyword=&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=332661264371&utm_targetid=dsa-473406586075&utm_loc_interest_ms=&utm_loc_physical_ms=9029132&gclid=Cj0KCQjwufn8BRCwARIsAKzP695HuLdEjMrAh4tGabg1EN4FBCYhem9KrA2xZwYx1kbkPfAzUBFjvQwaAvojEALw_wcB#how

# Part 5:Creating Q-Q plots
# The R base functions qqnorm() and qqplot() can be used to produce quantile-quantile plots:
# qqnorm(): produces a normal QQ plot of the variable
# qqline(): adds a reference line
qqnorm(dbh)
qqline(dbh)

# to get rid of fram around graph and to change the color of the line
qqnorm(dbh, pch = 1, frame = FALSE)
qqline(dbh, col = "steelblue", lwd = 2)

#Part 6: Skewness and Kurtosis
#Install the package "moments" from the "Packages" tab in the lower right window of Rstudio
install.packages("moments")
library("moments")

# test for skewness
skewness(dbh, na.rm = FALSE) 

# create new dataset without missing data
new_treedata <- na.omit(treedata)
new_treedata

# test for skewness
skewness(new_treedata$dbh) 
hist(new_treedata$dbh)

# test for kurtosis
kurtosis (new_treedata$dbh) 
hist(new_treedata$dbh)

# Z-scores
# Install package if not already available
install.packages("pastecs")

# Load libraries
library(pastecs)

#skew.2SE and kurt.2SE
stat.desc(new_treedata$dbh, basic = FALSE, norm = TRUE)

#Shapiro-Wilk test for normality
shapiro.test(new_treedata$dbh)

#Levene's Test for Homogeniety of Variance
#Install car package
install.packages("car")
library(car)

# Levene's test with one independent variable
leveneTest(dbh ~ landuse, data = new_treedata)

# plot histogram of log transformed data
hist(log(treedata$dbh+1), breaks=50)


