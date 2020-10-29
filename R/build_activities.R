#' Build an activities dataframe from the NHTS Trips dataset
#'
#' @param trips A `tibble` containing records from the `nhts_trips` dataset. Must
#'   contain (at a minumum) the following columns:
#'   - `houseid`
#'   - `personid`
#'   - `strttime`
#'   - `endtime`
#'   - `whyfrom`
#'   - `whyto`
#'
#' @return A `tibble` with one row per activity for each person in the `trips`
#'   input dataset.
#'
#' @details The NHTS data does not have a start time for the travel day. This
#'   function assumes that all days will begin at 4:00 AM, though this may introduce
#'   illogical activity patterns in some situations.
#'
#' @examples
#'
#' @author Nate Lant
#'
#'
#' @importFrom dplyr select group_by arrange mutate slice transmute
#' @importFrom tidyr gather spread
#' @importFrom lubridate as_datetime
#'
#' @export
build_activities <- function(trips) {

  # create list of events labeled arrive or depart
  events <- trips %>%
    # exlude all other trip attributes
    dplyr::select(houseid, personid, strttime, endtime, whyfrom, whyto) %>%
    # gather times
    tidyr::gather(strtend, time, strttime, endtime) %>%
    dplyr::group_by(houseid, personid) %>%
    # there have been errors where a time stamp is wrongly labeled and
    # wrongly arranged here...and again on line 57
    dplyr::arrange(time, .by_group = TRUE) %>%
    dplyr::mutate(
      event = ifelse(strtend == "strttime", "depart", "arrive"),
      activity = ifelse(event == "depart", whyfrom, whyto)
    )


  # create the first activity for each person with a start time at 4 AM
  first_activity <- events %>%
    # take the starting point of each person
    dplyr::slice(1) %>%
    # creates a starting time for each person at 4:00:00 am
    dplyr::transmute(
      activity = as.character(whyfrom),
      time = lubridate::as_datetime("2017-10-10 4:00:00"),
      event = "arrive"
    )

  # create the last activity for each person with an end time of 4AM the next day
  last_activity <- events %>%
    dplyr::slice(n()) %>%
    dplyr::transmute(
      activity = as.character(whyto),
      time = lubridate::as_datetime("2017-10-11 4:00:00"),
      event = "depart"
    )

  # combine events with first and last activity
  # spread by either arrive or depart
  events %>%
    dplyr::full_join(first_activity) %>%
    dplyr::full_join(last_activity) %>%
    dplyr::arrange(time, .by_group = TRUE) %>%
    dplyr::select(-whyfrom, -whyto, -strtend) %>%
    dplyr::group_by(houseid, personid, event) %>%
    dplyr::mutate(activity_number = as.integer(factor(time))) %>%
    tidyr::spread(event, time) %>%
    dplyr::arrange(arrive, .by_group = TRUE)


}
