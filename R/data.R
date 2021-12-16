#' Public Household Records
#'
#' A dataset containing households records from the 2017 National household
#' travel survey.
#'
#'
#' @format A `tibble` with 129,696 rows and 58 variables:
#'   - `houseid`: Household Identifier
#'   - `travday`: Travel day - day of week
#'   - `sampstrat`: Primary Sampling Stratum Assignment
#'   - `homeown`: Home Ownership
#'   - `hhsize`: Count of household members
#'   - `hhvehcnt`: Count of household vehicles
#'   - `hhfaminc`: Household income
#'   - `pc`: Frequency of Desktop or Laptop Computer Use to Access the Internet
#'   - `sphone`: Frequency of Smartphone Use to Access the Internet
#'   - `tab`: Frequency of Tablet Use to Access the Internet
#'   - `walk`: Frequency of Walking for Travel
#'   - `bike`: Frequency of Bicycle Use for Travel
#'   - `car`: Frequency of Personal Vehicle Use for Travel
#'   - `taxi`: Frequency of Taxi Service or Rideshare Use for Travel
#'   - `bus`: Frequency of Bus Use for Travel
#'   - `train`: Frequency of Train Use for Travel
#'   - `para`: Frequency of Paratransit Use for Travel
#'   - `price`: Price of Gasoline Affects Travel
#'   - `place`: Travel is a Financial Burden
#'   - `walk2save`: Walk to Reduce Financial Burden of Travel
#'   - `bike2save`: Bicycle to Reduce Financial Burden of Travel
#'   - `ptrans`: Public Transportation to Reduce Financial Burden of Travel
#'   - `hhrelatd`: At least two household persons are related
#'   - `drvrcnt`: Number of drivers in household
#'   - `cnttdhh`: Count of household trips on travel day
#'   - `hhstate`: Household state
#'   - `hhstfips`: State FIPS for household address
#'   - `numadlt`: Count of adult household members at least 18 years old
#'   - `youngchild`: Count of persons with an age between 0 and 4 in household
#'   - `wrkcount`: Number of workers in household
#'   - `tdaydate`: Date of travel day (YYYYMM)
#'   - `hhresp`: Person identifier of household respondent
#'   - `lif_cyc`: Life Cycle classification for the household, derived by attributes pertaining to age, relationship, and work status.
#'   - `msacat`: Metropolitan Statistical Area (MSA) category for the household's home address, based on household's home geocode and TIGER/Line Shapefiles.
#'   - `msasize`: Population size category of the Metropolitan Statistical Area (MSA), from the 2010-2014 five-year American Community Survey (ACS) API.
#'   - `rail`: MSA heavy rail status for household
#'   - `urban`: Household's urban area classification, based on home address and 2014 TIGER/Line Shapefile
#'   - `urbansize`: Urban area size where home address is located
#'   - `urbrur`: Household in urban/rural area
#'   - `scresp`: Person identifier of mail screener respondent, always 1 to roster self first
#'   - `census_d`: 2010 Census division classification for the respondent's home address
#'   - `census_r`: Census region classification for home address
#'   - `cdivmsar`: Grouping of household by combination of census division, MSA status, and presence of a subway system when population greater than 1 million
#'   - `hh_race`: Race of household respondent
#'   - `hh_hisp`: Hispanic status of household respondent
#'   - `hh_cbsa`: Core Based Statistical Area (CBSA) FIPS code for the respondent's home address
#'   - `resp_cnt`: Count of responding persons per household
#'   - `webuse17`: Frequency of internet use
#'   - `smplsrce`: Sample where the case originated
#'   - `wthhfin`: Final HH weight
#'   - `hbhur`: Urban / Rural indicator -  Block group
#'   - `hthtnrnt`: Category of the percent of renter-occupied housing in the census tract of the household's home location.
#'   - `htppopdn`: Category of population density (persons per square mile) in the census tract of the household's home location.
#'   - `htresdn`: Category of housing units per square mile in the census tract of the household's home location.
#'   - `hteempdn`: Category of workers per square mile in the census tract of the household's home location.
#'   - `hbhtnrnt`: Category of the percent of renter-occupied housing in the census block group of the household's home location.
#'   - `hbppopdn`: Category of population density (persons per square mile) in the census block group of the household's home location.
#'   - `hbresdn`: Category of housing units per square mile in the census block group of the household's home location.
#'
"nhts_households"


