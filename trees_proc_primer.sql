insert into trees_proc (forest,
	stand,
	cruise,
	plot,
	tree,
	grow_yr,
	stems,
	status,
	species,
	dbh,
	ba)
select v.forest,
v.stand,
v.cruise,
v.plot,
v.tree,
2020,
round(43560 / (v.plot_size * v.plot_size * 3.141592653), 0) * v.tree_count / v.plots as stems,
v.status,
v.species,
v.dbh,
v.dbh * dbh * 0.005454154 as ba
from v_compile_stocking as v
where v.plot_type = 'fixed_radius';