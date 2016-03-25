#Data Dictionary
##Getting and Cleaning Data course project 
###Human Activity Recognition Using Smartphones Dataset


###The original dataset contained the following data points:
  1.Triaxial acceleration from the accelerometer (total acceleration) 
     and the estimated body acceleration.
  2.Triaxial Angular velocity from the gyroscope.
  3.A 561-feature vector with time and frequency domain variables.
  4.Its activity label.
  5.An identifier of the subject who carried out the experiment. 

###The transformed dataset includes average values 
###for the mean and standard deviation variables:
  1.Triaxial acceleration from the accelerometer (total acceleration) 
     and the estimated body acceleration.
  2.Triaxial Angular velocity from the gyroscope.
  3.86 variables with descriptive time and frequency domain variables.
  4.An identifier of the subject who carried out the experiment.  
  
Notes: 
======
The sensor acceleration signal has gravitational and body motion components.
Variables from the time and frequency domain compose the features variables.
The Features have been transformed into averages of the original dataset.
Features are bounded within [-1,1].
Numbers are stored as type dbl().
The table contains a distinct set of subjects and activities by row.
Features are displayed by columns.


###Naming conventions for activities and features
The activity descriptions have been changed from uppercase to lowercase
All underscore symbols have been removed
The revised naming of the feature variables use the following order.
      1. summary function of mean vs standard deviation.
      2. domain of time vs frequency, including angular measurements.
      3. body vs gravity. 
      4. axis of the phone when listed.
      5. sensor used for the reading (accelerometer vs gyroscope).
      6. magnitude when listed. 

##The Variables
        **subjectid** - values of 1 through 30 for each volunteer 


        **activity** - six activities were measured on a smartphone (Samsung Galaxy S II)
            *laying
            *sitting
            *standing
            *walking 
            *walking downstairs
            *walking upstairs


      * **body measurements - using accelerometer**
        *columns 3 through 5 mean of time domain including the X, Y, Z axis
        *columns 6 through 8 standard deviation of time domain
         mapped from the original functions labeled as tBodyAcc...X/Y/Z


      * **gravity measurements - using accelerometer**
        *columns 9 through 11 mean of gravity measurements including the X, Y, Z axis
        *columns 12 through 14 standard deviation of gravity measurements
         mapped from the original functions labeled as tGravityAcc...X/Y/Z  


      * **body jerk measurements - using accelerometer**
        *columns 15 through 17 mean of time domain including the X, Y, Z axis
        *columns 18 through 20 standard deviation of time domain
         mapped from the original functions labeled as tBodyAccJerk...X/Y/Z   


      * **body measurements - using gyroscope**
        *columns 21 through 23 mean of time domain including the X, Y, Z axis
        *columns 24 through 26 standard deviation of time domain
         mapped from the original functions labeled as tBodyGyro...X/Y/Z 
   
   
      * **body jerk measurements - using gyroscope**
        *columns 27 through 29 mean of time domain including the X, Y, Z axis
        *columns 30 through 32 standard deviation of time domain
         mapped from the original functions labeled as tBodyGyroJerk...X/Y/Z     
 
 
      * **magnitude meaurements - using accelerometer**
        *columns 33-34 body time domain
        *columns 35-36 gravity time domain
        *columns 37-38 body jerk time domain
        mapped from the original functions labeled as t..Acc..Mag
        
        
      * **magnitude meaurements - using gyroscope**
        *columns 39-40 body time domain
        *columns 41-42 body jerk time domain
        mapped from the original functions labeled as t..Gyro..Mag


      * **body measurements - using accelerometer**
        *columns 43 through 45 mean of frequency domain including the X, Y, Z axis
        *columns 46 through 48 standard deviation of frequency domain
        *columns 49 through 51 weighted mean of frequency domain
         mapped from the original functions labeled as fBodyAcc...X/Y/Z  
         
           
      * **body jerk measurements - using accelerometer**
        *columns 52 through 54 mean of frequency domain including the X, Y, Z axis
        *columns 55 through 57 standard deviation of frequency domain
        *columns 58 through 60 weighted mean of frequency domain
         mapped from the original functions labeled as fBodyAccJerk...X/Y/Z
         
         
      * **body measurements - using gyroscope**
        *columns 61 through 63 mean of frequency domain including the X, Y, Z axis
        *columns 64 through 66 standard deviation of frequency domain
        *columns 67 through 69 weighted mean of frequency domain
         mapped from the original functions labeled as fBodyGyro...X/Y/Z  
         
      
      * **magnitude measurements - using accelerometer**
        *columns 70 through 72 - body frequency domain 
        *columns 73 through 75 - body jerk frequency domain
         mapped from the original functions labeled as fBodyAccMag and fBodyAccJerkMag
         
         
      * **magnitude measurements - using gyroscope**
        *columns 76 through 78 - body frequency domain 
        *columns 79 through 81 - body jerk frequency domain
         mapped from the original functions labeled as fBodyGyroMag and fBodyGyroJerkMag
         
               
      * **angle body/gravity measurements**
        *columns 82 through 83 - time domain using accelerometer
        *columns 84 through 85 - time domain using gyroscope
         mapped from the original functions labeled as angle(tBodyAcc.. and angle(tBodyGyro..
         
      * **angle gravity measurements on X/Y/Z/axis**
        *columns 86 through 88 
         mapped from the original functions labeled as angle(.x/y/z.gravityMean)
         
         
====
*This CodeBook document has been compiled by K.Franics*         
      
         
 