#' Public Person Records
#'
#' A dataset containing person records for
#'
#' @format A `tibble` with 264,234 rows and 87 variables:
#'   - `houseid`: Household Identifier
#'   - `personid`: Person Identifier
#'   - `r_age`: Age
#'   - `educ`: Educational Attainment
#'   - `r_hisp`: Hispanic or Latino Origin
#'   - `r_relat`: Relationship
#'   - `r_sex`: Gender
#'   - `r_race`: Race
#'   - `prmact`: Primary Activity in Previous Week
#'   - `payprof`: Work for Pay in Previous Week
#'   - `gt1jblwk`: More than One Job
#'   - `wrk_home`: Work from Home
#'   - `wkftpt`: Full-Time or Part-Time Worker
#'   - `wrktrans`: Mode to Work
#'   - `lsttrday17`: Last trip before travel day
#'   - `occat`: Job Category
#'   - `schtyp`: Student Status
#'   - `nwalktrp`: Count of Walk Trips
#'   - `walk4ex`: Count of Walk Trips for Exercise
#'   - `nbiketrp`: Count of Bike Trips
#'   - `bike4ex`: Count of Bike Trips for Exercise
#'   - `bikeshare`: Count of Bike Share Program Usage
#'   - `ptused`: Count of Public Transit Usage
#'   - `mcused`: Count of Motorcycle or Moped Trips
#'   - `carshare`: Count of Car Share Program Usage
#'   - `rideshare`: Count of Rideshare App Usage
#'   - `carrode`: Count of People in Vehicle to Work
#'   - `timetowk`: Trip Time to Work in Minutes
#'   - `nocong`: Trip Time in Minutes to Work without Traffic
#'   - `pubtime`: Minutes Spent Transferring to Work
#'   - `wrktime`: Arrival Time at Work
#'   - `wkrmhm`: Option of Working from Home
#'   - `flextime`: Flex Time
#'   - `wkfmhmxx`: Count of Days Worked From Home in Last Month
#'   - `schtrn1`: Mode to School
#'   - `schtrn2`: Mode from School
#'   - `deliver`: Count of Times Purchased Online for Delivery in Last 30 Days
#'   - `medcond`: Medical Condition
#'   - `medcond6`: Medical Condition, How Long
#'   - `health`: Opinion of Health
#'   - `phyact`: Level of Physical Activity
#'   - `vpact`: Count of Times of Vigorous Physical Activity in Past Week
#'   - `lpact`: Count of Times of Light or Moderate Physical Activity in Past Week
#'   - `borninus`: Born in United States
#'   - `yrtous`: Year of Arrival in United States
#'   - `yearmile`: Miles Personally Driven in all Vehicles
#'   - `proxy`: Trip info from respondent or proxy
#'   - `whoproxy`: Household Person Identifier Responsible for Trip Reporting
#'   - `usepubtr`: Public Transit Usage on Travel Date, derived
#'   - `sameplc`: Reason for No Trips
#'   - `w_none`: Medical Device Used: None
#'   - `w_cane`: Medical Device Used: Cane
#'   - `w_wlkr`: Medical Device Used: Walker
#'   - `w_whcane`: Medical Device Used: White Cane
#'   - `w_dog`: Medical Device Used: Dog Assistance
#'   - `w_crutch`: Medical Device Used: Crutches
#'   - `w_scootr`: Medical Device Used: Motorized Scooter
#'   - `w_chair`: Medical Device Used: Wheelchair
#'   - `w_mtrchr`: Medical Device Used: Motorized Wheelchair
#'   - `worker`: Worker status
#'   - `diary`: Travel Diary completion status
#'   - `outcntry`: Respondent was out of the country on travel day.
#'   - `frsthm17`: Travel day began at home location
#'   - `cnttdtr`: Count of person trips on travel day
#'   - `gcdwork`: Minimum geodesic (Great Circle) distance between home location and work location in meters, using WGS84 coordinate system
#'   - `wkstfips`: The state FIPS code for the respondent's geocoded work address. The state FIPS codes were identified using United States Census Bureau 2016 TIGER/Line Shapefiles.
#'   - `driver`: Driver status, derived
#'   - `outoftwn`: Away from home for entire travel day
#'   - `disttowk17`: Road network distance, in miles, between respondent's home location and work location, sourced using Google Distance Matrix API (https://maps.googleapis.com/maps/api/distancematrix/)
#'   - `disttosc17`: Road network distance, in miles, between respondent's home location and school location, sourced using Google Distance Matrix API (https://maps.googleapis.com/maps/api/distancematrix/)
#'   - `r_age_imp`: Age (imputed)
#'   - `r_sex_imp`: Gender (imputed)
#'   - `alt_16`: Alternative Mode of Transportation: Public Transportation or Taxi
#'   - `alt_23`: Alternative Mode of Transportation: Passenger to Friend/Family Member or Rental Car
#'   - `alt_45`: Alternative Mode of Transportation: Bicycle or Walk
#'   - `walk_def`: Reason for Not Walking More: Infrastructure
#'   - `walk_gkq`: Reason for Not Walking More: Safety
#'   - `bike_dfr`: Reason for Not Biking More: Infrastructure
#'   - `bike_gkp`: Reason for Not Biking More: Safety
#'   - `condtrav`: Medical Condition Results in Reduced Day-to-Day Travel
#'   - `condride`: Medical Condition Results in Asking Others for Rides
#'   - `condnigh`: Medical Condition Results in Limiting Driving to Daytime
#'   - `condrive`: Medical Condition Results in Giving up Driving
#'   - `condpub`: Medical Condition Results in Using Bus or Subway Less Frequently
#'   - `condspec`: Medical Condition Results in Using Special Transportation Services
#'   - `condtax`: Medical Condition Results in Using a Reduced Fare Taxi
#'   - `wtperfin`: Final Person weight
#'
"nhts_persons"


