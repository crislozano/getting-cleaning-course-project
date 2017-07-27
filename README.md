# Getting and Cleaning Data - Course Project
Peer-graded Assignment: Getting and Cleaning Data Course Project

This repo contains an R script, run_analysis.R, that does the following:

1. Download the dataset and unzip it if it does not already exist in the working directory
2. Loads the activity and feature info
3. Loads both the training and test datasets, leaving only the ones which contain the mean and standard deveation
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges all datasets
6. Read columns and create vectors for: ID, mean and SD
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
8. Generate a new .txt with tidy data.
