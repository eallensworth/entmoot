# Compiler Test
# E. Allensworth
# Created 2023-08-01


library(RSQLite)
library(readr)

compile_stocking <- function(file_name) {
  
  # Import data
  con <- dbConnect(RSQLite::SQLite(), file_name)
  sql_import <- readr::read_file("")
  df  <- dbGetQuery(con, )
  
}