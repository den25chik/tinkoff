select partner_nm, avg(time) as avg_time
from
-- Составил одну таблицу, связав несколько таблиц: (employee_rk, time, quest_rk) с
-- (quest_rk, location_rk) по quest_rk, затем с (location_rk, partner_rk) по 
-- location_rk, после с (partner_rk, partner_nm) по partner_rk
	(
	(
	(-- Время прохождения квестов с операторами-девушками
	select a.employee_rk, time, quest_rk
	from 
		msu_special.game a
		inner join 
		msu_special.employee b
		on a.employee_rk = b.employee_rk
	where b.gender_cd = 'f' and a.finish_flg = 1
	) c
	inner join
	( -- Локации квестов
	select quest_rk, location_rk
	from msu_special.quest
	) d
	on c.quest_rk = d.quest_rk
	) e
	inner join
	( -- Партнеры на локациях
	select location_rk, partner_rk
	from msu_special.location
	) f
	on e.location_rk = f.location_rk
	) g
	inner join
	( -- Название партнеров
	select partner_rk, partner_nm
	from msu_special.partner
	) h
	on g.partner_rk = h.partner_rk
group by partner_nm
order by avg_time, partner_nm
limit 1
