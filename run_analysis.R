

library(dplyr)
library(data.table)

# Create path strings for reading in files.
path        <- getwd()
path.tst    <- paste(path, "/test", sep="")
path.trn    <- paste(path, "/train", sep="")

# Read in and create 'activities' table. This is a table of the activity labels.
activities <- read.table(paste(path,"/activity_labels.txt",sep=""))
activities <- data.table(activities)

# Read in the features column names. Get rid of the '()' in each name and then render the rest of each name
# syntactically suitable to be a column name. Lastly, get rid of any dots (.) at the end of a name.
features <- read.table (paste(path,"/features.txt",sep=""), stringsAsFactors=F)
features <- make.names(sub("\\(\\)", "", features[,"V2"]))
features <- sub("\\.*$", "", features)

# Initialize the data sets and put them in a list; this supports looping to fill in the data. Element 1 will be for the test
# data and element 2 will be for the training data.
data.set <- list(tst.data = data.frame(),
                 trn.data = data.frame())

# Put the corresponding path names in a list, one set of path names for each data set.
data.path <- list (list(path.subject = paste(path.tst,"/subject_test.txt",sep=""),
                        path.activity = paste(path.tst,"/y_test.txt",sep=""),
                        path.xdata = paste(path.tst,"/X_test.txt",sep="")),
                   
                   list(path.subject = paste(path.trn,"/subject_train.txt",sep=""),
                        path.activity = paste(path.trn,"/y_train.txt",sep=""),
                        path.xdata = paste(path.trn,"/X_train.txt",sep="")))

for (idx in seq(along=data.set)) {
    
    # Get the path names back
    path.subject    <- data.path[[idx]]$path.subject
    path.activity   <- data.path[[idx]]$path.activity
    path.xdata      <- data.path[[idx]]$path.xdata
    
    # Start to build the data set by reading in the subjects column.
    data.set[[idx]] <- read.table(path.subject, col.names="subj_ID")
    data.set[[idx]] <- data.table(data.set[[idx]])
    
    # Read in the 'parallel' set of activities performed for each record and add the column to the data table.
    tmp <- read.table(path.activity, col.names="act_ID")
    data.set[[idx]][,act_ID := tmp[,"act_ID"]]
    
    # Read the data set with the features column names.
    print( sprintf ("Reading data file %s", path.xdata) )
    x.data <- read.table(path.xdata, col.names=features)
    x.data <- data.table(x.data)
    
    # Extend out (column-wise) the data set with the measurement data.
    data.set[[idx]] <- cbind(data.set[[idx]], x.data)
}

tst.data <- data.set[[1]] # The test data set
trn.data <- data.set[[2]] # The training data set

# To conserve memory, remove large objects we no longer need.
remove(data.set, x.data, tmp)

# The data will be merged 'long' rather than wide. Subjects are found in one data set or another but not both. 
# Therefore the combination of subj_ID and act_ID uniquely defines a measurement set (i.e. row)
full.data <- rbind(tst.data, trn.data)

# Filter the feature column names based on the terms 'mean' and 'std'; ignore case. Also include the subject and activity
# ID columns.
stat.cols   <- c("subj_ID", "act_ID")
tmp         <- grep("mean|std", features, value=T, ignore.case=T) 
stat.cols   <- append(stat.cols, tmp) # stat.cols will have all the column names we want.

# Extract just the means and stds of measurement based on the column names.
stat.data <- full.data[,stat.cols, with=F]

# Subsititue activity labels (as factors) for the ordinal activity number.
stat.data$act_ID <- factor(stat.data$act_ID, levels=activities[,V1], labels=activities[,V2])

# Create a summary table holding the average value of each measurement for each subject-activity record.
mean.data <- stat.data[,lapply(.SD,mean),by="subj_ID,act_ID",.SDcols=3:88]

# Rename the act_ID column.
mean.data <- rename(mean.data, activity = act_ID)

# Clean up environment of unnecessary objects.
remove(tmp, stat.cols, full.data, activities, data.path, features, idx, path, path.activity, path.subject,
       path.trn, path.tst, path.xdata)

# Generate sample output
eval(mean.data[,1:8, with=F])



    