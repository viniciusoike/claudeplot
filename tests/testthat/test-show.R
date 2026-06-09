# Palette display ----

test_that("show_claude_palette returns a ggplot invisibly", {
  p <- expect_invisible(show_claude_palette("claude"))
  expect_s3_class(p, "ggplot")
})

test_that("show_claude_palettes returns a ggplot invisibly", {
  p <- expect_invisible(show_claude_palettes("sequential"))
  expect_s3_class(p, "ggplot")
})

test_that("show helpers validate type", {
  expect_error(show_claude_palettes("rainbow"))
})
