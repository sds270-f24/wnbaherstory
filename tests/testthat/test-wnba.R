# Attendance test
test_that("plot_wnba_attendance returns a ggplot object", {
  team <- "Los Angeles Sparks"
  plot <- plot_wnba_attendance(team)
  expect_s3_class(plot, "ggplot")
})

# Career scoring test
test_that("career_ppg returns a plotly object", {
  plot <- career_ppg(players = c("Diana Taurasi", "Sue Bird"))
  expect_s3_class(plot, "plotly")
})

# Map test
test_that("map_WNBA_teams returns a ggplot object", {
  map <- map_WNBA_teams(year_range = 2010:2020)
  expect_s3_class(map, "ggplot")
})

# Win rate test
test_that("winRate calculates a numeric win percentage", {
  rate <- winRate(team_name = "Los Angeles Sparks")
  expect_type(rate, "double")
  expect_true(rate >= 0 && rate <= 100)
})
