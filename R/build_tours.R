#' Determine the tour, tour type, and daily activity pattern from a list of activities
#'
#' @param activities A `tibble` constructed from `build_activities`
#'
#' @return A `tibble` containing the details of the tours and DAP for the
#'   supplied activities.
#'
#' @importFrom dplyr select group_by mutate case_when summarise filter
#' @importFrom stringr str_detect
#'
#' @export
build_tours <- function(activities){

  # adds column that starts counting tours
  mytour_count <- activities %>%
    # eliminate unnecessary columns
    dplyr::select(houseid, personid, activity, activity_number, arrive, depart) %>%
    dplyr::group_by(houseid, personid) %>%
    # set a home status to create a cumulative count
    dplyr::mutate(
      home_status = ifelse(activity == "01", 1, 0),
      tour_count = cumsum(home_status),
      # this goes in mutate to make home activites not a part of a tour
      tour_count = ifelse(home_status, NA, tour_count)
    )

  # collapse tours into persons with DAPs
  dap_class <- mytour_count %>%
    # include group_by tour_count so the list is by tours not persons
    dplyr::group_by(houseid, personid, tour_count) %>%
    dplyr::summarise(tour_list = paste(activity, collapse = " ")) %>%
    dplyr::mutate(tour_class = case_when(
      stringr::str_detect(tour_list, "03") == T ~ "W",
      stringr::str_detect(tour_list, "04") == T ~ "W",
      stringr::str_detect(tour_list, "08") == T ~ "S",
      stringr::str_detect(tour_list, "01") == T ~ "home",
      stringr::str_detect(tour_list, "NA") == T ~ "H",
      TRUE ~ "NM"
    )) %>%
    # filter out the tours that are "home" because technically they aren't even tours.
    dplyr::filter(tour_class != "home"
           # when tour_count = 0, the person started at somewhere other than home

    ) %>%
    # collapse by tour_class add column for w1 and w2
    dplyr::summarise(tours_row = paste(tour_class, collapse = "-")) %>%
    dplyr::mutate(
      DAP_sub = dplyr::case_when(
        stringr::str_detect(tours_row, "W-W") == T ~ "W_2",
        stringr::str_detect(tours_row, "W") == T ~ "W_1",
        stringr::str_detect(tours_row, "S-S") == T ~ "S_2",
        stringr::str_detect(tours_row, "S") == T ~ "S_1",
        stringr::str_detect(tours_row, "H") == T ~ "H",
        TRUE ~ "NM"
        # still leaves the question, what about a tour like H-W-W-W == W-2?
      ),
      DAP = dplyr::case_when(
        DAP_sub %in% c("W_1", "W_2", "S_1", "S_2") ~ "M",
        DAP_sub == "NM" ~ "NM",
        TRUE ~ "H"
      )
    )

  ## ======================================================================
  # joins persons with activities lists (tours) with the daps created
  mytour_count %>%
    # collapse the activities into the day_plan column
    dplyr::group_by(houseid, personid) %>%
    dplyr::summarise(tour_list = paste(activity, collapse = " ")) %>%
    dplyr::left_join(dap_class, by = c("houseid", "personid")) %>%
    dplyr::mutate(DAP_sub = ifelse(is.na(DAP_sub), "H", DAP_sub),
           DAP = ifelse(is.na(DAP), "H", DAP))
}
