select count(distinct a.partner_rk)
from 
	msu_special.legend a
	left join 
	msu_special.location b
	on a.partner_rk = b.partner_rk
where b.location_rk is null
