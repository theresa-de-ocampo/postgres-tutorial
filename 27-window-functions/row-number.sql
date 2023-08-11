/*
 * The ROW_NUMBER() is a windows function that assigns a sequential integer to each row in a result set.
 * The set of rows on which the ROW_NUMBER function operates is called a window.
 * 
 * The PARTITION BY clause divides the window into smaller sets or partitions.
 * If you specify the PARTITION BY clause, the row number for earch partition starts with one,
 * an increments by one.
 * If you omit the PARITION BY, ROW_NUMBER function will treat the whole window as a partition.
 * 
 * The ORDER BY clause inside the OVER clause determines the order in which numbers are assigned.
 * */