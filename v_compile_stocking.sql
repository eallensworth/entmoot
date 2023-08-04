DROP VIEW "main"."v_compile_stocking";
CREATE VIEW v_compile_stocking
as
select t.*, 
c.cruise_type, 
c.cruise_yr, 
c.cruise_mo, 
c.cruise_dy, 
c.age_ht,
sp.plot_type,
sp.plot_size,
x.plots
from ((((stands as s
	inner join trees as t
		on s.forest = t.forest
			and s.stand = t.stand)
		inner join cruises as c
			on s.forest = c.forest
				and s.stand = c.stand
				and t.cruise = c.cruise)
			inner join cruise_types as ct
				on c.cruise_type = ct.cruise_type)
				inner join subplots as sp
					on ct.cruise_type = sp.cruise_type
						and t.subplot = sp.subplot)
				inner join (select s.forest,
					s.stand,
					p.cruise,
					count(p.plot) as plots
					from plots as p
						inner join (stands as s
							inner join cruises as c
								on s.forest = c.forest
									and s.stand = c.stand)
							on p.forest = s.forest
								and p.stand = s.stand
								and p.cruise = c.cruise
					where s.proc_flag = 1
					group by s.forest, s.stand) as x
					on t.forest = x.forest
						and t.stand = x.stand
						and t.cruise = x.cruise
where s.proc_flag = 1;
					