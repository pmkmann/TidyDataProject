---
title: "Code Book"
output: html_document
---

The names of measurement variables are patterned after their orginal names in the raw data set. This is because they are clearly very descriptive and meaningful in the context of the analysis of physical motion. It was necessary, however, to alter certian characteristics of these names to make them compatible with the analysis took kit called 'R'. Specifically, parenthesis in variable names were discarded and special characters converted to dots (.). Any dot created at the end of the variable name was discarded. As an example, variable name fBodyGyro-bandsEnergy()-17:32 would become fBodyGyro.bandsEnergy.17.32 .

### Data Tables
The analysis script, run_analyis.R, produces these 4 data tables:

*   trn.data - the training data set.
*   tst.data - the test data set.
*   stat.data - the merged data set filtered for mean and standard deviation variables.
*   mean.data - the summary data set: i.e. averages of the stat.data set.

### Column Labels
The columns in these data sets are described below. Units for the measurement variables were not provided and so are not known.

<u>subj_ID</u>

The nominal ID of the subject as provided in the files subject\_test.txt and subject\_train.txt

<u>act_ID</u>

The nominal ID of each the six activities as provided in the file activity_labels.txt

<u>activity</u>

The textual label corresponding to an activity ID.

<u>Measured variables / Features</u>

[t|f]BodyAcc.[var].[X|Y|Z]

tGravityAcc.[var].[X|Y|Z]

[t|f]BodyAccJerk.[var].[X|Y|Z]

[t|f]BodyGyro.[var].[X|Y|Z]

tBodyGyroJerk.[var].[X|Y|Z]

[t|f]BodyAccMag.[var]

tGravityAccMag.[var]

[t|f]BodyAccJerkMag.[var]

[t|f]BodyGyroMag.[var]

[t|f]BodyGyroJerkMag.[var]

The prefix of the feature name can be 't' (time domain) or 'f' (frequency domain). Measured variables (var) can be one of:

*   mean: mean value
*   std: standard deviation
*   mad: median absolute deviation
*   max: maximum value
*   min: minimum value
*   sma: signal magnitude area
*   energy: sum of squares divided by the number of values
*   iqr: interquartile range
*   entropy: signal entropy.
*   arCoeff: autoregression coefficients
*   correlation: correlation coefficients betwen to signals (suffix will be one of .X.Y .X.Z: .Y.Z)

When the prefix is 'f' (i.e.: frequency domain): the following measured variables (var) are possible:

*   maxInds: index of the frequency component with largest magnitude
*   meanFreq: weighted average of the frequency components to obtain a mean frequency
*   skewness: skewness of the frequency domain signal 
*   kurtosis: kurtosis of the frequency domain signal 
*   bandsEnergy: energy of a frequency interval within the 64 bins of the FFT of each window.

Additional vectors are obtained by averaging the signals in a signal window sample. These are used on the 'angle' variable to obtain the following features:

*   angle.tBodyAccMean.gravity
*   angle.tBodyAccJerkMean..gravityMean
*   angle.tBodyGyroMean.gravityMean
*   angle.tBodyGyroJerkMean.gravityMean
*	angle.X.gravityMean
*	angle.Y.gravityMean
*	angle.Z.gravityMean
