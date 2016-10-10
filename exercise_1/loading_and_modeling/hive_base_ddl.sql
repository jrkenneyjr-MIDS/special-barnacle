drop table comp_hospital;
drop table comp_nation;
drop table comp_nratecounts;
drop table comp_nrateranks;
drop table comp_rankings;
drop table comp_scoring;
drop table comp_sd;
drop table comp_state;
drop table hospital_comp1;
drop table hospital_comp2;
drop table hospital_readm1;
drop table hospital_final;
drop table hospital_readm2 
drop table hospital_tec1;
drop table hospital_tec2;
drop table readm_clean;
drop table readm_hospital;
drop table readm_nation;
drop table readm_nratecounts;
drop table readm_nrateranks;
drop table readm_rankings;
drop table readm_scoring;
drop table readm_sd;
drop table readm_state;
drop table state_summary;
drop table survey_results;
drop table tec_hospital;
drop table tec_nation;
drop table tec_nratecounts;
drop table tec_nrateranks;
drop table tec_rankings;
drop table tec_scoring;
drop table tec_sd;
drop table tec_with_comparison;
drop table tec_with_national;
drop table tec_state;

CREATE EXTERNAL TABLE survey_results(
provider_id int,
hospital_name varchar(50),
address varchar(50),
city varchar(50),
stateID varchar(2),
zip int,
county varchar(50),
com_nurse_a varchar(20),
com_nurse_i varchar(20),
com_nurse_d varchar(20),
com_doc_a varchar(20),
com_doc_i varchar(20),
com_doc_d varchar(20),
response_a varchar(20),
response_i varchar(20),
response_d varchar(20),
pain_a varchar(20),
pain_i varchar(20),
pain_d varchar(20),
com_med_a varchar(20),
com_med_i varchar(20),
com_med_d varchar(20),
clean_quiet_a varchar(20),
clean_quiet_i varchar(20),
clean_quiet_d varchar(20),
discharge_a varchar(20),
discharge_i varchar(20),
discharge_d varchar(20),
overall_a varchar(20),
overall_i varchar(20),
overall_d varchar(20),
base_score int,
consistency int)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_results';

CREATE EXTERNAL TABLE tec_hospital (
provider_id int,
hospital_name varchar(50),
address varchar(50),
city varchar(50),
stateID varchar(2),
zip int,
county varchar(50),
phone int,
condition varchar(50),
meas_id varchar(20),
meas_name varchar(150),
score int,
sample int,
footnote varchar(200),
start_meas date, 
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/tec_hospital';

CREATE EXTERNAL TABLE tec_state (
stateID varchar(2),
condition varchar(50),
meas_name varchar(150),
meas_id varchar(20),
score int,
footnote varchar(200),
start_meas date, 
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/tec_state';

CREATE EXTERNAL TABLE tec_nation (
meas_name varchar(150),
meas_id varchar(20),
condition varchar(100),
category varchar(50),
score int,
footnote varchar(200),
start_meas date, 
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/tec_nation';

CREATE EXTERNAL TABLE readm_hospital (
provider_id string,
hospital_name string,
address string,
city string,
stateID string,
zip string,
county string,
phone string,
meas_name string,
meas_id string,
nrate string,
denom string,
score string,
lcl string,
ucl string,
footnote string,
start_meas string,
end_meas string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readm_hospital';

CREATE EXTERNAL TABLE readm_state (
stateID varchar(2),
meas_name varchar(150),
meas_id varchar(20),
hosp_worse int,
hosp_same int,
hosp_better int,
hosp_few int,
footnote varchar(200),
start_meas date,
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readm_state';

CREATE EXTERNAL TABLE readm_nation (
meas_name varchar(150),
meas_id varchar(20),
rate decimal,
hosp_worse int,
hosp_same int,
hosp_better int,
hosp_few int,
footnote varchar(200),
start_meas date,
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readm_nation';

CREATE EXTERNAL TABLE comp_hospital (
provider_id int,
hospital_name varchar(50),
address varchar(50),
city varchar(50),
stateID varchar(2),
zip int,
county varchar(50),
phone int,
meas_name varchar(150),
meas_id varchar(20),
nrate varchar(50),
denom int,
score decimal,
lcl decimal,
ucl decimal,
footnote varchar(200),
start_meas date,
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/comp_hospital';

CREATE EXTERNAL TABLE comp_state (
stateID varchar(2),
meas_name varchar(150),
meas_id varchar(20),
hosp_worse int,
hosp_same int,
hosp_better int,
hosp_few int,
footnote varchar(200),
start_meas date,
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/comp_state';

CREATE EXTERNAL TABLE comp_nation (
meas_name varchar(150),
meas_id varchar(20),
nrate decimal,
hosp_worse int,
hosp_same int,
hosp_better int,
hosp_few int,
footnote varchar(200),
start_meas date,
end_meas date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"escapeChar" = "\\")
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/comp_nation';
