CREATE TABLE Survey_Hospital_Transformed AS
SELECT Provider_ID, Hospital_Name, HCAHPS_Answer_Percent
FROM Survey_Hospital
WHERE HCAHPS_Question LIKE '%Always%';