library(tidyverse)
# Start by downloading and unzipping the SPSS version of the NHTS public files. Need to have wget and 7z on your system.
#system2("wget", args = c("https://nhts.ornl.gov/assets/2022/download/spss.zip"))
#system2("7z", args = c("x", "data-raw/spss.zip", "-odata-raw"))

## Prepare `nhts_households` ============================
hh_raw <- haven::read_spss("data-raw/HHV2PUB.sav")
names(hh_raw) <- tolower(names(hh_raw))
hh_vars <- names(hh_raw)

nhts22_households <- hh_raw

## Prepare `nhts_persons` dataset goes here ============================
pp_raw <- haven::read_spss("data-raw/PERV2PUB.sav")
names(pp_raw) <- tolower(names(pp_raw))

# Tidy data suggests not keeping redundant variables
pp_vars <- names(pp_raw)
nhts22_persons <- pp_raw |>
  dplyr::select(pp_vars[!(pp_vars %in% hh_vars[-1])])

## Prepare `nhts_vehicles` ============================
vh_raw <- haven::read_spss("data-raw/VEHV2PUB.sav")
names(vh_raw) <- tolower(names(vh_raw))

# Tidy data suggests not keeping redundant variables
vh_vars <- names(vh_raw)
nhts22_vehicles <- vh_raw |>
  dplyr::select(vh_vars[!(vh_vars %in% hh_vars[-1])])

## Prepare `nhts_trips` ============================
tr_raw <- haven::read_spss("data-raw/TRIPV2PUB.sav")
names(tr_raw) <- tolower(names(tr_raw))
tr_vars <- names(tr_raw)

#' Change the time from a four-digit character string to a real datetime
#' object.
#'
#' @param clock
#' @param date
#' @return datetime
clock_to_time <- function(clock, date = "2022-10-10"){
  hrs <- substr(clock, 1,2)
  mins <- substr(clock, 3, 4)
  lubridate::as_datetime(stringr::str_c(date, " ",  hrs, ":", mins, ":00"))
}


nhts22_trips <- tr_raw |>
  # Tidy data suggests not keeping redundant variables
  select(tr_vars[!(tr_vars %in% hh_vars[-1])], travday) |>
  select(houseid, tr_vars[!(tr_vars %in% pp_vars[-2])], travday) |>
  mutate(
    date = case_when(
      travday == "01" ~ "2022-10-09",
      travday == "02" ~ "2022-10-10",
      travday == "03" ~ "2022-10-11",
      travday == "04" ~ "2022-10-12",
      travday == "05" ~ "2022-10-13",
      travday == "06" ~ "2022-10-14",
      travday == "07" ~ "2022-10-15"
    ),
    tdtrpnum = as.numeric(seq_tripid),
    strttime = clock_to_time(strttime, date),
    endtime = clock_to_time(endtime, date),
    gasprice = as.numeric(gasprice)
  )


## Save datasets =============================================================
usethis::use_data(nhts22_households, overwrite = TRUE)
usethis::use_data(nhts22_persons, overwrite = TRUE)
usethis::use_data(nhts22_vehicles, overwrite = TRUE)
usethis::use_data(nhts22_trips, overwrite = TRUE)

