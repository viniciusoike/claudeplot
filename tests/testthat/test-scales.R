# Scales ----

test_that("discrete scales are ggplot2 discrete scales", {
  expect_s3_class(scale_color_claude_d(), "ScaleDiscrete")
  expect_s3_class(scale_fill_claude_d(), "ScaleDiscrete")
  expect_identical(scale_color_claude_d()$aesthetics, "colour")
  expect_identical(scale_fill_claude_d()$aesthetics, "fill")
})

test_that("continuous scales are ggplot2 continuous scales", {
  expect_s3_class(scale_color_claude_c(), "ScaleContinuous")
  expect_s3_class(scale_fill_claude_c(), "ScaleContinuous")
})

test_that("colour aliases are identical to color versions", {
  expect_identical(scale_colour_claude_d, scale_color_claude_d)
  expect_identical(scale_colour_claude_c, scale_color_claude_c)
})

test_that("discrete scale palette function yields palette colors", {
  sc <- scale_color_claude_d(palette = "brand")
  expect_identical(sc$palette(3), claude_pal("brand", 3))
})

test_that("scales accept extra arguments", {
  sc <- scale_fill_claude_d(name = "Group")
  expect_identical(sc$name, "Group")
})
