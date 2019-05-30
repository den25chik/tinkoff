select a.quest_rk, abs(a.jan - b.feb) as difference
from
	( -- Доля состоявшихся квестов в январе
	select quest_rk, cast(sum(game_flg) as float4)/count(game_flg) as jan
	from msu_special.game
	where game_dttm between '2018-01-01 00:00:00' and '2018-01-31 23:59:59'
	group by quest_rk
	)a
	inner join
	( -- Доля состоявшихся квестов в феврале
	select quest_rk, cast(sum(game_flg) as float4)/count(game_flg) as feb
	from msu_special.game
	where game_dttm between '2018-02-01 00:00:00' and '2018-02-28 23:59:59'
	group by quest_rk
	)b
	on a.quest_rk = b.quest_rk
	-- Сортировка по difference, а затем сортировка по quest_rk 
	order by difference desc, a.quest_rk desc
	-- Вывести только результат
	limit 1