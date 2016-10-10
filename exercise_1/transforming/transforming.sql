-- READMISSIONS;

-- This table gives the rank of each hospital for each readmission score;
-- It considers cases that are reported with a score only.;
-- UCL used because it is what dictates if a score is better than the national average,;
-- that is, if the UCL is lower than the national average, the hospital is better.;
create table readm_rankings as
select provider_id, meas_id, cast(ucl as decimal(10,2)) as ucl,
Rank() over (
partition by meas_id
order by ucl asc) as rankings
from readm_hospital
where cast(ucl as decimal(10,2)) is not null
order by  meas_id asc, provider_id asc;

-- This table reports the average, variability, and aggregate of all readmissions scores for each hospital;
create table readm_scoring as select provider_id, 
cast(avg(rankings) as decimal(10,2)) as averages,
cast(stddev(rankings) as decimal(10,2)) as variability, 
cast(sum(rankings) as decimal(10,2)) as aggregates,
count(rankings) as rankcounts 
from readm_rankings 
group by provider_id 
order by averages;

-- This table returns the number of readmissions scores better than the national average; 
-- for each hospital;
create table readm_nratecounts as select
provider_id, count(nrate) as nratecounts
from readm_hospital 
where nrate = "Better than the National Rate"
group by provider_id
order by nratecounts desc;

-- This gives the corresponding rank based on the number of scores better than;
-- the national average.;

create table readm_nrateranks as select *, 
rank() over (order by nratecounts desc) as nrateranks 
from readm_nratecounts;


-- COMPLICATIONS;

-- This table gives the rank of each hospital for its complications scores;
-- It considers cases that are reported with a score only.;
create table comp_rankings as
select provider_id, meas_id, cast(ucl as decimal(10,2)) as ucl,
Rank() over (
partition by meas_id
order by score asc) as rankings
from comp_hospital
where cast(ucl as decimal(10,2)) is not null
order by  meas_id asc, provider_id asc;

-- This table reports the average and aggregate of all complications scores for each hospital;
create table comp_scoring as select provider_id, 
cast(avg(rankings) as decimal(10,2)) as averages, 
cast(stddev(rankings) as decimal(10,2)) as variability,
cast(sum(rankings) as decimal(10,2)) as aggregates,
count(rankings) as rankcounts 
from comp_rankings 
group by provider_id 
order by averages;

-- This table returns the number of complications scores better than the national average; 
-- for each hospital;
create table comp_nratecounts as select
provider_id, count(nrate) as nratecounts
from comp_hospital 
where nrate = "Better than the National Rate"
group by provider_id
order by nratecounts desc;


-- This gives the corresponding rank based on the number of scores better than;
-- the national average.;

create table comp_nrateranks as select *, 
rank() over (order by nratecounts desc) as nrateranks
from comp_nratecounts;


-- TIMELY AND EFFECTIVE CARE (TEC);

-- This table gives the rank of each hospital for its TEC scores;
-- It considers cases that are reported with a score only.;
-- Scores reported in minutes and pregnancy cases are not considered.;
-- Note that the order is reversed for rankings so that higher scores improve rank.;

create table tec_rankings as
select provider_id, meas_id, meas_name, cast(score as int) as score,
Rank() over (
partition by meas_id
order by score desc) as rankings
from tec_hospital
where cast(score as int) is not null
and condition <> "Pregnancy and Delivery Care"
and condition <> "Emergency Department"
and meas_name not like '%Median%'
order by  meas_id asc, provider_id asc;

-- This table reports the average, variability, and aggregate of all TEC score ranks for each hospital;

create table tec_scoring as select provider_id, 
cast(avg(rankings) as decimal(10,2)) as averages, 
cast(stddev(rankings) as decimal(10,2)) as variability,
cast(sum(rankings) as decimal(10,2)) as aggregates,
count(rankings) as rankcounts 
from tec_rankings 
group by provider_id 
order by averages;

-- This table joins tec_rankings and the national rate for each TEC score;

create table tec_with_national as select 
tec_rankings.provider_id, tec_rankings.meas_id, tec_rankings.score,
tec_rankings.rankings, tec_nation.score as nscore
from tec_rankings left outer join tec_nation
on (tec_rankings.meas_id = tec_nation.meas_id);

-- This table adds the "nrate" comparison to the TEC queries.;

create table tec_with_comparison as 
select *, case when score > nscore then "Better than the National Rate"
when score = nscore then "No different than the National Rate"
else "Worse than the National Rate" end as nrate
from tec_with_national;


