#' Build an activities dataframe from the NHTS Trips dataset
#'
#' @param trips The NHTS Trips dataset, e.g. `nhts_trips` or a subset.
#'
#' @return A `tibble` with one row per activity for each person in the NHTS dataset.
#'
build_activities <- function(trips) {

  events <- trips %>%
    # keep only necessary activity fields
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
    slice(1) %>%
    transmute(activity = whyfrom, time = lubridate::as_datetime("2017-10-10 4:00:00"), event = "arrive")

  # spread back into activities

}
