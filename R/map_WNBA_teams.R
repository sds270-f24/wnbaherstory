#' Function shows map of all WNBA teams past and present at any given time
#' 
#' @param year_range A numerical year range formatted as startyear:endyear
#' @author Jane Loo
#' @details Gives historical data of how WNBA teams have changed or moved over time. 
#' @examples
#' map_WNBA_teams(year_range = 2021:2024)
#' map_WNBA_teams(year_range = 1997:2024)
#' @return A US Map of all WNBA teams geographical location.
#' @import ggplot2
#' @source <https://www.basketball-reference.com/wnba/teams/>
#' @export

map_WNBA_teams <- function(year_range = 1997:2024) {
  # Adding global variables
  utils::globalVariables(c("From", "To", "City", "long", "lat", "group", "Team"))
  
  # Use rvest package to scrape 
  url <- "https://www.basketball-reference.com/wnba/teams/"
  website <- rvest::read_html(url)
  
  teams_data <- website |>
    rvest::html_node("table") |> 
    rvest::html_table()
  
  # Filter all teams based on specified year 
  teams_filtered <- teams_data |>
    dplyr::filter((From <= max(year_range)) & (To >= min(year_range)))
  
  # Match each city with each team (had to do it manually)
  match_cities <- data.frame(
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
             "Portland", "Sacramento")
  )
  
  teams_with_cities <- teams_filtered |>
    dplyr::left_join(match_cities, by = "Team")
  
  # Use geocode because I have no addresses
  coords <- teams_with_cities |>
    dplyr::distinct(City) |>
    tidygeocoder::geocode(city = City, method = 'osm')
  
  # Match team names with the coordinates provided by geocode
  teams_with_coordinates <- teams_with_cities |>
    dplyr::left_join(coords, by = "City")
  
  # Did not use :: for ggplot
  map <- map_data("state")
  
  ggplot(data = map, aes(x = long, y = lat)) +
    geom_polygon(aes(group = group), 
                 fill = "gray", color = "black") +
    geom_point(data = coords, 
               color = "blue", size = 3) + 
    geom_text(data = teams_with_coordinates, 
              aes(label = Team), 
              color = "blue", size = 3, vjust = -1) +  
    theme_minimal() +
    labs(title = "WNBA Teams by Location",
         subtitle = paste0("Years: ", min(year_range), " - ", max(year_range))) +
    theme(panel.grid.minor = element_blank(),
          panel.background = element_rect(fill = "white"))
  
}
