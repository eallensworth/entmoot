
-- forests table
create table if not exists forests(
	forest				text,
	primary key (forest)
);
insert into forests
values ("harmsworth");

-- stands table
create table if not exists stands(
	forest				text,
	stand				text,
	area				real not null default 0.0,
	estab_yr			integer,
	estab_mo			integer,
	estab_dy			integer,
	proc_flag			integer not null default 1,
	primary key(forest, stand),
	foreign key(forest) references forests(forest) on delete cascade on update cascade
);
insert into stands
values 
	("harmsworth","blueberry",10,2020,2,22,1),
	("harmsworth","uno",10,2022,9,15,1);

-- cruise_types table
create table if not exists cruise_types (
	cruise_type			text not null primary key
);
insert into cruise_types
values ("10th-acre fixed");

-- subplots table
create table if not exists subplots (
	cruise_type			text,
	subplot				text,
	plot_type			text not null,
	plot_size			real not null,
	dbh_min				real not null,
	dbh_max				real not null,
	primary key(cruise_type, subplot),
	foreign key(cruise_type) references cruise_types(cruise_type)
);
insert into subplots
values ("10th-acre fixed",1,"fixed_radius",11.85,0,999);
	
-- cruises table
create table if not exists cruises (
	forest				text,
	stand				text,
	cruise				text,
	cruise_type			text not null,
	cruise_yr			integer,
	cruise_mo			integer,
	cruise_dy			integer,
	age_ht				text,
	primary key(forest, stand, cruise),
	foreign key(forest, stand) references stands(forest, stand) on delete cascade on update cascade,
	foreign key(cruise_type) references cruise_types(cruise_type) on update cascade
);
insert into cruises
values
	("harmsworth","blueberry",2023,"10th-acre fixed",2023,8,1,"breast height"),
	("harmsworth","uno",2023,"10th-acre fixed",2023,8,1,"breast height");

-- plots table
create table if not exists plots (
	forest				text,
	stand				text,
	cruise				text,
	plot				integer,
	primary key(forest, stand, cruise, plot),
	foreign key(forest, stand, cruise) references cruises(forest, stand, cruise) on delete cascade on update cascade
);
insert into plots
values
	("harmsworth","blueberry",2023,1),
	("harmsworth","blueberry",2023,2),
	("harmsworth","uno",2023,1);

create table if not exists trees (
	forest				text,
	stand				text,
	cruise				text,
	plot				integer,
	tree				integer,
	subplot				integer not null default 1,
	tree_count			real not null default 1.0,
	status				integer not null default 1,
	species				text not null,
	dbh 				real not null ,
	bh					real not null default 4.5,
	tot_ht				real,
	tot_ht_code			integer not null default 0,
	crb_ht				real,
	crb_ht_code			integer not null default 0,
	age					integer,
	age_code			integer not null default 0,
	primary key(forest, stand, cruise, plot, tree),
	foreign key(forest, stand, cruise, plot) references plots(forest, stand, cruise, plot) on delete cascade on update cascade
);
insert into trees
values
	("harmsworth","blueberry",2023,1,1,1,1,1,202,15.7,4.5,98,1,26,1,null,0),
	("harmsworth","blueberry",2023,1,2,1,1,1,202,17.5,4.5,115,1,36,1,null,0),
	("harmsworth","blueberry",2023,1,3,1,1,1,261,16.0,4.5,103,1,13,1,null,0),
	("harmsworth","blueberry",2023,2,1,1,1,1,202,15.7,4.5,98,1,26,1,null,0),
	("harmsworth","blueberry",2023,2,2,1,1,1,202,18.7,4.5,98,1,26,1,null,0),
	("harmsworth","uno",      2023,1,1,1,1,1,202,100,4.5,600,1,26,1,null,0);

-- logs table	
create table if not exists logs (
	forest				text not null,
	stand				text not null,
	cruise				text not null,
	plot				integer not null,
	tree				integer not null,
	segment				integer primary key,
	ht_btm				real not null,
	ht_top				real not null,
	defect				integer,
	foreign key(forest, stand, cruise, plot, tree) references trees(forest, stand, cruise, plot, tree) on delete cascade on update cascade
);

-- compiler_specs table
create table if not exists compiler_specs (
	spec				text not null primary key,
	spec_group			text not null,
	spec_value			blob not null
);

-- stands_proc table
create table if not exists stands_proc (
	forest				text, 
	stand				text,
	grow_yr				integer,
	status				text,
	plots				integer,
	dom_species			text,
	codom_species		text,
	stems				real,
	basal				real,
	qmd					real,
	dom_ht				real,
	ccf					real,
	age					integer,
	site_index			real,
	vol_cb_gross		real,
	vol_cb_net			real,
	vol_bd_gross		real,
	vol_bd_net			real,
	wt_gross			real,
	wt_net				real,
	biomass_gross		real,
	biomass_net			real,
	carb_bole			real,
	carb_foliage		real,
	carb_branch			real,
	carb_bark			real,
	carb_tree			real,
	carb_root			real,
	defect				real
);

-- cruises_proc table
create table if not exists cruises_proc (
	forest				text, 
	stand				text,
	cruise				text
);

-- plots_proc table
create table if not exists plots_proc (
	forest				text, 
	stand				text,
	cruise				text
	plot				integer,
	grow_yr				integer,
	status				text,
	dom_species			text,
	codom_species		text,
	stems				real,
	ba					real,
	qmd					real,
	dom_ht				real,
	ccf					real,
	age					integer,
	site_index			real,
	vol_cb_gross		real,
	vol_cb_net			real,
	vol_bd_gross		real,
	vol_bd_net			real,
	wt_gross			real,
	wt_net				real,
	biomass_gross		real,
	biomass_net			real,
	carb_bole			real,
	carb_foliage		real,
	carb_branch			real,
	carb_bark			real,
	carb_tree			real,
	carb_root			real,
	defect				real
);

-- trees_proc
create table if not exists trees_proc (
	forest				text, 
	stand				text,
	cruise				text,
	plot				integer,
	tree				integer,
	grow_yr				integer,
	stems				real,		
	status				text,
	species				text,
	dbh 				real,
	ba 					real, 
	tot_ht				real,
	crb_ht				real,
	age					integer,
	site_index			real,
	vol_cb_gross		real,
	vol_cb_net			real,
	vol_bd_gross		real,
	vol_bd_net			real,
	wt_gross			real,
	wt_net				real,
	biomass_gross		real,
	biomass_net			real,
	carb_bole			real,
	carb_foliage		real,
	carb_branch			real,
	carb_bark			real,
	carb_tree			real,
	carb_root			real,
	defect				real
);