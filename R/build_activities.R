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


# Necessary fields include houseid, personid, strttime, endtime, whyfrom, whyto

build_activities <- function(trips) {

  # create list of events labeled arrive or depart
  events <- trips %>%
    # exlude all other trip attributes
    select(houseid, personid, strttime, endtime, whyfrom, whyto) %>%
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
    transmute(activity = as.character(whyfrom), #%>%
                #paste("S", sep = "-"),
              time = as_datetime("2017-10-10 4:00:00"),
              event = "arrive")

  last_activity <- events %>%
    slice(n()) %>%
    transmute(activity = as.character(whyto),
              time = as_datetime("2017-10-11 4:00:00"),
              event = "depart")

  # combine events with first and last activity
  # spread by either arrive or depart
events %>% full_join(first_activity) %>% full_join(last_activity) %>%
    arrange(time, .by_group = TRUE) %>%
    select(-whyfrom, -whyto, -strtend) %>%
    group_by(houseid, personid, event) %>%
    mutate(activity_number = as.integer(factor(time))) %>%
    spread(event, time) %>%
    arrange(arrive, .by_group = TRUE)

}


