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

all_state_covid_data <- function() {
  # import new data as .csv from website API
  covid_tracking_data <- readr::read_csv(
    "https://api.covidtracking.com/v1/states/daily.csv")
  # dplyr chains, extract date, state and death columns
  all_state_data <- covid_tracking_data %>%
    select(date, state, death, deathIncrease, positive, positiveIncrease,
           hospitalizedCumulative, hospitalizedIncrease)
  return(all_state_data)
}
