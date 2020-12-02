# script to gain inside knowledge of the data for all US states
# using dplyr package to get number of total deaths by state
# and save it as .csv file

# Leeza Sergeeva
# esergeeva@dons.usfca.edu
# 2020-11-29

# load the package "dplyr"

library(dplyr)
library(ggplot2)
library(grid)
require(grid)
#chosen_date <- "20201130"

state_covid_death <- function(chosen_date) {
  # import new data as .csv from website API
  covid_tracking_data <- readr::read_csv(
    "https://api.covidtracking.com/v1/states/daily.csv")
  
  # dplyr chains, extract date, state and death columns      
  state_death_summary <- covid_tracking_data %>%
    select(date, state, death)
  tally()
  
  # take the input date and select rows matching it     
  state_death_chosen_date <- state_death_summary %>%        
    dplyr::filter(`date` == chosen_date)
  
  # reorder data to show the states with the most deaths first 
  state_death_chosen_date_ordered <- state_death_chosen_date[
    order(state_death_chosen_date$death, decreasing=TRUE), ]
  
  # take top 10 states
  state_death_chosen_date_ten <- state_death_chosen_date_ordered %>%
    top_n(10)
  
  return(state_death_chosen_date_ten)
}
