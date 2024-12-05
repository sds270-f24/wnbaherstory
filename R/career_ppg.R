utils::globalVariables(c("Year", "PTS"))
#' Function shows career PPG of top WNBA scorers
#' 
#' @description This function scrapes career points per game (PPG) data for specified WNBA players from Basketball Reference and returns an interactive plot showing points scored over the years.
#' @author Jane Loo
#' @details This function fetches career points (PTS) and year (Year) data for top WNBA players, converts the data to numeric, and visualizes it using an interactive plot.
#' @param players the first and last name of WNBA player(s)
#' @examples
#' career_ppg()
#' career_ppg("Diana Taurasi")
#' @return An interactive plot showing the career points scored by WNBA players over the years.
#' @import ggplot2
#' @import rvest
#' @import dplyr
#' @import plotly
#' @import RColorBrewer
#' @source <https://www.basketball-reference.com/wnba/players/>
#' @export

career_ppg <- function(players = NULL) {
  
  player_urls <- list(
    "Diana Taurasi" = "https://www.basketball-reference.com/wnba/players/t/tauradi01w.html",
    "Tina Charles" = "https://www.basketball-reference.com/wnba/players/c/charlti01w.html",
    "Tina Thompson" = "https://www.basketball-reference.com/wnba/players/t/thompti01w.html",
    "DeWanna Bonner" = "https://www.basketball-reference.com/wnba/players/b/bonnede01w.html",
    "Tamika Catchings" = "https://www.basketball-reference.com/wnba/players/c/catchta01w.html",
    "Candice Dupree" = "https://www.basketball-reference.com/wnba/players/d/dupreca01w.html",
    "Cappie Pondexter" = "https://www.basketball-reference.com/wnba/players/p/pondeca01w.html",
    "Sue Bird" = "https://www.basketball-reference.com/wnba/players/b/birdsu01w.html",
    "Candace Parker" = "https://www.basketball-reference.com/wnba/players/p/parkeca01w.html",
    "Nneka Ogwumike" = "https://www.basketball-reference.com/wnba/players/o/ogwumnn01w.html"
  )
  
  # If no players specified, use all players
  if (is.null(players)) {
    players <- names(player_urls)
  }
  
  # Scrape and process data for players
  all_data <- dplyr::bind_rows(lapply(players, function(player_name) {
    page <- rvest::read_html(player_urls[[player_name]])
    
    # Extract the tables
    stats_tables <- rvest::html_nodes(page, "table")
    
    # Extract the second table
    stats_table <- stats_tables[[2]] |>
      rvest::html_table(fill = TRUE) |>
      as.data.frame()
    
    # Extract only Year and PTS columns, convert to numeric
    data <- stats_table |>
      dplyr::select(Year, PTS) |>
      dplyr::mutate(
        Year = as.numeric(Year),  
        PTS = as.numeric(PTS),    
        Player = player_name      
      ) |>
      dplyr::filter(!is.na(Year), !is.na(PTS))  
    
    return(data)
  }))
  
  # Create the interactive plot
  plot <- plotly::plot_ly(
    data = all_data,
    x = ~Year,
    y = ~PTS,
    type = 'scatter',
    mode = 'lines+markers',
    text = ~paste(Player, "<br>Year: ", Year, "<br>PTS: ", PTS), 
    hoverinfo = 'text',
    marker = list(size = 8),
    color = ~Player,
    colors = RColorBrewer::brewer.pal(12, "Set3")
  )
  
  plot <- plot |>
    plotly::layout(
      title = "Points Over the Years",
      xaxis = list(title = "Year"),
      yaxis = list(title = "PTS"),
      showlegend = TRUE
    )
  
  return(plot)
}