#' Public Vehicle Records
#'
#' A dataset containing vehicle records from the 2017 National Household
#' Travel Survey
#'
#' @format A `tibble` with 256,115 rows and 20 variables:
#'   - `houseid` :Household Identifier
#'   - `vehid` :Vehicle Identifier
#'   - `vehyear` :Vehicle Year
#'   - `vehage` :Age of vehicle, based on model year
#'   - `make` :Vehicle Make
#'   - `model` :Vehicle Model
#'   - `fueltype` :Fuel Type
#'   - `vehtype` :Vehicle Type
#'   - `whomain` :Vehicle Main Driver
#'   - `od_read` :Odometer Reading
#'   - `hfuel` :Type of Hybrid Vehicle
#'   - `vehowned` :Owned Vehicle Longer than a Year
#'   - `vehownmo` :Months of Vehicle Ownership
#'   - `annmiles` :Self-reported annualized mile estimate
#'   - `hybrid` :Hybrid vehicle
#'   - `personid` :Person ID of Main Driver of this vehicle
#'   - `bestmile` :Best estimate of annual miles
#'   - `best_flg` :How BESTMILE was computed
#'   - `best_edt` :Flag any edits/adjustments to BESTMILE
#'   - `best_out` :Flag identifying BESTMILE outlier values
#'
"nhts_vehicles"

