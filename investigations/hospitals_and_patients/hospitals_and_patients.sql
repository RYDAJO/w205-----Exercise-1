CREATE TABLE Corr_Hospitals AS
SELECT Provider_ID, Hospital_Name, 
AVG (Score) AS Hospital_Score_AVG, 
SUM (Score) AS Hospital_Score_Sum
FROM Scores_Hospital_Transformed 
GROUP BY Provider_ID, Hospital_Name
ORDER BY Hospital_Score_Sum DESC;

CREATE TABLE Survey_Hospital_Average AS
SELECT Provider_ID, Hospital_Name, AVG( HCAHPS_Answer_Percent ) AS HCAHPS_Answer_Percent_AVG
FROM Survey_Hospital_Transformed
GROUP BY Provider_ID, Hospital_Name;

CREATE TABLE Corr_Hospital_Join AS
SELECT h.Provider_ID, h.Hospital_Name,  h.Hospital_Score_AVG, s.HCAHPS_Answer_Percent_AVG
FROM Corr_Hospitals h
Join Survey_Hospital_Average s
ON h.Provider_ID=s.Provider_ID;

CREATE TABLE Correlation_Answer_Hospital_Scores AS
SELECT  (Avg(HCAHPS_Answer_Percent_AVG * Hospital_Score_AVG) - Avg(HCAHPS_Answer_Percent_AVG) * Avg(Hospital_Score_AVG)) / (STDDEV(HCAHPS_Answer_Percent_AVG) * STDDEV(Hospital_Score_AVG)) AS Correlation_Hospital_Score_Survey
FROM Corr_Hospital_Join;

CREATE TABLE Procedure_Variation_Hospitals AS
SELECT Provider_ID, Hospital_Name, 
STDDEV (Score) AS Hospital_Measure_Score_STDDEV
FROM Scores_Hospital_Transformed
GROUP BY Provider_ID, Hospital_Name
ORDER BY Hospital_Measure_Score_STDDEV DESC;

CREATE TABLE Procedure_Variation_Hospital_Join AS
SELECT h.Provider_ID, h.Hospital_Name, h.Hospital_Measure_Score_STDDEV, s.HCAHPS_Answer_Percent_AVG
FROM Procedure_Variation_Hospitals h
Join Survey_Hospital_Average s
ON h.Provider_ID=s.Provider_ID;

CREATE TABLE Correlation_Answer_Variability_Scores AS
SELECT  (Avg(HCAHPS_Answer_Percent_AVG * Hospital_Measure_Score_STDDEV) - Avg(HCAHPS_Answer_Percent_AVG) * Avg(Hospital_Measure_Score_STDDEV)) / (STDDEV(HCAHPS_Answer_Percent_AVG) * STDDEV(Hospital_Measure_Score_STDDEV)) AS Correlation_Procedure_Variation_Survey
FROM Procedure_Variation_Hospital_Join;

SELECT Correlation_Hospital_Score_Survey
FROM Correlation_Answer_Hospital_Scores;

SELECT Correlation_Procedure_Variation_Survey
FROM Correlation_Answer_Variability_Scores;