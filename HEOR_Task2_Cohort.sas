/* Step 1: Read in datasets */

data medication;
  set '/home/u63652364/sasuser.v94/libresult/medication.sas7bdat';
run;

data patient;
  set '/home/u63652364/sasuser.v94/libresult/patient.sas7bdat';
run;

data condition;
 set '/home/u63652364/sasuser.v94/libresult/condition.sas7bdat';
run;

data procedure;
 set '/home/u63652364/sasuser.v94/libresult/procedure.sas7bdat';
run;

/* Step 2: Create dataset condi1 with specific conditions */
data condi1;
  set condition;
  where substr(code, 1, 3) in ("I48") and '01Jan2007'd <= condition_date <= '01Jan2019'd;
run;

/* Step 3: Create dataset med1 with specific medications */
data med1;
  set medication;
  length cohort $20;
  
  if ndc in (3089421, 636297747) or index(upcase(medication_name), "APIXABAN") then do;
    cohort = "NOAC"; CohortN = 1; medication_name = "APIXABAN";
  end;
  else if ndc in (5970108) or index(upcase(medication_name), "DABIGATRAN") then do;
    cohort = "NOAC"; CohortN = 1; medication_name = "DABIGATRAN";
  end;
  else if ndc in (50458577) or index(upcase(medication_name), "RIVAROXABAN") then do;
    cohort = "NOAC"; CohortN = 1; medication_name = "RIVAROXABAN";
  end;
  else if ndc in (31722327) or index(upcase(medication_name), "WARFARIN") then do;
    cohort = "Warfarin"; CohortN = 2; medication_name = "Warfarin";
  end;
  else if ndc in (2802100) or index(upcase(medication_name), "ASPIRIN") then do;
    cohort = "Aspirin"; CohortN = 3; medication_name = "Aspirin";
  end;
run;

/* Step 4: Create dataset med2 with records within a specific timeframe */
data med2;
  set med1;
  if cohort ne '' and '01Jan2017'd <= request_date <= '01Jan2021'd;
run;

/* Step 5: Create dataset Cohort_1 with inclusion and exclusion criteria */
proc sql;
create table Cohort_1 as
select distinct a.patient_id, propcase(a.gender) as gender, a.death_date, a.death_flag, propcase(a.race) as race,
       b.cohort, b.cohort, case (b.cohortn) when 1 then 1 else 2 end as cohort1n, b.request_date as Index_Date,
       a.birth_date, (b.request_date - a.birth_date + 1) / 365 as age
from patient as a
inner join Med2 as b on a.patient_id = b.patient_id
where calculated age >= 18
  and a.patient_id in (select distinct patient_id from condi1)
  and a.patient_id in (select distinct patient_id from med2)
  and a.patient_id not in (select distinct patient_id from Condition where substr(code, 1, 3) in ("M81", "197"))
  and a.patient_id not in (select distinct patient_id from procedure where code in ("B215YER", "B215122", "B215132"))
order by a.patient_id;
quit;

/* Step 6: Create dataset Cohort_2 with additional variables */
proc sql;
create table Cohort_2 as
select a.*, c.chf, d.hyp, e.diab, f.STROK, g.vsc, r.AbRenal, l.AbLiver, k.Bleed, al.alcoh, med1.nsaid,
       med2.antiplat, med3.PPI, med4.h2anta, med5.AntiArr, med6.digi, med7.Statin
