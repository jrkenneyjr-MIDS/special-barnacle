-- 10 Best States;

select stateID,
ca, cs, bs, cons
from state_summary
order by ca asc
limit 10;

