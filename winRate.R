#' Calculate the franchise history winning percentage of a WNBA team.
#'
#' @param team_name A string (either the city, the team name, or both) representing the name of the WNBA team.
#' @return A numeric vector of length 1, representing the winning percentage of the team. Returns NA if no games are found.
#' @author Ella Sylvester
#' @export
#' @source <https://www.basketball-reference.com>
#' @examples
#' winRate("Storm")
#' winRate("Seattle")
#' winRate("Seattle Storm")
winRate <- function(team_name) {
  # read the HTML from the basketball-reference WNBA page
  raw <- "https://www.basketball-reference.com/wnba/teams/"
  win_stats_html <- rvest::read_html(raw)
  win_data <- lapply(rvest::html_elements(win_stats_html, "table"), rvest::html_table)
  win_data <- dplyr::bind_rows(win_data)
  
  # filter by the team name
  team_data <- win_data |>
    dplyr::filter(stringr::str_detect(Team, stringr::regex(team_name, ignore_case = TRUE))) |>
    dplyr::distinct(Team, .keep_all = TRUE)
  
  # calculate total wins, losses and win rate
  total_wins <- sum(team_data$W, na.rm = TRUE)
  total_losses <- sum(team_data$L, na.rm = TRUE)
  total_games <- total_wins + total_losses
  rate <- if (total_games > 0) total_wins / total_games else NA
  return(rate * 100)