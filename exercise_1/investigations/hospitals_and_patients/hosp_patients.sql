-- Correlation between hospital rank performance and survey response base score;
select corr(cast(combined_ave as decimal(10,2)), cast(base_score as decimal(10,2))) 
from hospital_final where cast(base_score as decimal(10,2)) is not null;

-- Correlation between hospital rank performance and survey response consistency;
select corr(cast(combined_ave as decimal(10,2)), cast(consistency as decimal(10,2))) 
from hospital_final where cast(base_score as decimal(10,2)) is not null;

-- Correlation between hospital rank score variability and survey response base score;
select corr(cast(combined_var as decimal(10,2)), cast(base_score as decimal(10,2))) 
from hospital_final where cast(base_score as decimal(10,2)) is not null;

-- Correlation between hospital rank score variability and survey response consistency;
select corr(cast(combined_var as decimal(10,2)), cast(consistency as decimal(10,2))) 
from hospital_final where cast(base_score as decimal(10,2)) is not null;
