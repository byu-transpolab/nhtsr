library(tidyverse)
# Start by downloading and unzipping the SPSS version of the NHTS public files.
system2("wget", args = c("https://nhts.ornl.gov/assets/2016/download/Spss.zip", "data-raw/Spss.zip"))
system2("7z", args = c("x", "data-raw/Spss.zip", "-odata-raw"))

## Prepare `nhts_households` ============================
hh_raw <- haven::read_spss("data-raw/hhpub.sav")
hh_vars <- names(hh_raw)

nhts_households <- hh_raw

## Prepare `nhts_persons` dataset goes here ============================
pp_raw <- haven::read_spss("data-raw/perpub.sav")

# Tidy data suggests not keeping redundant variables
pp_vars <- names(pp_raw)
nhts_persons <- pp_raw %>%
  select(pp_vars[!(pp_vars %in% hh_vars[-1])])

## Prepare `nhts_vehicles` ============================
vh_raw <- haven::read_spss("data-raw/vehpub.sav")

# Tidy data suggests not keeping redundant variables
vh_vars <- names(vh_raw)
nhts_vehicles <- vh_raw %>%
  select(vh_vars[!(vh_vars %in% hh_vars[-1])])

## Prepare `nhts_trips` ============================
tr_raw <- haven::read_spss("data-raw/trippub.sav")

#' Change the time from a four-digit character string to a real datetime
#' object.
#'
#' @param clock
#' @param date
#' @return datetime
clock_to_time <- function(clock, date = "2017-10-10"){
  hrs <- substr(clock, 1,2)
  mins <- substr(clock, 3, 4)
  lubridate::as_datetime(stringr::str_c(date, " ",  hrs, ":", mins, ":00"))
}


tr_vars <- names(tr_raw)
nhts_trips <- tr_raw %>%
  # Tidy data suggests not keeping redundant variables
  select(tr_vars[!(tr_vars %in% hh_vars[-1])]) %>%
  select(houseid, tr_vars[!(tr_vars %in% pp_vars[-2])]) %>%
  mutate(
    tdtrpnum = as.numeric(tdtrpnum),
    strttime = clock_to_time(strttime),
    endtime = clock_to_time(endtime),
    gasprice = as.numeric(gasprice)
  )


## Save datasets =============================================================
usethis::use_data(nhts_households)
usethis::use_data(nhts_persons)
usethis::use_data(nhts_vehicles)
usethis::use_data(nhts_trips, overwrite = TRUE)
