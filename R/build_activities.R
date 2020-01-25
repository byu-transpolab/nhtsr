#' Build an activities dataframe from the NHTS Trips dataset
#'
#' @param trips The NHTS Trips dataset, e.g. `nhts_trips` or a subset.
#'
#' @return A `tibble` with one row per activity for each person in the NHTS dataset.
#'
#'
library(tidyverse)
library(nhts2017)
library(lubridate)


build_activities <- function(trips) {

  events <- nhts_trips %>%
    # keep only necessary activity fields
    select(houseid, personid, strttime, endtime, whyfrom, whyto) %>%
    # simplified to only the first household of three persons
    filter(houseid == 	30000007) %>%

    # gather times
    gather(strtend, time, strttime, endtime) %>%
    group_by(houseid, personid) %>%
    arrange(time, .by_group = TRUE) %>%
    mutate(
      event = ifelse(strtend == "strttime", "depart", "arrive"),
      activity = ifelse(event == "depart", whyfrom, whyto)
    )


  first_activity <- events %>%
    # take the starting point of each person
    slice(1) %>%
    # creates a starting time for each person at 4:00:00 am
    transmute(activity = as.character(whyfrom) %>%
                # attach an H to make sense that arrive at 01 is returning home (helps with the
                # spread() function)
                paste("H", sep = "-"),
              time = as_datetime("2017-10-10 4:00:00"),
              event = "start")

  last_activity <- events %>%
    slice(1) %>%
    transmute(activity = as.character(whyfrom) %>%
                # attach an H to make sense that arrive at 01 is returning home (helps with the
                # spread() function)
                paste("H", sep = "-"),
              time = as_datetime("2017-10-11 4:00:00"),
              event = "finish")

  events %>% full_join(first_activity) %>% full_join(last_activity) %>%
    arrange(time, .by_group = TRUE) %>%
    select(houseid, personid, time, event, activity) %>%

# it is not quite working yet because arrive at 01 at 4:00am is the same as arrive at 01 at
# 3:30 pm and it confuses spread(). I have tried renaming to "start" and "finish" or 01-H...
    spread(event, time) %>%
    arrange(arrive, .by_group = TRUE)


}