-- This table returns the number of TEC scores better than the national average; 
-- for each hospital;

create table tec_nratecounts as select
provider_id, count(nrate) as nratecounts
from tec_with_comparison 
where nrate = "Better than the National Rate"
group by provider_id
order by nratecounts desc;


-- This gives the corresponding rank based on the number of scores better than;
-- the national average.;

create table tec_nrateranks as select *, 
rank() over (order by nratecounts desc) as nrateranks
from tec_nratecounts;



-- HOSPITAL SUMMARY TABLE;

--This table creates the summary from all previously generated tables for each hospital;
--Starting with the rank associated with the number of measures for which the hospital was better than average;
-- and the corresponding count. This score is important because many hospitals do not have a score, just an indication of better or worse;
create table hospital_tec1 as
select survey_results.provider_id,
survey_results.hospital_name, 
survey_results.stateID,
survey_results.base_score,
survey_results.consistency,
tec_nrateranks.nrateranks as tec_nrr,
tec_nrateranks.nratecounts as tec_nrc
from survey_results left outer join tec_nrateranks
on survey_results.provider_id = tec_nrateranks.provider_id;

--Now adding the average rank of the raw score and sample size, where available;

create table hospital_tec2 as
select hospital_tec1.*,
tec_scoring.averages as tsa,
tec_scoring.variability as tsv,
tec_scoring.aggregates as tss,
tec_scoring.rankcounts as tsr
from hospital_tec1 left outer join tec_scoring
on hospital_tec1.provider_id = tec_scoring.provider_id;

--Repeat as above with complications measures.;

create table hospital_comp1 as
select hospital_tec2.*,
comp_nrateranks.nrateranks as comp_nrr,
comp_nrateranks.nratecounts as comp_nrc
from hospital_tec2 left outer join comp_nrateranks
on hospital_tec2.provider_id = comp_nrateranks.provider_id;

--Now adding the average rank of the raw score and sample size, where available;

create table hospital_comp2 as
select hospital_comp1.*,
comp_scoring.averages as csa,
comp_scoring.variability as csv,
comp_scoring.aggregates as css, 
comp_scoring.rankcounts as csr
from hospital_comp1 left outer join comp_scoring
on hospital_comp1.provider_id = comp_scoring.provider_id;

--And finally readmissions measures;

create table hospital_readm1 as
select hospital_comp2.*,
readm_nrateranks.nrateranks as readm_nrr,
readm_nrateranks.nratecounts as readm_nrc
from hospital_comp2 left outer join readm_nrateranks
on hospital_comp2.provider_id = readm_nrateranks.provider_id;

--Now adding the average rank of the raw score and sample size, where available;

create table hospital_readm2 as
select hospital_readm1.*,
readm_scoring.averages as rsa,
readm_scoring.variability as rsv,
readm_scoring.aggregates as rss,
readm_scoring.rankcounts as rsr
from hospital_readm1 left outer join readm_scoring
on hospital_readm1.provider_id = readm_scoring.provider_id;

create table hospital_final as
select hospital_readm2.*,
tsa + rsa + csa as combined_ave,
tss + rss + css as combined_scores,
cast((tsv + rsv + csv)/3 as decimal (10,2)) as combined_var
from hospital_readm2
where tsa is not null
and rsa is not null
and csa is not null
order by combined_ave asc;

-- STATE SUMMARY;
create table state_summary as
select stateID,
cast(avg(base_score) as decimal(10,2)) as bs, 
cast(avg(combined_ave) as decimal(10,2)) as ca, 
cast(avg(combined_scores) as decimal(10,2)) as cs, 
cast(avg(consistency) as decimal(10,2)) as cons
from hospital_final
group by stateID;


-- MEASURE SUMMARY;

-- This table gives the standard deviation of scores for every TEC measure;
create table tec_sd as 
select meas_id, cast(stddev(score) as decimal(10,2)) as tec_sd
from tec_rankings
group by meas_id
order by tec_sd desc;


-- This table gives the standard deviation of scores for every readmission measure;
create table readm_sd as 
select meas_id, cast(stddev(ucl) as decimal(10,2)) as readm_sd
from readm_rankings
group by meas_id
order by readm_sd desc;

-- This table gives the standard deviation of scores for every complication measure;
create table comp_sd as 
select meas_id, cast(stddev(ucl) as decimal(10,2)) as comp_sd
from comp_rankings
group by meas_id
order by comp_sd desc;


