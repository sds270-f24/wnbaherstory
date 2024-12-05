## code to prepare `All Game Attendance.csv` dataset goes here
#' All Game Attendance Data
#'
#' This data set contains information about the attendance of all games in a certain season or series.
#' It includes columns such as game date, attendance numbers, and other related statistics.
#' @import readr
#' @docType data
#' @usage data(All_Game_Attendance)
#' @format A data frame with 6214 rows and 13 variables:
#' \describe{
#'    \item{Year}{Integer. The year the teams played.}
#'    \item{Day of Week}{Factor. The day of the week the teams played.}
#'    \item{Month}{Factor. The month the teams played.}
#'    \item{Day}{Integer. Day of the week the teams played.}
#'    \item{Time(ET)}{The time the game was played at.}
#'    \item{Game Type}{Factor. The game is classified either as regular season, Seminfinals, Finals, Eastern Conference Semifinals etc.}
#'    \item{Home Team}{Fcator. Name of the home team.}
#'    \item{Away Team}{Factor. Name of the away team.}
#'    \item{Arena}{Factor. Name of the arena the game was played at.}
#'    \item{City}{Factor. Name of the city the game was played at.}
#'    \item{State}{Factor. Name of the State the game was played at.}
#'    \item{Attendance}{Integer. Number of people who attended the game.}
#' }
#' @source <https://www.acrossthetimeline.com/wnba/data.html#>
"All_Game_Attendance"


All_Game_Attendance <- readr::read_csv("All Game Attendance.csv")

usethis::use_data(All_Game_Attendance, overwrite = TRUE)

