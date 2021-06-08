# Reading files

#Scope of the report

#Please select the airport of interest ("4-letter ICAO code", "*" for all):
ICAO <- "*"

#Please select the year of interest (4-digit, "*" for all):
yyyy <- "2020"

#Please select the type of operation ("DEP" or "ARR" - Do not set for all "*")
MOV <- "DEP"

source("./R/list_apt_files.R")

if(MOV == "DEP"){
  colspecs <- cols(
    ADEP = col_character(),
    ADES = col_character(),
    FLTID = col_character(),
    REG = col_character(),
    CLASS = col_character(),
    TYPE = col_character(),
    FLTRUL = col_character(),
    DRWY = col_character(),
    STND = col_logical(),
    C40_BEAR = col_logical(),
    C40_TIME = col_logical(),
    C100_BEAR = col_logical(),
    C100_TIME = col_logical(),
    AOBT = col_character(),
    ATOT = col_character(),
    SOBT = col_character()
  )
  apt_files <- list_apt_files(ICAO, yyyy, MOV, .path = "./data raw/")
  (ds_raw <- map_dfr(apt_files, read_csv, col_types = colspecs))
  
  #Notice that the columns AOBT, ATOT and SOBT are characters. Let's parse it to date-time (dttm) objects:
  ds <- ds_raw %>% mutate(AOBT = ymd_hms(AOBT), ATOT = ymd_hms(ATOT), SOBT = ymd_hms(SOBT))
} else {
  colspecs <- cols(
    ADEP = col_character(),
    ADES = col_character(),
    FLTID = col_character(),
    REG = col_character(),
    CLASS = col_character(),
    TYPE = col_character(),
    FLTRUL = col_character(),
    DRWY = col_character(),
    STND = col_logical(),
    C40_BEAR = col_logical(),
    C40_TIME = col_logical(),
    C100_BEAR = col_logical(),
    C100_TIME = col_logical(),
    AIBT = col_character(),
    ALDT = col_character(),
    SIBT = col_character()
  )
  apt_files <- list_apt_files(ICAO, yyyy, MOV, .path = "./data raw/")
  (ds_raw <- map_dfr(apt_files, read_csv, col_types = colspecs))
  
  #Notice that the columns AIBT, ALDT and SIBT are characters. Let's parse it to date-time (dttm) objects:
  ds <- ds_raw %>% mutate(AIBT = ymd_hms(AIBT), ALDT = ymd_hms(ALDT), SIBT = ymd_hms(SIBT))
}

#name <- paste("ds", ICAO, yyyy, MOV, sep = "_")
#full_name <- paste0("./data/", name, ".csv")
#write_csv(ds, path = full_name)

rm(name, colspecs)