#' Public Trip Records
#'
#' A dataset containing trip records for
#'
#' @format A `tibble` with 923,572 rows and 82 variables:
#'   - `houseid`: Household Identifier
#'   - `personid`: Person Identifier
#'   - `trvlcmin`: Trip Duration in Minutes
#'   - `trpmiles`: Trip distance in miles, derived from route geometry returned by Google Maps API, or from reported loop-trip distance
#'   - `trptrans`: Trip Mode, derived
#'   - `trpaccmp`: Count of People on Trip
#'   - `trphhacc`: Count of Household Members on Trip
#'   - `vehid`: Household Vehicle Identifier Used on Trip
#'   - `trwaittm`: Transit wait time in minutes
#'   - `numtrans`: Count of Transfers
#'   - `tracctm`: Trip Time to Transit Station in Minutes
#'   - `drop_prk`: Parked or Dropped Off at Station
#'   - `tregrtm`: Time to Destination from Transit in Minutes
#'   - `whodrove`: Person Identifier Who Drove on Trip
#'   - `whyfrom`: Trip Origin Purpose
#'   - `loop_trip`: Trip origin and destination at identical location
#'   - `trphhveh`: Household Vehicle Used on Trip
#'   - `hhmemdrv`: Household member drove on trip
#'   - `hh_ontd`: Number of household members on trip including respondent
#'   - `nonhhcnt`: Number of non-household members on trip
#'   - `numontrp`: Number of people on trip including respondent
#'   - `psgr_flg`: Respondent was passenger on trip
#'   - `pubtrans`: Public transportation used on trip
#'   - `trippurp`: Generalized purpose of trip, home-based and non-home based
#'   - `dweltime`: Time at destination
#'   - `tdwknd`: Weekend trip
#'   - `vmt_mile`: Trip distance in miles for personally driven vehicle trips, derived from route geometry returned by Google Maps API
#'   - `drvr_flg`: Respondent drove on trip
#'   - `whytrp1s`: Trip purpose summary
#'   - `ontd_p1`: Household Person Identifier on Trip: 1
#'   - `ontd_p2`: Household Person Identifier on Trip: 2
#'   - `ontd_p3`: Household Person Identifier on Trip: 3
#'   - `ontd_p4`: Household Person Identifier on Trip: 4
#'   - `ontd_p5`: Household Person Identifier on Trip: 5
#'   - `ontd_p6`: Household Person Identifier on Trip: 6
#'   - `ontd_p7`: Household Person Identifier on Trip: 7
#'   - `ontd_p8`: Household Person Identifier on Trip: 8
#'   - `ontd_p9`: Household Person Identifier on Trip: 9
#'   - `ontd_p10`: Household Person Identifier on Trip: 10
#'   - `ontd_p11`: Household Person Identifier on Trip: 11
#'   - `ontd_p12`: Household Person Identifier on Trip: 12
#'   - `ontd_p13`: Household Person Identifier on Trip: 13
#'   - `tdcaseid`: Unique identifier for every trip record in the file
#'   - `tracc_wlk`: Walk as mode used to get to public transit?
#'   - `tracc_pov`: POV as mode used to get to public transit?
#'   - `tracc_bus`: Bus as mode used to get to public transit?
#'   - `tracc_crl`: Rail as mode used to get to public transit?
#'   - `tracc_sub`: Subway as mode used to get to public transit?
#'   - `tracc_oth`: Other mode used to get to public transit?
#'   - `tregr_wlk`: Walk as mode used to get from public transit?
#'   - `tregr_pov`: POV as mode used to get from public transit?
#'   - `tregr_bus`: Bus as mode used to get from public transit?
#'   - `tregr_crl`: Rail as mode used to get from public transit?
#'   - `tregr_sub`: Subway as mode used to get from public transit?
#'   - `tregr_oth`: Other mode used to get from public transit?
#'   - `whyto`: Trip Destination Purpose
#'   - `gasprice`: Price of gasoline, in cents, on respondent's travel day
#'   - `wttrdfin`: Final trip weight
#'   - `whytrp90`: Travel day trip purpose consistent with 1990 NPTS design.
#'
"nhts_trips"