from Cohort_1 a
left join (select distinct patient_id, 1 as CHF from condition where substr(code, 1, 3) in ("I50")) c on a.patient_id = c.patient_id
left join (select distinct patient_id, 1 as HYP from condition where substr(code, 1, 3) in ("I10", "I11", "I12", "I13", "I14", "I15")) d on a.patient_id = d.patient_id
left join (select distinct patient_id, 1 as DIAB from condition where substr(code, 1, 3) in ("E10", "E11", "E12", "E13", "E14")) e on a.patient_id = e.patient_id
left join (select distinct patient_id, 1 as STROK from condition where substr(code, 1, 3) in ("I63", "I693", "G459", "I69", "G45")) f on a.patient_id = f.patient_id
left join (select distinct patient_id, 1 as VSC from condition where substr(code, 1, 3) in ("I21", "I252", "I70", "I71", "I72", "I73")) g on a.patient_id = g.patient_id
left join (select distinct patient_id, 1 as AbRenal from condition where substr(code, 1, 3) in ("N183", "N184")) r on a.patient_id = r.patient_id
left join (select distinct patient_id, 1 as Abliver from condition where substr(code, 1, 3) in ("B15", "B16", "B17", "B18", "B19", "C22", "D684", "I982", "I983", "K70", "K77", "Z944")) l on a.patient_id = l.patient_id
left join (select distinct patient_id, 1 as Bleed from condition where code in ("I850", "I983", "K2211", "K226", "K228", "K250", "K252", "K254", "K256", "K260", "K262", "K264", "K266", "K270", "K272", "K274", "K276", "K280", "K282", "K284", "K286", "K290", "K3181", "K5521", "K625", "K920", "K921", "K922", "D62", "H448", "H3572", "H356", "H313", "H210", "H113", "H052", "H470", "H431", "I312", "N020", "N021", "N022", "N023", "N024", "NO25", "N026", "N027", "N028", "N029", "N421", "N831", "N857", "N920", "N923", "N930", "N938", "N939", "M250", "R233", "R040", "R041", "R042", "R048", "R049", "T792", "T810", "N950", "R310", "R311", "R318", "R58", "T455", "Y442", "D683", "I60", "I61", "I62", "I690", "I691", "I692", "S064", "S065", "S066", "S068")) k on a.patient_id = k.patient_id
left join (select distinct patient_id, 1 as Alcoh from condition where substr(code, 1, 3) in ("E244", "F10", "G312", "G621", "G721", "I426", "K292", "K70", "K860", "X65", "Y15", "Y90-Y91", "Z502", "Z714", "Z721")) al on a.patient_id = al.patient_id
left join (select distinct patient_id, 1 as nsaid from Medication where prxmatch("/Bromfenac Celecoxib Diclofenac | Etodolac | Fenoprofen Flurbiprofen | Ibuprofen Indomethacin Keto profen Ketorolac Naproxen Meclofenamate Mefenamic acid Meloxicam|Nabumetone Oxaprozin Firoxicam Sulindac|Tolmetin/", medication_name)) med1 on a.patient_id = med1.patient_id
left join (select distinct patient_id, 1 as Antiplat from Medication where prxmatch("/Aspirin Clopidogrel Prasugrel Ticlopidine Cilostazol Abciximab Tirofiban|Dipyridamole Ticagrelor/", medication_name)) med2 on a.patient_id = med2.patient_id
left join (select distinct patient_id, 1 as PPI from Medication where prxmatch("/Omeprazole Pantoprazole Lansoprazole Rabeprazole | Esomeprazole Dexlansoprazolei/", medication_name)) med3 on a.patient_id = med3.patient_id
left join (select distinct patient_id, 1 as H2Anta from Medication where prxmatch("/Cimetidine Ranitidine Famotidine Nizatidine Roxatidine Lafutidine/", medication_name)) med4 on a.patient_id = med4.patient_id
left join (select distinct patient_id, 1 as AntiArr from Medication where prxmatch("/Quinidine | Procainamide Mexiletine Propafenone | Flecainide Amiodarone Bretylium | Dronedarone/", medication_name)) med5 on a.patient_id = med5.patient_id
left join (select distinct patient_id, 1 as Digi from Medication where prxmatch("/Digoxin/", medication_name)) med6 on a.patient_id = med6.patient_id
left join (select distinct patient_id, 1 as Statin from Medication where prxmatch("/Atorvastatin Fluvastatin Lovastatin Pitavastatin Pravastatin|Roxuvastatin Simvastatin/", medication_name)) med7 on a.patient_id = med7.patient_id
order by patient_id;
quit;

/* Step 7: Create dataset Cohort_3 with additional variables */
data Cohort_3;
  set Cohort_2;
  Gender = propcase(gender);

  /* Table 9. CHA2DS2-VASc Score */
  if upcase(gender) = "FEMALE" then female = 1;

  if 75 > age >= 65 then do;
    Age1 = 1;
    Age2 = 1;
    AgeCat = "65=< to 75";
  end;
  else if age >= 75 then do;
    Age1 = 2;
    AgeCat = "75<";
  end;
  else if .z < age < 65 then do;
    Age1 = 0;
    AgeCat = "<65";
  end;

  /* Stroke Value for CHA2-DS2 Ls 2. So, will create new variable. */
  if strok = 1 then new_strok = 2;

  CHA2DS2 = sum(Age1, female, chf, hyp, diab, new_strok, vsc);

  /* Table 10. HAS-BLED Score: Note: in HAS-BLED Score, STROKE value is 1. So, will use STROK variable; */
  if antiplat = 1 or nsaid = 1 then drugtherapy = 1;
  HASBLED = sum(hyp, AbRenal, Abliver, Bleed, STROK, alcoh, drugtherapy, age2);

  /* Year of Diagnosis */
  Year = year(Index_Date);
run;

/* Step 8: Create final dataset Cohort */
data Cohort;
  set Cohort_3;
  keep patient_id gender death_date death_flag race cohort CohortN cohort1n Index_Date birth_date age STROK Bleed AgeCat CHA2DS2 HASBLED Year;
run;



﻿







