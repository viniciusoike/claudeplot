# Theme ----

test_that("theme_claude returns a complete ggplot2 theme", {
  t <- theme_claude()
  expect_s3_class(t, "theme")
  expect_true(attr(t, "complete"))
})

test_that("theme_claude honors grid argument", {
  none <- theme_claude(grid = "none")
  expect_s3_class(none$panel.grid.major.y, "element_blank")
  expect_s3_class(none$panel.grid.major.x, "element_blank")

  xy <- theme_claude(grid = "xy")
  expect_s3_class(xy$panel.grid.major.x, "element_line")
})

test_that("theme_claude validates arguments", {
  expect_error(theme_claude(grid = "diagonal"))
  expect_error(theme_claude(axis_lines = "yes"), "logical")
})

test_that("background option sets fills", {
  cloud <- theme_claude(background = "cloud")
  expect_identical(cloud$plot.background$fill, unname(claude_colors[["cloud"]]))
})

test_that("a full plot with theme and scale builds", {
  p <- ggplot2::ggplot(
    mtcars, ggplot2::aes(wt, mpg, color = factor(cyl))
  ) +
    ggplot2::geom_point() +
    scale_color_claude_d() +
    theme_claude()
  built <- ggplot2::ggplot_build(p)
  expect_s3_class(built, "ggplot_built")
})
