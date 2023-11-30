FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/allergy.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.allergy;
	GETNAMES=YES;
RUN;
/* Set all variables as character */
  *attrib _all_ length=$70.; 
  *run;
PROC print DATA=WORK.allergy; RUN;
/* Export the WORK.allergy dataset to XPT using PROC CPORT */
PROC CPORT DATA=WORK.allergy
    FILE='/home/u63652364/sasuser.v94/ehr_data/allergy.xpt';
RUN;

/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.allergy 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/allergy.sas7bdat' 
              OUT=WORK.compare_result;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_result;
RUN;





FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/condition.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.condition;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.condition; RUN;
PROC CPORT DATA=WORK.condition
    FILE='/home/u63652364/sasuser.v94/ehr_data/condition.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.condition 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/condition.sas7bdat' 
              OUT=WORK.compare_condition;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_condition;
RUN;





FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/encounter.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.encounter;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.encounter; RUN;
PROC CPORT DATA=WORK.encounter
    FILE='/home/u63652364/sasuser.v94/ehr_data/encounter.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.encounter 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/encounter.sas7bdat' 
              OUT=WORK.compare_encounter;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_encounter;
RUN;






FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/lab.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.lab;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.lab; RUN;
PROC CPORT DATA=WORK.lab
    FILE='/home/u63652364/sasuser.v94/ehr_data/lab.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.lab 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/lab.sas7bdat' 
              OUT=WORK.compare_lab;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_lab;
RUN;









FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/location.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.location;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.location; RUN;
PROC CPORT DATA=WORK.location
    FILE='/home/u63652364/sasuser.v94/ehr_data/location.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.location 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/location.sas7bdat' 
              OUT=WORK.compare_location;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_location;
RUN;







FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/medication.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.medication;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.medication; RUN;
PROC CPORT DATA=WORK.medication
    FILE='/home/u63652364/sasuser.v94/ehr_data/medication.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.medication 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/medication.sas7bdat' 
              OUT=WORK.compare_medication;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_medication;
RUN;









FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/patient.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.patient;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.patient; RUN;
PROC CPORT DATA=WORK.patient
    FILE='/home/u63652364/sasuser.v94/ehr_data/patient.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.patient 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/patient.sas7bdat' 
              OUT=WORK.compare_patient;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_patient;
RUN;











FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/practitioner.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.practitioner;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.practitioner; RUN;
PROC CPORT DATA=WORK.practitioner
    FILE='/home/u63652364/sasuser.v94/ehr_data/practitioner.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.practitioner 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/practitioner.sas7bdat' 
              OUT=WORK.compare_practitioner;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_practitioner;
RUN;











FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/procedure.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.procedure;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.procedure; RUN;
PROC CPORT DATA=WORK.procedure
    FILE='/home/u63652364/sasuser.v94/ehr_data/procedure.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.procedure 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/procedure.sas7bdat' 
              OUT=WORK.compare_procedure;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_procedure;
RUN;



FILENAME REFFILE '/home/u63652364/sasuser.v94/ehr_data/vital_sign.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.vital_sign;
	GETNAMES=YES;
RUN;

PROC print DATA=WORK.vital_sign; RUN;
PROC CPORT DATA=WORK.vital_sign
    FILE='/home/u63652364/sasuser.v94/ehr_data/vital_sign.xpt';
RUN;
/* Perform PROC COMPARE for Validation and store results in a dataset */
PROC COMPARE BASE=WORK.vital_sign 
              COMPARE='/home/u63652364/sasuser.v94/ehr_data/vital_sign.sas7bdat' 
              OUT=WORK.compare_vital_sign;
RUN;

/* Check the PROC COMPARE output */
PROC PRINT DATA=WORK.compare_vital_sign;
RUN;
