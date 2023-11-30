/* Read Cohort Dataset */
data cohort;
    set '/home/u63652364/sasuser.v94/analysis_ds/cohort.sas7bdat';
run;

/* Read Vital Sign Dataset */
data vital_sign;
    set '/home/u63652364/sasuser.v94/libresult/vital_sign.sas7bdat';
run;

/* Merge Cohort and Vital Sign datasets */
data merged_data;
    merge vital_sign (in=a) cohort (in=b);
    by patient_id;
    if a and b;
run;

/* Filter rows based on conditions */
data vs1;
    set merged_data;
    where .z < index_date - 30 < vital_date
          and loinc in ('8462-4', '8480-6', '8867-4')
          and not missing(value);
    keep patient_id loinc vital_date value death_date cohort cohortN cohort1n index_date;
run;

/* Sort the vs1 dataset by the BY variables */
proc sort data=vs1;
    by patient_id loinc vital_date;
run;

/* Select records for vs2_base */
data vs2_base;
    set vs1;
    where .z < index_date - 30 < vital_date < index_date + 30;
    keep patient_id loinc cohort1n value vital_date death_date index_date;
run;

/* Select latest record for vs2_basel */
data vs2_basel;
    set vs2_base;
    by patient_id loinc vital_date;
    if last.loinc;
    rename value=base;
run;

/* Select records for vs2_Post */
data vs2_Post;
    set vs1;
    where .z < index_date < vital_date;
    keep patient_id loinc cohort1n value vital_date;
run;

/* Sort the vs2_Post dataset by the BY variables */
proc sort data=vs2_Post;
    by patient_id loinc vital_date;
run;

/* Select latest record for vs2_Post1 and delete records after death_date */
data vs2_Post1;
    set vs2_Post;
    by patient_id loinc vital_date;
    if death_date ne . and vital_date > death_date > .z then delete;
    if last.loinc;
    rename value=Post_Base;
run;

/* Merge vs2_basel and vs2_Post1 datasets */
data Vital_Sign_Analysis;
    merge vs2_basel (in=a) vs2_Post1 (in=b);
    by patient_id loinc;
    CHG = Post_Base - base;
run;
