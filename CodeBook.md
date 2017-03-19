#Code Book

x_train, y_train, subject_train, x_test, y_test and subject_test contain the data from the downloaded files.

features and activity_labels contain the data from the features.txt and activity_labels.txt files.

merge_train merges the training datasets.

merge_test merges the test datasets.

merge_all merges merge_train and merge_test into one dataset.

column_names extracts the column names from the merge_all dataset.

set_mean_and_std extracts the desired measurements from the merge_all dataset.

data_with_activity_names merges set_mean_and_std with activity_labels to appropriately label the dataset.

second_tidy_dataset contains the mean of each variable for each activity and subject.

