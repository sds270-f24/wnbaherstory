utils::globalVariables(c("All_Game_Attendance", "Home Team", "Year", "Attendance", "Average_Attendance"))
#' Function graphs a WNBA team attendance record over the years
#' @author Alina Abdulina
#' @param team string containing the name of the team
#' @return graph
#' @source <https://www.acrossthetimeline.com/wnba/data.html#>
#' @export
#' @examples
#' plot_wnba_attendance("Los Angeles Sparks")

plot_wnba_attendance <- function(team) {
  
  # Step 1: Filter the data set for the chosen team
  team_data <- All_Game_Attendance |>
    dplyr::filter(`Home Team` == team)
  
  # Step 2: Calculate the average attendance for each year
  avg_attendance <- team_data |>
    dplyr::group_by(Year) |>
    dplyr::summarise(Average_Attendance = mean(Attendance, na.rm = TRUE))
  
  # Step 3: Plot the average attendance for the specified team over time
  ggplot2::ggplot(data = avg_attendance, 
                  ggplot2::aes(x = Year,
                               y = Average_Attendance)) +
    ggplot2::geom_line(color = "purple1") +
    ggplot2::labs(title = paste("Attendance Trends for", team),
                  x = "Year",
                  y = "Average Attendance Per Year") +
    ggplot2::theme_minimal()
  
}


