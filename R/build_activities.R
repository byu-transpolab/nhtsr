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

  # create a unique id for the first departure
  start_trip <- events %>%
    slice(1) %>%
    mutate(activity = paste(activity, "H", sep = "-"))

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


    spread(event, time) %>%
    arrange(arrive, .by_group = TRUE)

  # spread back into activities

}



# Nate's attempt to build activities

nhts_trips %>%
  # keep it small and only look at the first household
  filter(houseid == 	30000007) %>%
  select(houseid, personid, whyfrom, whyto, strttime, endtime) %>%
  group_by(personid) %>%
  add_row(whyfrom = lag(whyto))

  mutate(activity = lag(whyto),
         act_strt = lag(endtime),
         act_end = strttime)







# stack overflow help
#input
tibble(ID = 1:5,
       Value = 21:25)

#output
tibble(ID = c(1:5, "NA"),
       Value = c(21:25, "NA"),
       shift.key = c("NA", 21:25))

## experiment with rearranging activity...
events %>%
  mutate(activity = ifelse())
