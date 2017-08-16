#!/bin/bash
# Rename csv files and load them into  HDFS

# hdfs dfs -mkdir /user/w205/hopsital_compare;

# unzip hospital files

#unzip /home/w205/w205_Exercise_1/loading_and_modeling/data/HCAHPS_-_Hospital.csv.zip

#unzip /home/w205/w205_Exercise_1/loading_and_modeling/data/Timely_and_Effective_Care_-_Hospital.csv.zip

#WE ASSUME YOU HAVE ACCESS TO THE UPZIPPED FILE PER SLACK CHANNEL

# Rename, Remove Header, place in HDFS Simultaneously 
tail -n +2 /home/w205/w205_Exercise_1/loading_and_modeling/data/HCAHPS_-_Hospital.csv > /home/w205/w205_Exercise_1/loading_and_modeling/data/Survey_Hospital.csv;
hdfs dfs -put /home/w205/w205_Exercise_1/loading_and_modeling/data/Survey_Hospital.csv /user/w205/hospital_compare;

tail -n +2 /home/w205/w205_Exercise_1/loading_and_modeling/data/HCAHPS_-_State.csv > /home/w205/w205_Exercise_1/loading_and_modeling/data/Survey_State.csv;
hdfs dfs -put /home/w205/w205_Exercise_1/loading_and_modeling/data/Survey_State.csv /user/w205/hospital_compare;

tail -n +2 /home/w205/w205_Exercise_1/loading_and_modeling/data/Timely_and_Effective_Care_-_Hospital.csv > /home/w205/w205_Exercise_1/loading_and_modeling/data/Scores_Hospital.csv;
hdfs dfs -put /home/w205/w205_Exercise_1/loading_and_modeling/data/Scores_Hospital.csv /user/w205/hospital_compare;

tail -n +2 /home/w205/w205_Exercise_1/loading_and_modeling/data/Timely_and_Effective_Care_-_State.csv > /home/w205/w205_Exercise_1/loading_and_modeling/data/Scores_State.csv;
hdfs dfs -put /home/w205/w205_Exercise_1/loading_and_modeling/data/Scores_State.csv /user/w205/hospital_compare;