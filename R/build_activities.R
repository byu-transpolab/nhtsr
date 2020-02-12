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

# This function takes the activities list and numbers and classifies the tours each
# person takes during the day

build_tours <- function(activities) {

  # create columns for tour count
  activity_list <- activities %>%
    mutate(
      home_status = ifelse(activity == "01", 1, 0),
      tour_count = cumsum(home_status),
      # this goes in mutate to make home activites not a part of a tour
      tour_count = ifelse(home_status, NA, tour_count)
    ) %>%
    # no longer need home_status
    select(-home_status)

  # create the tour classification
  # create column of each classification.
  # outputs list of tours (not activities)
  tour_list <- activity_list %>%
    group_by(houseid, personid, tour_count) %>%
    summarise(tour_list = paste(activity, collapse = " ")) %>%
    mutate(tour_class = case_when(
      str_detect(tour_list, "03") == T ~ "W",
      str_detect(tour_list, "04") == T ~ "W",
      # I don't know if school or work will take priority
      str_detect(tour_list, "08") == T ~ "S",
      str_detect(tour_list, "01") == T ~ "home",
      TRUE ~ "NM"
    )) %>%
    # filter out the tours that are "home" because technically they aren't even tours.
    filter(tour_class != "home")

  # join back onto activites to create the classification column
  activity_list %>%
    left_join(tour_list, by = c("houseid", "personid", "tour_count")) %>%
    # eliminate tour_list
    select(-tour_list)


}
