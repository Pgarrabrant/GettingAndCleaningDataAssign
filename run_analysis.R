##  Reading in the files with the data.
## Walk6 will have the labels like; standing, walking, laying, etc
Walk6 <- read.table ("activity_labels.txt")

## Check to see it worked
str(Walk6)

## These will need to be characters
Walk6[,2] <- as.character(Walk6[,2])


## Verify it changed
str(Walk6)

## Read in the 561 Column Headers
ColHeaders <- read.table("features.txt")

## These will also need to be characters
ColHeaders[,2] <- as.character(ColHeaders[,2])

## Verify it changed
str(ColHeaders)

## Reading in the Test Files
Test30Subj <- read.table("./test/subject_test.txt")
TestXdata <- read.table("./test/x_test.txt")
TestY.1to6Activity <- read.table("./test/y_test.txt")

## Verify they loaded
dim(Test30Subj)
dim(TestXdata)
dim(TestY.1to6Activity)

## Reading in the Train Files
Train30Subj <- read.table("./train/subject_train.txt")
TrainXdata <- read.table("./train/x_train.txt")
TrainY.1to6Activity <- read.table("./train/y_train.txt")

## Column bind the Test files
TestSet <- cbind (Test30Subj, TestY.1to6Activity, TestXdata)

## Verify the columns are added
dim(TestSet)

## Column bind the Train files
TrainSet <- cbind (Train30Subj, TrainY.1to6Activity, TrainXdata)
## Verify the columns are added
dim(TrainSet)

## Make the big set to complete STEP 1 of assignment "Merges the training and the test sets to create one data set."
AllData <- rbind (TestSet, TrainSet)
dim(AllData)

## This is STEP 3 (yes three) of the assignment "Uses descriptive activity names to name the activities in the data set."
colnames(AllData) <- c( "Person", "Activity", ColHeaders[,2])

## The below steps create "MeanSTDdata2" which is STEP 2 "Extracts only the measurements on the mean and standard deviation of each measurement."

MeanSTD <- grep(".*Mean.*|.*STD.*", names(AllData), ignore.case = TRUE)

MeanSTDdata <- AllData [, MeanSTD]

dim(MeanSTDdata)
J<- AllData[,1:2]
dim(J)
MeanSTDdata2 <- cbind(J, MeanSTDdata)

## This is also Step 3 again finishing the activity names
MeanSTDdata2[,2] <- Walk6[MeanSTDdata2[,2],2]

##  STEP 4 "Appropriately labels the data set with descriptive variable names."
names(MeanSTDdata2)
names(MeanSTDdata2) <- gsub("^t", "Time", names(MeanSTDdata2))
names(MeanSTDdata2) <- gsub("^f", "Frequency", names(MeanSTDdata2))


## Step 5 is writing the table of Tidy data with the means for activity and each subject
write.table(MeanSTDdata2, "MPG22.txt", row.names = FALSE)
 Tidy<- aggregate(. ~Person+Activity, MeanSTDdata2, mean)
 write.table(Tidy, "PGtidy.txt", row.names = FALSE)