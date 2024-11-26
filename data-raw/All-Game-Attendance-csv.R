## code to prepare `All Game Attendance.csv` dataset goes here
#' @import readr
All_Game_Attendance <- readr::read_csv("All Game Attendance.csv")

usethis::use_data(All_Game_Attendance, overwrite = TRUE)


