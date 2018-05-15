Summary
-------

The script assembles a data frame from the data provided at  
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.
It provides an average of all mean and standard deviations as calculated
in the original data. (i.e. a subset of the original variables)

Please refer to
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
for more detail on the original data.

The data from the training and tests data sets have been merged to
recreate the full data set.

Breakdown of run\_analysis.R script
-----------------------------------

Ensure that you have downloaded and extracted the zip file above. Set
your working directory to the extracted folder “UCI HAR Dataset”. Run
the script. A data frame which is the average of every column grouped by
the subject and their activity will be created. Finally a file called
X\_all.txt is created in a folder called summary.

Files
-----

-   ‘run\_analysis.R’: the code to create the summarized data frame
-   ‘features\_info.txt’: Shows information about the variables used on
    the feature vector.
-   ‘features.txt’: List of all features.
-   ‘activity\_labels.txt’: Links the class labels with their activity
    name.
