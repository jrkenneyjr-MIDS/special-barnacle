
-- 10 Most Variable TEC Procedures;
select distinct tec_sd.meas_id, tec_hospital.meas_name, tec_sd.tec_sd
from tec_sd inner join tec_hospital
on tec_sd.meas_id = tec_hospital.meas_id
order by tec_sd.tec_sd desc
limit 10;

-- 10 Most Variable Cause of Complications;
select distinct comp_sd.meas_id, comp_hospital.meas_name, comp_sd.comp_sd
from comp_sd inner join comp_hospital
on comp_sd.meas_id = comp_hospital.meas_id
order by comp_sd.comp_sd desc
limit 10;

-- 10 Most Variable Readmissions Causes;
select distinct readm_sd.meas_id, readm_hospital.meas_name, readm_sd.readm_sd
from readm_sd inner join readm_hospital
on readm_sd.meas_id = readm_hospital.meas_id
order by readm_sd.readm_sd desc
limit 10;

