# Fonts ----

test_that("claude_font_status returns a logical list invisibly", {
  out <- expect_invisible(claude_font_status())
  expect_named(out, c("poppins", "lora", "systemfonts", "ragg"))
  expect_type(out$poppins, "logical")
})

test_that("claude_resolve_font falls back when unavailable", {
  expect_identical(claude_resolve_font("DefinitelyNotAFont123", "sans"), "sans")
})

test_that("bundled font files ship with the package", {
  font_dir <- system.file("fonts", package = "claudeplot")
  skip_if(!nzchar(font_dir))
  expect_true(file.exists(file.path(font_dir, "poppins", "Poppins-Regular.ttf")))
  expect_true(file.exists(file.path(font_dir, "lora", "Lora-Regular.ttf")))
})
