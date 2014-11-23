library(dplyr)


activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names=c("activity.id", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, col.names=c("feature.id", "feature"))

# Load all test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject.id"), header=FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names=c("activity.id"),  header = FALSE)

# We need to map the list of measurements to the columns 
names(x_test) <- features$feature

# make sure we don't have duplicates
colnames(x_test) <- make.names(names(x_test), unique=TRUE)
x_test <- select(x_test, matches(".*std.*|.*mean.*"))

# Merge all the data into one test data set 
test_ds <- cbind(subject_test, x_test)
test_ds <- cbind(y_test, test_ds)
test_ds <- cbind(test_ds, observation.type="test")

# load all training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject.id"), header=FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity.id"), header = FALSE)
names(x_train)<-features$feature
colnames(x_train) <- make.names(names(x_train), unique=TRUE)
x_train <- select(x_train, matches(".*std.*|.*mean.*"))

# Merge all the data into one training data set 
train_ds <- cbind(subject_train, x_train)
train_ds <- cbind(y_train, train_ds)
train_ds <- cbind(train_ds, observation.type="train")

# Combine data sets and cleanup 
full_ds <- rbind(train_ds, test_ds)
full_ds <- merge(activity_labels, full_ds)

full_ds <- select(full_ds, -activity.id)

ds_grpd <- group_by(full_ds, subject.id, activity)
summary_ds <- summarise_each(ds_grpd, funs(mean), 2:88)

write.table(summary_ds, file="summary_ds.txt", row.names=FALSE)