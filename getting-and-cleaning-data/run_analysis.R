run_analysis <- function(write = TRUE,
                        outfile = "run_analysis.txt",
                        directory = "UCI HAR Dataset"){
  old.directory <- getwd()
  setwd(directory)
  
  # 1. Merges training and test sets to create one data set
  
  # get training data
  train.y <- read.table("train/y_train.txt")
  train.id <- read.table("train/subject_train.txt")
  train.x <- read.table("train/X_train.txt")
  
  # get test data
  test.y <- read.table("test/y_test.txt")
  test.id <- read.table("test/subject_test.txt")
  test.x <- read.table("test/X_test.txt")
  
  # merge training and test data
  all.x <- rbind(train.x, test.x)
  all.y <- c(train.y[,1], test.y[,1])
  all.id <- c(train.id[,1], test.id[,1])
  
  # get feature names
  fnames <- read.table("features.txt", stringsAsFactors = FALSE)
  colnames(all.x) <- fnames[,2]
  
  # 2. Extracts only measurements on the mean and standard deviation 
  # for each measurement
  mean.col.indices <- grep('mean()', colnames(all.x), fixed = TRUE)
  std.col.indices <- grep('std()', colnames(all.x), fixed = TRUE)
  all.x <- all.x[,c(mean.col.indices, std.col.indices)]
  
  # 3. Uses descriptive activity names to name the activities
  activity.names <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
  all.y.named <- sapply(all.y, function(y) activity.names[y, 2])
  
  # 4. Appropriately labels the data set with descriptive variable names
  all.data <- cbind(all.id, all.y.named, all.x)
  colnames(all.data)[1:2] <- c("Subject", "Activity")
  
  # 5. From 4, creates a second independent tidy data set with the average 
  # of each variable for each activity and each subject
  grouped.data <- aggregate(all.data[,3:ncol(all.data)], 
                            by = list(Subject = all.data$Subject,
                                      Activity = all.data$Activity), 
                            mean)
  
  setwd(old.directory)
  
  if(write) write.table(grouped.data, file = outfile, row.names = FALSE)
  return(grouped.data)
}





