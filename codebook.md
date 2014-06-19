# Assessment 1 - Code Book
==========================

## Source Data Info:

Info from the source data book, 

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
> 
> Which can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
> 
> The dataset includes the following files:
> 
> - 'README.txt'
> 
> - 'features_info.txt': Shows information about the variables used on the feature vector.
> 
> - 'features.txt': List of all features.
> 
> - 'activity_labels.txt': Links the class labels with their activity name.
> 
> - 'train/X_train.txt': Training set.
> 
> - 'train/y_train.txt': Training labels.
> 
> - 'test/X_test.txt': Test set.
> 
> - 'test/y_test.txt': Test labels.
> 
> The following files are available for the train and test data. Their descriptions are equivalent. 
> 
> - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
> 
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
> 
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
> 
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


===============================
## The assessment

From the assessment's page on Coursera:

> You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

===============================
##The Transformations:

All work is performed in R by the `run_analysis.R` script.

First, data from the training and test
sets is loaded (groups X, y, and subject), along with feature and activity information.

The column names (i.e., field names) and the activities description (i.e., labels) are applied
to the X group so as to extract, with a regular expression, all columns cointaining "mean" or
"std", as requested, before binding the test and train sets.

The activity labels are added to the Y group. This, along with the subject test and train data,
is merged with X group into a single data set.

For the tidy data set, the desidered column names are given in a vector `id.labels`, the
information is extracted and it is combined with the `melt` function of the `reshape2` R
package; `reshape2` is a package for easily transforming between wide and long formats, and
`melt` is its generic melt function (i.e., for converting an object into a molten data frame).
For more information, see `?melt`.

The tidy data is finally written to a file; I used the comma as a separator because it seemed
easier to understand the data while visually inspecting it, and it actually resulted in a
generic, raw, CSV-file that can be easily imported in any spreedsheet (sometimes this kind
of software has trouble with space separated values, which is the default for `write.table`;
I could have used `write.csv`, but this way it is easier for other people not familiar with
R understand what is going on).

No computation is performed on the values other than taking the avarage of each mean or
standard deviation variable for each activity and each subject, as requested in the assessment.

