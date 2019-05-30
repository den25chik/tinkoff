with convers as
(
	select
		b.quest_nmv, 
		count(game_flg) as slot, 
		sum(game_flg) as game,
		cast(sum(game_flg) as float4)/count(game_flg) as conversion_game,  
		sum(finish_flg) as finish,
		cast(sum(finish_flg) as float4)/sum(game_flg) as conversion_finish	
	from 
		msu_special.game a
		inner join
		msu_special.quest b
		on a.quest_rk = b.quest_rk
	group by b.quest_nmv
)
select *
from convers
----Далее выбрать только одну сортировку
----
----Поиск самого легкого квеста
order by conversion_finish desc, game desc
----Поиск самого сложного квеста
--order by conversion_finish, game desc
----Поиск самого популярного квеста
--order by conversion_game desc, slot desc
----Поиск самого непопулярного квеста
--order by conversion_game, slot desc
----
----Конец выбора
limit 1
