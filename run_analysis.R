#clear all
rm(list=ls())

#need update to appropriate directory
workingDirectory="D:/R/DataClean/work"
dataDirectory=paste(workingDirectory,"/UCI HAR Dataset",sep="")
resultFile="tidydata.txt"


setwd(workingDirectory)

#===============================================
# Read common data
#===============================================
#set current directory to the data root
setwd(dataDirectory)

# load 561 feature names
features<-read.table("features.txt")
# load 6 activity lables
activity_labels<-read.table("activity_labels.txt")

setwd(workingDirectory)


#=======================================
#Function to load data in a data directory
#using for both train and test data
#=======================================
fload<-function(directory, typeofdata){
  oldDirectory=getwd()
  if (oldDirectory!=directory)
    oldDirectory=setwd(directory)
  
  # load 6 activity lables
  activity_labels<-read.table("activity_labels.txt")

  #=========================
  #load training data
  #=========================
  #load 7352 subject_train
  subject<-read.table(paste(typeofdata,"/subject_",typeofdata,".txt", sep=""))
  #load 7352 x_train
  x<-read.table(paste(typeofdata,"/x_",typeofdata,".txt", sep=""))
  #load 7352 y_train
  y<-read.table(paste(typeofdata,"/y_",typeofdata,".txt", sep=""))
  
  # Create subject+activity
  act_sub<-cbind(left_join(y, activity_labels, by="V1"), subject)
  names(act_sub)<-c("Activity_Id", "Activity_label","Subject_Id")
  #===================================
  #load inertial signals
  #===================================
  total_acc_x<-read.table(paste(typeofdata,"/Inertial Signals/total_acc_x_",typeofdata,".txt", sep=""))
  TotalAcc_x<-data.frame(cbind(Mean=apply(total_acc_x,1, mean, na.rm = TRUE), SD=apply(total_acc_x,1, sd, na.rm = TRUE)))
  
  total_acc_y<-read.table(paste(typeofdata,"/Inertial Signals/total_acc_y_",typeofdata, ".txt", sep=""))
  TotalAcc_y<-data.frame(cbind(Mean=apply(total_acc_y,1, mean, na.rm = TRUE), SD=apply(total_acc_y,1, sd, na.rm = TRUE)))
  
  total_acc_z<-read.table(paste(typeofdata,"/Inertial Signals/total_acc_z_", typeofdata,".txt", sep=""))
  TotalAcc_z<-data.frame(cbind(Mean=apply(total_acc_z,1, mean, na.rm = TRUE), SD=apply(total_acc_z,1, sd, na.rm = TRUE)))
  
  body_acc_x<-read.table(paste(typeofdata,"/Inertial Signals/body_acc_x_", typeofdata, ".txt", sep=""))
  BodyAcc_x<-data.frame(cbind(Mean=apply(body_acc_x,1, mean, na.rm = TRUE), SD=apply(body_acc_x,1, sd, na.rm = TRUE)))
  
  body_acc_y<-read.table(paste(typeofdata,"/Inertial Signals/body_acc_y_",typeofdata,".txt", sep=""))
  BodyAcc_y<-data.frame(cbind(Mean=apply(body_acc_y,1, mean, na.rm = TRUE), SD=apply(body_acc_y,1, sd, na.rm = TRUE)))
  
  body_acc_z<-read.table(paste(typeofdata,"/Inertial Signals/body_acc_z_",typeofdata,".txt", sep=""))
  BodyAcc_z<-data.frame(cbind(Mean=apply(body_acc_z,1, mean, na.rm = TRUE), SD=apply(body_acc_z,1, sd, na.rm = TRUE)))
  
  body_gyro_x<-read.table(paste(typeofdata, "/Inertial Signals/body_gyro_x_",typeofdata,".txt", sep=""))
  BodyGyro_x<-data.frame(cbind(Mean=apply(body_gyro_x,1, mean, na.rm = TRUE), SD=apply(body_gyro_x,1, sd, na.rm = TRUE)))
  
  body_gyro_y<-read.table(paste(typeofdata,"/Inertial Signals/body_gyro_y_",typeofdata,".txt", sep=""))
  BodyGyro_y<-data.frame(cbind(Mean=apply(body_gyro_y,1, mean, na.rm = TRUE), SD=apply(body_gyro_y,1, sd, na.rm = TRUE)))
  
  body_gyro_z<-read.table(paste(typeofdata, "/Inertial Signals/body_gyro_z_",typeofdata,".txt", sep=""))
  BodyGyro_z<-data.frame(cbind(Mean=apply(body_gyro_z,1, mean, na.rm = TRUE), SD=apply(body_gyro_z,1, sd, na.rm = TRUE)))
  
  inertial_signals<-cbind(TotalAcc_x,TotalAcc_y, TotalAcc_z, BodyAcc_x, BodyAcc_y, BodyAcc_z, BodyGyro_x, BodyGyro_y, BodyGyro_z)
  names(inertial_signals)<-names(inertial_signals)<-c("TotalAcc_mean_X", "TotalAcc_std_X", "TotalAcc_mean_Y", "TotalAcc_std_Y", "TotalAcc_mean_Z", "TotalAcc_std_Z",
                                                      "BodyAcc_mean_X", "BodyAcc_std_X", "BodyAcc_mean_Y", "BodyAcc_std_Y", "BodyAcc_mean_Z", "BodyAcc_std_Z",
                                                      "BodyGyro_mean_X", "BodyGyro_std_X", "BodyGyro_mean_Y", "BodyGyro_std_Y", "BodyGyro_mean_Z", "BodyGyro_std_Z")
  
  
  # Combile all train data
  train<-cbind(act_sub, inertial_signals, x)
  
  if (getwd()!=oldDirectory)
  setwd(oldDirectory)
  
  train  
}


#================================================
# load data using the fload function
#================================================
train<-fload(dataDirectory,"train")
test<-fload(dataDirectory,"test")

#combile train and test data
alldata<-rbind(train, test) 

# group by subject and activity
library(dplyr)
g_data<-alldata %>% group_by(Activity_Id, Activity_label, Subject_Id) %>% summarise_each(funs(mean))
#g_data<-arrange(g_data, Activity_Id, Subject_Id)
#label variable names - note that some variable names are coincident. e.g, 303 and 317 in the features.txt
names(g_data)[22:582]<-as.character(features$V2)

# write to file
if (getwd()!=workingDirectory) setwd(workingDirectory)
write.table(g_data,file=resultFile, row.names = FALSE)

#note
#read.table by the following command
#dat<-read.table(resultFile, header=TRUE)

