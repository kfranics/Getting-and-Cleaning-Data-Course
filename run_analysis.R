#install.packages("downloader")
library(downloader)
library(data.table)
library(dplyr)


#download and unzip files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "project.zip")
unzip("project.zip")

#read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

#read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")

#read features and labels
features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")


#step 1 - merge the training and test files to create one dataset
xy_test_subject <- cbind(subject_test, y_test, x_test)
xy_train_subject <- cbind(subject_train, y_train, x_train)
xy_dataset <- rbind(xy_test_subject, xy_train_subject)
#naming columns
names <- c('subjectid','activityid', 1:561)
colnames(xy_dataset) <- names

#rename features columns
setnames(features, "V1", "featureid")
setnames(features, "V2", "featuredescr")


#Step 2 - Extract only the measurements on the mean and standard deviation

#find indexes for mean and std rows
mean_index <- grep('[Mm][Ee][Aa][Nn]', features$featuredescr, value = FALSE)
std_index <- grep('[Ss][Tt][Dd]', features$featuredescr, value = FALSE)

#filter the features to mean and std rows 
#stored in ascending order
feature_index <- union(mean_index, std_index)
setorder(as.data.frame(feature_index)) #ascending order

#filter the dataset columns based on the index
xy_mean_sd_data <- subset(xy_dataset[,c(1,2,feature_index+2)]) #'+2' adjusts for subject and activity columns


#Step 3 - Use descriptive activity names
featureset <- features[feature_index,] #work with the mean/std columns

#string formatting function 
strngcalc <- function(featureid=1:86, x) {
  
  tfa <-'' #time/frequency/angle        
  calc <-'' #mean/standard deviation      
  gravity <- '' #gravity                
  axis <-'' #X/Y/Z
  body <-'' #body/jerk signal
  accgyro <- '' #accelerometer/gyroscope
  mag <- '' #magnitude
  
  df <- data.frame(featurerow = numeric(length(featureid)), featuretitle = numeric(length(featureid)))
  
  for(i in 1:length(featureid)) {
    tfa[i] <- ''
    if(length(grep('^t',x[i])) > 0 ) {tfa[i] <- 'time'} else
      if(length(grep('^f',x[i])) > 0 ) {tfa[i] <- 'frequency'} else
        if(length(grep('^a',x[i])) > 0 ) {tfa[i] <- 'angle'}
    
    calc[i] <- ''
    if(length(grep('[m][e][a][n][(]', x[i]))  > 0) {calc[i] <- 'mean of'} else
      if(length(grep('[m][e][a][n][F]', x[i]))  > 0) {calc[i] <- 'weighted mean of'} else      
        if(length(grep('[s][t][d][(]',x[i])) > 0)  {calc[i] <- 'standard deviation of'} else
          calc[i] <- 'mean gravity'
    
    gravity[i] <-''
    if(length(grep('[G][r][a][v][i]',x[i])) > 0) {gravity[i] <- 'gravity'}
    
    axis[i] <- ''
    if(length(grep('[-][X]',x[i])) > 0) {axis[i] <- 'on the X axis of the phone'} else
      if(length(grep('[(][X]',x[i])) > 0) {axis[i] <- 'on the X axis of the phone'} else    
        if(length(grep('[-][Y]',x[i])) > 0) {axis[i] <- 'on the Y axis of the phone'} else 
          if(length(grep('[(][Y]',x[i])) > 0) {axis[i] <- 'on the Y axis of the phone'} else       
            if(length(grep('[-][Z]',x[i])) > 0) {axis[i] <- 'on the Z axis of the phone'} else  
              if(length(grep('[(][Z]',x[i])) > 0) {axis[i] <- 'on the Z axis of the phone'}        
    
    body[i] <- ''
    if(length(grep('[Jj][Ee][Rr][Kk]',x[i])) > 0) {body[i] <- 'body jerk signal'} else
      if(length(grep('[Bb][Oo][Dd][Yy]',x[i])) > 0) {body[i] <- 'body'}     
    
    accgyro[i] <- ''
    if(length(grep('[Aa][Cc][Cc]',x[i])) > 0) {accgyro[i] <- 'using accelerometer'}  else
      if(length(grep('[Gg][Yy][Rr]',x[i])) > 0) {accgyro[i] <- 'using gyroscope'} 
    
    mag[i] <- ''
    if(length(grep('[Mm][Aa][Gg]',x[i])) > 0) {mag[i] <- 'magnitude'}
    
    df$featurerow[i] <- featureid[i]
    df$featuretitle[i] <- paste(calc[i], tfa[i], gravity[i], body[i], axis[i], accgyro[i], mag[i]) 
  }
  df
}

#assign the results of the function to a dataframe
featuretitles <- strngcalc(featureset$featureid, featureset$featuredescr)

#clean up some white spaces created by the function
featuretitles$featuretitle <- gsub('  ',' ', featuretitles$featuretitle)
featuretitles$featuretitle <- gsub('  ',' ', featuretitles$featuretitle)

#Step 4 - Appropriately label the data set with descriptive variable names
names <- c('subjectid','activityid', featuretitles$featuretitle)
colnames(xy_mean_sd_data) <- names
colnames(activity_labels) <- c('activityid','activity')
activity_labels$activity <- gsub('_',' ',tolower(activity_labels$activity))

#add activity description column to the dataset from the lookup filea
xy_mean_sd_data <- inner_join(xy_mean_sd_data, activity_labels, by='activityid')


#Step 5 - create a second, independent tidy data set with the average of each variable
xy_dataframe <- xy_mean_sd_data %>%
select(-activityid) %>%
group_by(subjectid, activity) %>%
summarise_each(funs(mean)) 

write.table(xy_dataframe, "TidyDataAssignment.csv", row.names = FALSE, col.names = TRUE)  


###You may choose to read the file using the commented code below
#TidyDataAssignment <- read.table("TidyDataAssignment.csv",header = TRUE, check.names=FALSE )
#View(TidyDataAssignment)

