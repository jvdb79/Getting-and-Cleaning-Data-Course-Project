library(reshape2)

#######################################
# part 1: capture user-defined parameters related to analysis 

# specify variables containing mean and sd data
meanSdVars <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228,
                240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 
                529:530, 542:543)

# specify activity variables and descriptive activity names
activities <- c(1, 2, 3, 4, 5, 6)
activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# specify output file name
tidyDataFile <- "tidyData.txt"

#######################################
# part 2: generate variable names based on variables selected in meanSdVars, and
# create functions to generate file names of data to be processed.                               

# use specified variables to automatically generate character vector of variable names
features <- read.table("D://Rdata//getdata6//UCI HAR Dataset//features.txt")
meanSdVarNames <- as.character(features[meanSdVars,2])

# generate a filename for the features file, given a data set name
featuresFilename <- function(name) {
        paste("X_", name, ".txt", sep = "")
}

# generate a filename for the activities file, given a data set name
activitiesFilename <- function(name) {
        paste("Y_", name, ".txt", sep = "")
}

# generate a filename for the subjects file, given a data set name
subjectFilename <- function(name) {
        paste("subject_", name, ".txt", sep = "")
}

#######################################
# Part 3: function to create preparatory 'test' and 'train' data sets with variables of interest 

readData <- function(dir, name) {
        # create file paths
        specDir <- file.path(dir, name)
        featuresPath <- file.path(specDir, featuresFilename(name))
        activitiesPath <- file.path(specDir, activitiesFilename(name))
        subjectPath <- file.path(specDir, subjectFilename(name))
        
        # read the features data into data frame
        featuresDf <- read.table(featuresPath) [meanSdVars]
        names(featuresDf) <- meanSdVarNames
                # add featuresDf to new data frame 
        cleanDf <- featuresDf
        
        # read the activities data and bind it to cleanDf
        activitiesDf <- read.table(activitiesPath)
        names(activitiesDf) <- c("activity")
        activitiesDf$activity <- factor(activitiesDf$activity, levels = activities, labels = activityNames)
        cleanDf <- cbind(cleanDf, activity = activitiesDf$activity)
        
        # read the subjects data and bind it to cleanDf
        subjectsDf <- read.table(subjectPath)
        names(subjectsDf) <- c("subject")
        cleanDf <- cbind(cleanDf, subject = subjectsDf$subject)
        
        # return merged data
        cleanDf
}

#######################################
# part 4: function to combine & analyse data sets generated in readData() and write 
# clean data set to working directory

runAnalysis <- function(dir) {
        print("Running 'Getting and Cleaning Data' course project analysis")
        
        #get the data
        test <- readData(dir, "test")
        train <- readData(dir, "train")
        
        print("Joining the data")
        #join the data
        joinedData <- rbind(test, train)
        
        print("Reshaping the data")
        #reshape the data
        joinedDataLong <- melt(joinedData, id = c("subject", "activity"))
        joinedDataWide <- dcast(joinedDataLong, subject + activity ~ variable, mean)
        
        print("Creating clean data set")
        #create the clean data set
        joinedDataClean <- joinedDataWide
        
        print("Saving the file in the folder specified in object accelDir")
        #save the file
        tidyDataFileName <- file.path(dir, tidyDataFile)
        write.table(joinedDataClean, tidyDataFileName, quote = FALSE, row.name = FALSE)
}

# specify directory containing accelerometer data
accelDir <- "D://Rdata//getdata6//UCI HAR Dataset//"

# run the master function
runAnalysis(accelDir)
