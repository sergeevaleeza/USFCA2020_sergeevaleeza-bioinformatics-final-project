# script to gain inside knowledge of the data for all US states
# using dplyr package to get number of total deaths by state 
# and save it as .csv file

# Leeza Sergeeva
# esergeeva@dons.usfca.edu
# 2020-11-29

# load the package "dplyr"

state_covid_death <- function() {
  # import new data as .csv from website API
  covid_tracking_data <- readr::read_csv("https://api.covidtracking.com/v1/states/daily.csv")
  
  # dplyr chians, get summary for state date mobility grouped by geo_type and
  # transportation_type as a table.
  state_death_summary <- covid_tracking_data %>%
    select(date, state, death, positive, negative, totalTestResults)
    tally()
  
  # number of total deaths by state
  total_state_death <- aggregate(death~state, state_death_summary, sum)
  names(total_state_death)[2] <- 'total_death'
  
  # reorder data to show the states with the most deaths first
  total_state_death_ordered <- total_state_death[
    order(total_state_death$total_death, decreasing=TRUE), ]
  
  
  # save table of Covid-19 total deaths by state as a .csv file
  readr::write_csv(total_state_death_ordered,
                   paste0("data/metadata/total_state_death_ordered.csv"))
  
  return(total_state_death_ordered)
}


#plot(death_total_plot$total_death)

#death_total_plot <- ggplot(data = total_state_death_ordered,
#                         aes(x = total_death,
#                             y = state)) +
#  scale_x_log10() +
#  geom_col() +
#  labs(title = "Number of Covid-19 Related Deaths by State",
#       x = "Total Deaths",
#       y = "State Name")
#
#ggsave(plot = death_total_plot,
#       filename = "data/images/death_total_plot.png")
#
#death_total_plot
