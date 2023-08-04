create view if not exists v_compile_plots
as
select s.forest,
s.stand,
count(p.plot) as plots
from plots as p
	inner join stands as s
		on p.forest = s.forest
			and p.stand = s.stand
where s.proc_flag = 1
group by s.forest, s.stand;