CREATE TABLE IF NOT EXISTS forests(
	forest				TEXT  NOT NULL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS stands(
	forest				TEXT NOT NULL,
	stand				TEXT  NOT NULL PRIMARY KEY,
	area				REAL NOT NULL DEFAULT 0.0,
	estab_yr			INTEGER,
	estab_mo			INTEGER,
	estab_dy			INTEGER,
	proc_flag			INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY(forest) REFERENCES forests(forest)
);
CREATE TABLE IF NOT EXISTS cruises (
	forest				TEXT NOT NULL,
	stand				TEXT NOT NULL,
	cruise				TEXT NOT NULL PRIMARY KEY,
	cruise_type			TEXT NOT NULL,
	cruise_yr			TEXT,
	cruise_mo			TEXT,
	cruise_dy			TEXT,
	age_index			TEXT NOT NULL,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise_type) REFERENCES cruise_types(cruise_type)
);
CREATE TABLE IF NOT EXISTS plots (
	forest				TEXT NOT NULL,
	stand				TEXT NOT NULL,
	cruise				TEXT NOT NULL,
	plot				INTEGER NOT NULL PRIMARY KEY,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruise(cruises)
);
CREATE TABLE IF NOT EXISTS trees (
	forest				TEXT NOT NULL,
	stand				TEXT NOT NULL,
	cruise				TEXT NOT NULL,
	plot				INTEGER NOT NULL,
	tree				INTEGER NOT NULL PRIMARY KEY,
	subplot				INTEGER NOT NULL DEFAULT 1,
	tree_count			REAL NOT NULL DEFAULT 1.0,
	status				INTEGER NOT NULL DEFAULT 1,
	species				TEXT NOT NULL,
	dbh 				REAL NOT NULL ,
	bh					REAL NOT NULL DEFAULT 4.5,
	tot_ht				REAL,
	tot_ht_code			INTEGER NOT NULL DEFAULT 0,
	crb_ht				REAL,
	crb_ht_code			INTEGER NOT NULL DEFAULT 0,
	age					INTEGER,
	age_code			INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruises(cruise),
	FOREIGN KEY(plot) REFERENCES plots(plot)
);
CREATE TABLE IF NOT EXISTS logs (
	forest				TEXT,
	stand				TEXT,
	cruise				TEXT,
	plot				INTEGER,
	tree				INTEGER,
	segment				INTEGER,
	ht_btm				REAL,
	ht_top				REAL,
	defect				INTEGER,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruises(cruise),
	FOREIGN KEY(plot) REFERENCES plots(plot),
	FOREIGN KEY(tree) REFERENCES trees(tree)
);
CREATE TABLE IF NOT EXISTS cruise_types (
	cruise_type			TEXT,
	age_index			TEXT
);
CREATE TABLE IF NOT EXISTS subplots (
	cruise_type			TEXT,
	subplot				TEXT,
	plot_type			INTEGER,
	plot_size			REAL,
	dbh_min				REAL,
	dbh_max				REAL,
	FOREIGN KEY(cruise_type) REFERENCES cruise_types(cruise_type)
);
CREATE TABLE IF NOT EXISTS compiler_specs (
	spec				TEXT,
	spec_group			TEXT,
	spec_value			BLOB
);
CREATE TABLE IF NOT EXISTS stands_proc (
	forest				TEXT, 
	stand				TEXT,
	grow_yr				INTEGER,
	status				TEXT,
	dom_species			TEXT,
	codom_species		TEXT,
	stems				REAL,
	basal				REAL,
	qmd					REAL,
	dom_ht				REAL,
	ccf					REAL,
	age					INTEGER,
	site_index			REAL,
	vol_cb_gross		REAL,
	vol_cb_net			REAL,
	vol_bd_gross		REAL,
	vol_bd_net			REAL,
	wt_gross			REAL,
	wt_net				REAL,
	biomass_gross		REAL,
	biomass_net			REAL,
	carb_bole			REAL,
	carb_foliage		REAL,
	carb_branch			REAL,
	carb_bark			REAL,
	carb_tree			REAL,
	carb_root			REAL,
	defect				REAL
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand)
);
CREATE TABLE IF NOT EXISTS cruises_proc (
	forest				TEXT, 
	stand				TEXT,
	cruise				TEXT
);
CREATE TABLE IF NOT EXISTS plots_proc (
	forest				TEXT, 
	stand				TEXT,
	cruise				TEXT
	plot				INTEGER,
	grow_yr				INTEGER,
	status				TEXT,
	dom_species			TEXT,
	codom_species		TEXT,
	stems				REAL,
	ba					REAL,
	qmd					REAL,
	dom_ht				REAL,
	ccf					REAL,
	age					INTEGER,
	site_index			REAL,
	vol_cb_gross		REAL,
	vol_cb_net			REAL,
	vol_bd_gross		REAL,
	vol_bd_net			REAL,
	wt_gross			REAL,
	wt_net				REAL,
	biomass_gross		REAL,
	biomass_net			REAL,
	carb_bole			REAL,
	carb_foliage		REAL,
	carb_branch			REAL,
	carb_bark			REAL,
	carb_tree			REAL,
	carb_root			REAL,
	defect				REAL
);
CREATE TABLE IF NOT EXISTS trees_proc (
	forest				TEXT, 
	stand				TEXT,
	cruise				TEXT,
	plot				INTEGER,
	tree				INTEGER,
	grow_yr				INTEGER,
	stems				REAL,		
	status				TEXT,
	species				TEXT,
	dbh 				REAL,
	ba 					REAL, 
	tot_ht				REAL,
	crb_ht				REAL,
	age					INTEGER,
	site_index			REAL,
	vol_cb_gross		REAL,
	vol_cb_net			REAL,
	vol_bd_gross		REAL,
	vol_bd_net			REAL,
	wt_gross			REAL,
	wt_net				REAL,
	biomass_gross		REAL,
	biomass_net			REAL,
	carb_bole			REAL,
	carb_foliage		REAL,
	carb_branch			REAL,
	carb_bark			REAL,
	carb_tree			REAL,
	carb_root			REAL,
	defect				REAL,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruises(cruise),
	FOREIGN KEY(plot) REFERENCES plots(plot),
	FOREIGN KEY(tree) REFERENCES trees(tree)
);
