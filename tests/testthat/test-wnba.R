test_that("map_WNBA_teams() produces a ggplot object", {
  plot <- map_WNBA_teams()
  expect_s3_class(plot, "ggplot")
})
