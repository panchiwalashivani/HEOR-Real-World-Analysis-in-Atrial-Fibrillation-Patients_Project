/* Read cohort dataset */
data cohort;
    set '/home/u63652364/sasuser.v94/analysis_ds/cohort.sas7bdat';
run;

/* Read encounter dataset */
data encounter;
    set '/home/u63652364/sasuser.v94/libresult/encounter.sas7bdat';
    length patient_id $30. encounter_type $20.;
    keep patient_id encounter_type; /* Keep only the desired column */
run;

/* Create HRU dataset */
data HRU;
    merge cohort(in=a) encounter(in=b);
    by patient_id;


    /* Select records from eligible cohort dataset */
    if a;

	length cohort $20. CohortN 8. cohort1n 8.;
    keep patient_id encounter_type cohort CohortN cohort1n;
run;


/* Display HRU dataset information */
proc print data=HRU;
run;
