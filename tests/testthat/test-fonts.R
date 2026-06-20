# Fonts ----

test_that("claude_font_status returns a logical list invisibly", {
  out <- expect_invisible(claude_font_status())
  expect_named(out, c("poppins", "lora", "systemfonts", "ragg"))
  expect_type(out$poppins, "logical")
})

test_that("claude_resolve_font falls back when unavailable", {
  expect_identical(claude_resolve_font("DefinitelyNotAFont123", "sans"), "sans")
})

test_that("font matching is literal, not regex (OS-font-set safe)", {
  skip_if_not(claude_font_is_available("Poppins"))
  # A regex that matches "Poppins" under grepl() must not resolve as available,
  # so behaviour does not depend on the host OS's installed font set.
  expect_identical(claude_resolve_font("Pop.ins", "sans"), "sans")
})

test_that("bundled font files ship with the package", {
  font_dir <- system.file("fonts", package = "claudeplot")
  skip_if(!nzchar(font_dir))
  expect_true(file.exists(file.path(font_dir, "poppins", "Poppins-Regular.ttf")))
  expect_true(file.exists(file.path(font_dir, "lora", "Lora-Regular.ttf")))
})
