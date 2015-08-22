# Data description

tidydata.txt file is the tidy data summarised from the data in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
It consists of the average values of 579 variables grouped by activities and subjects. With 6 activities and 30 subjects, there are
180 records in the tidydata.txt

Variables in the tidydata.txt are (in the order)
1. Activity_Id: activity id which is described in the activity_labels.txt file
2. Activity_label: the names of activities, i.e., walking, walking upstair, walking downstair, sitting, standing and laying
3. Subject_Id: the identifier number of 30 volunteers
4. TotalAcc_mean_X: the mean of total acceleration in the X direction
5. TotalAcc_std_X: the standard deviation of total acceleration in the X direction
6. TotalAcc_mean_Y: the mean of total acceleration in the Y direction
7. TotalAcc_std_Y: the standard deviation of total acceleration in the Y direction
8. TotalAcc_mean_Z: the mean of total acceleration in the Z direction
9. TotalAcc_std_Z: the standard deviation of total acceleration in the Z direction
10. BodyAcc_mean_X: the mean of body acceleration in the X direction
11. BodyAcc_std_X: the standard deviation of body acceleration in the X direction
12. BodyAcc_mean_Y: the mean of body acceleration in the Y direction
13. BodyAcc_std_Y: the standard deviation of body acceleration in the Y direction
14. BodyAcc_mean_Z: the mean of body acceleration in the Z direction
15. BodyAcc_std_Z: the standard deviation of body acceleration in the Z direction
16. BodyGyro_mean_X: the mean of body angular velocity in the X direction
17. BodyAcc_std_X: the standard deviation of body angular velocity in the X direction
18. BodyAcc_mean_Y: the mean of body angular velocity in the Y direction
19. BodyAcc_std_Y: the standard deviation of body angular velocity in the Y direction
20. BodyAcc_mean_Z: the mean of body angular velocity in the Z direction
21. BodyAcc_std_Z: the standard deviation of body angular velocity in the Z direction
22-582: variable names and their descriptions are in the features.txt and features_infor.txt

Note that some variable names are coincident??? (check in the features.txt file)

end!
