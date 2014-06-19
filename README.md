GettingAndCleaningData
======================

Repository for the Programming Assignment of Coursera's "Getting and Cleaning Data" course.

This repository contains a single R script, `run_analysis.R`, that, when run, will output
to a datafile a "tidy data", as described both in the assessment's page on Coursera and in
file `codebook.md`. The default is to look for the accelerometer data in a subdirectory
where the script is run and to write the output file `tidy_data.txt` in the same directory,
but this can be easily modified by the user by changing the appropriate variables
(particularly `data.dir` and `output.file`) in the script source.

To run the script, just load R and type `source("run_analysis.R")`. Warning: the script will
use R to download and install the required `data.table` and `reshape2` packages if they are
not installed.
