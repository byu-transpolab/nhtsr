#' Build an activities dataframe from the NHTS Trips dataset
#'
#' @param activities dataset from `build_activities()`
#'
#' @return A `tibble` with one row per person for each person in the NHTS dataset.
#' output includes: `houseid`, `personid`, `tour_list`, `tours_row`, and `DAP`
#'

build_tours <- function(activities){

  # adds column that starts counting tours
  mytour_count <- activities %>%
    # eliminate unnecessary columns
    select(houseid, personid, activity, activity_number, arrive, depart) %>%
    group_by(houseid, personid) %>%
    # set a home status to create a cumulative count
    mutate(
      home_status = ifelse(activity == "01", 1, 0),
      tour_count = cumsum(home_status),
      # this goes in mutate to make home activites not a part of a tour
      tour_count = ifelse(home_status, NA, tour_count)
    )

  # collapse tours into persons with DAPs
  dap_class <- mytour_count %>%
    # include group_by tour_count so the list is by tours not persons
    group_by(houseid, personid, tour_count) %>%
    summarise(tour_list = paste(activity, collapse = " ")) %>%
    mutate(tour_class = case_when(
      str_detect(tour_list, "03") == T ~ "W",
      str_detect(tour_list, "04") == T ~ "W",
      str_detect(tour_list, "08") == T ~ "S",
      str_detect(tour_list, "01") == T ~ "home",
      str_detect(tour_list, "NA") == T ~ "H",
      TRUE ~ "NM"
    )) %>%
    # filter out the tours that are "home" because technically they aren't even tours.
    filter(tour_class != "home"
           # when tour_count = 0, the person started at somewhere other than home
           # and they will be cut out of the data
           # tour_count != 0)
    ) %>%
    # collapse by tour_class add column for w1 and w2
    summarise(tours_row = paste(tour_class, collapse = "-")) %>%
    mutate(DAP = case_when(
      str_detect(tours_row, "W-W") == T ~ "W_2",
      str_detect(tours_row, "W") == T ~ "W_1",
      str_detect(tours_row, "S-S") == T ~ "S_2",
      str_detect(tours_row, "S") == T ~ "S_1",
      str_detect(tours_row, "H") == T ~ "H",
      TRUE ~ "NM"
      # still leaves the question, what about a tour like H-W-W-W == W-2?
      # this would need to be figured out somewhere else...
    ))

  ## ======================================================================
  # joins persons with activities lists (tours) with the daps created
  mytour_count %>%
    # collapse the activities into the day_plan column
    group_by(houseid, personid) %>%
    summarise(tour_list = paste(activity, collapse = " ")) %>%
    left_join(dap_class, by = c("houseid", "personid"))
}
