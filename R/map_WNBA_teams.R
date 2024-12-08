utils::globalVariables(c("From", "To", "City", "long", "lat", "group", "Team"))

#' Function shows map of all WNBA teams past and present at any given time
#' @author Jane Loo
#' @details Gives historical data of how WNBA teams have changed or moved over time. 
#' @examples
#' map_WNBA_teams(year_range = 2023:2024)
#' @param year_range a desired time period of years, formatted as "firstyear:lastyear"
#' @return A US Map of all WNBA teams geographical location.
#' @import ggplot2
#' @import maps
#' @source <https://www.basketball-reference.com/wnba/teams/>
#' @export

map_WNBA_teams <- function(year_range = 1997:2024) {
  
  # using rvest to scrape data
  url <- "https://www.basketball-reference.com/wnba/teams/"
  website <- rvest::read_html(url)
  teams_data <- website |>
    rvest::html_node("table") |> 
    rvest::html_table()
  
  teams_filtered <- teams_data |>
    dplyr::filter((From <= max(year_range)) & (To >= min(year_range)))
  
  # manually matching teams to coordinates
  match_cities_coords <- data.frame(
    Team = c("Atlanta Dream", "Chicago Sky", "Connecticut Sun", "Orlando Miracle", 
             "Indiana Fever", "Los Angeles Sparks", "Minnesota Lynx", "New York Liberty", 
             "Phoenix Mercury", "Las Vegas Aces", "San Antonio Silver Stars", "Utah Starzz", 
             "Seattle Storm", "Dallas Wings", "Tulsa Shock", "Detroit Shock", "Washington Mystics",
             "Charlotte Sting", "Cleveland Rockers", "Houston Comets", "Miami Sol", 
             "Portland Fire", "Sacramento Monarchs"),
    City = c("Atlanta", "Chicago", "Uncasville", "Orlando", 
             "Indianapolis", "Los Angeles", "Minneapolis", "New York", 
             "Phoenix", "Las Vegas", "San Antonio", "Salt Lake City", 
             "Seattle", "Dallas", "Tulsa", "Detroit", "Washington, D.C.",
             "Charlotte", "Cleveland", "Houston", "Miami", 
             "Portland", "Sacramento"),
    lat = c(33.748997, 41.878113, 41.351778, 28.538336, 39.768403, 34.052235, 44.977753, 40.712776,
            33.448376, 36.169941, 29.424121, 40.760779, 47.606209, 32.776665, 36.149651, 35.222568, 42.331427,
            35.227085, 41.499320, 29.760427, 25.761680, 45.523064, 38.575764),
    long = c(-84.387985, -87.629799, -71.989244, -81.379234, -86.158043, -118.243683, -93.265015, -74.005974,
             -112.074036, -115.139832, -98.493629, -111.891045, -122.332071, -96.796989, -95.994026, -97.402468, -83.045753,
             -80.843127, -81.694360, -95.369804, -80.191790, -122.676483, -121.494400)
  )
  
  # merge filtered teams with city and coordinates data
  teams_with_coordinates <- teams_filtered |>
    dplyr::left_join(match_cities_coords, by = "Team")

  map <- map_data("state")
  
  ggplot(data = map, aes(x = long, y = lat)) +
    geom_polygon(aes(group = group), fill = "gray", color = "black") +
    geom_point(data = teams_with_coordinates, aes(x = long, y = lat), 
               color = "blue", size = 2) +
    geom_text(data = teams_with_coordinates, aes(label = Team), 
              color = "blue", size = 2, vjust = -1) +
    theme_minimal() +
    labs(title = "WNBA Teams by Location", 
         subtitle = paste0("Years: ", min(year_range), " - ", max(year_range))) +
    theme(panel.grid.minor = element_blank(), 
          panel.background = element_rect(fill = "white"))
}