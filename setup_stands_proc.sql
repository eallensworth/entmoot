insert into stand_proc (forest,
	stand,
	grow_yr,
	status,
	plots)
select s.forest,
	s.stand,
	c.cruise_yr - iif(c.cruise_mo >= 7, 0, 1) as grow_yr,
	t.status,
	count(t.plot) as plots
from (stands as s
	inner join trees as t
		on s.forest = t.forest
			and s.stand = t.stand)
		inner join cruises as c
			on s.forest = c.forest
				and s.stand = c.stand
					and t.cruise = c.cruise
group by s.forest, s.stand, c.cruise_yr, c.cruise_mo, t.status;