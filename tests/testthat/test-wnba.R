test_that("map_WNBA_teams() produces a ggplot object", {
  # Call the function with default parameters
  plot <- map_WNBA_teams()
  
  # Check that the output is a ggplot object
  expect_s3_class(plot, "ggplot")
})
