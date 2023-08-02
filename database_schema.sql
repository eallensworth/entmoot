BEGIN TRANSACTION;

-- forests Table
CREATE TABLE IF NOT EXISTS forests(
	forest				TEXT,
	PRIMARY KEY(forest)
);
INSERT INTO forests
VALUES ("harmsworth");

-- stands Table
CREATE TABLE IF NOT EXISTS stands(
	forest				TEXT,
	stand				TEXT,
	area				REAL NOT NULL DEFAULT 0.0,
	estab_yr			INTEGER,
	estab_mo			INTEGER,
	estab_dy			INTEGER,
	proc_flag			INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY(forest, stand),
	FOREIGN KEY(forest) REFERENCES forests(forest)
);
INSERT INTO stands
VALUES 
	("harmsworth","blueberry",10,2020,2,22,1),
	("harmsworth","uno",10,2022,9,15,1);

-- cruise_types Table
CREATE TABLE IF NOT EXISTS cruise_types (
	cruise_type			TEXT NOT NULL PRIMARY KEY
);
INSERT INTO cruise_types
VALUES ("10th-acre fixed");

-- subplots Table
CREATE TABLE IF NOT EXISTS subplots (
	cruise_type			TEXT,
	subplot				TEXT,
	plot_type			TEXT NOT NULL,
	plot_size			REAL NOT NULL,
	dbh_min				REAL NOT NULL,
	dbh_max				REAL NOT NULL,
	PRIMARY KEY(cruise_type, subplot),
	FOREIGN KEY(cruise_type) REFERENCES cruise_types(cruise_type)
);
INSERT INTO subplots
VALUES ("10th-acre fixed",1,"fixed_radius",11.85,0,999);
	
-- cruises Table
CREATE TABLE IF NOT EXISTS cruises (
	forest				TEXT,
	stand				TEXT,
	cruise				TEXT,
	cruise_type			TEXT NOT NULL,
	cruise_yr			INTEGER,
	cruise_mo			INTEGER,
	cruise_dy			INTEGER,
	age_ht				TEXT,
	PRIMARY KEY(forest, stand, cruise),
	FOREIGN KEY(forest) REFERENCES stands(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise_type) REFERENCES cruise_types(cruise_type)
);
INSERT INTO cruises
VALUES
	("harmsworth","blueberry",2023,"10th-acre fixed",2023,8,1,"breast height"),
	("harmsworth","uno",2023,"10th-acre fixed",2023,8,1,"breast height");

-- plots Table
CREATE TABLE IF NOT EXISTS plots (
	forest				TEXT,
	stand				TEXT,
	cruise				TEXT,
	plot				INTEGER,
	PRIMARY KEY(forest, stand, cruise, plot),
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruises(cruise)
);
INSERT INTO plots
VALUES
	("harmsworth","sheena",2023,1),
	("harmsworth","sheena",2023,2),
	("harmsworth","elijah",2023,1);

CREATE TABLE IF NOT EXISTS trees (
	forest				TEXT,
	stand				TEXT,
	cruise				TEXT,
	plot				INTEGER,
	tree				INTEGER,
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
	PRIMARY KEY(forest, stand, cruise, plot, tree),
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(subplot) REFERENCES subplots(subplot),
	FOREIGN KEY(plot) REFERENCES plots(plot)
);
INSERT INTO trees
VALUES
	("harmsworth","sheena",2023,1,1,1,1,1,202,15.7,4.5,98,1,26,1,NULL,0),
	("harmsworth","sheena",2023,1,2,1,1,1,202,17.5,4.5,115,1,36,1,NULL,0),
	("harmsworth","sheena",2023,1,3,1,1,1,261,16.0,4.5,103,1,13,1,NULL,0),
	("harmsworth","sheena",2023,2,1,1,1,1,202,15.7,4.5,98,1,26,1,NULL,0),
	("harmsworth","sheena",2023,2,2,1,1,1,202,18.7,4.5,98,1,26,1,NULL,0),
	("harmsworth","elijah",2023,1,1,1,1,1,202,100,4.5,600,1,26,1,NULL,0);

-- logs Table	
CREATE TABLE IF NOT EXISTS logs (
	forest				TEXT NOT NULL,
	stand				TEXT NOT NULL,
	cruise				TEXT NOT NULL,
	plot				INTEGER NOT NULL,
	tree				INTEGER NOT NULL,
	segment				INTEGER PRIMARY KEY,
	ht_btm				REAL NOT NULL,
	ht_top				REAL NOT NULL,
	defect				INTEGER,
	FOREIGN KEY(forest) REFERENCES forests(forest),
	FOREIGN KEY(stand) REFERENCES stands(stand),
	FOREIGN KEY(cruise) REFERENCES cruises(cruise),
	FOREIGN KEY(plot) REFERENCES plots(plot),
	FOREIGN KEY(tree) REFERENCES trees(tree)
);

-- compiler_specs Table
CREATE TABLE IF NOT EXISTS compiler_specs (
	spec				TEXT NOT NULL PRIMARY KEY,
	spec_group			TEXT NOT NULL,
	spec_value			BLOB NOT NULL
);

-- stands_proc Table
CREATE TABLE IF NOT EXISTS stands_proc (
	forest				TEXT, 
	stand				TEXT,
	grow_yr				INTEGER,
	status				TEXT,
	plots				INTEGER,
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
);

-- cruises_proc Table
CREATE TABLE IF NOT EXISTS cruises_proc (
	forest				TEXT, 
	stand				TEXT,
	cruise				TEXT
);

-- plots_proc Table
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

-- trees_proc
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
	defect				REAL
);
