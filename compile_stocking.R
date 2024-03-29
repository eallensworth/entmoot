# Compiler Test
# E. Allensworth
# Created 2023-08-01

library(tidyverse)
library(RSQLite)
library(readr)

#compile_stocking <- function(file_name) {
  
# Import data
file_name = "brightbeam.db"
con <- dbConnect(RSQLite::SQLite(), file_name)
trees  <- as_tibble(dbGetQuery(con, "SELECT * FROM v_compile_stocking;"))

# Calculate stems and basal area
trees <- trees %>%
  mutate(stems = 43560 / (plot_size ^ 2 * 3.14) * tree_count / plots,
         ba = dbh ^ 2 * 0.005454154)

# roll up to plots
plots <- trees %>%
  group_by(forest, stand, cruise, plot) %>%
  summarize(stems = sum(stems * plots),
            ba = sum(ba * stems * plots))


