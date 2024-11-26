#' Function graphs a WNBA team attendance record over the years
#' @author Alina Abdulina
#' @param team string conatining the name of the team
#' @return graph
#' @import ggplot2
#' @import tidyverse
#' @source https://www.acrossthetimeline.com/wnba/data.html# 
#' @examples
#' plot_wnba_attendance("Los Angeles Sparks")

plot_wnba_attendance <- function(team) {
  
  # Step 1: Filter the dataset for the chosen team
  team_data <- All_Game_Attendance |>
    filter(home_team == team)
  
  # Step 2: Calculate the average attendance for each year
  avg_attendance <- team_data |>
    group_by(Year) |>
    summarise(Average_Attendance = mean(Attendance, na.rm = TRUE))
  
  # Step 3: Plot the average attendance for the specified team over time
  ggplot(data = avg_attendance, 
         aes(x = Year, 
             y = Average_Attendance)) +
    geom_line(color = "purple1") +
    labs(title = paste("Attendance Trends for", team),
         x = "Year",
         y = "Average Attendance Per Year") +
    theme_minimal()
  
}


