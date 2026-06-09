# Colors and palettes ----

test_that("claude_colors exposes named brand colors", {
  expect_type(claude_colors, "character")
  expect_true(all(c("dark", "orange", "viz_green") %in% names(claude_colors)))
  expect_match(claude_colors[["orange"]], "^#[0-9A-Fa-f]{6}$")
})

test_that("claude_palette_names lists palettes by type", {
  expect_true("claude" %in% claude_palette_names())
  expect_true(all(claude_palette_names("sequential") %in%
    c("oranges", "blues", "greens", "grays")))
  expect_false("claude" %in% claude_palette_names("sequential"))
})

test_that("claude_pal returns the right number of colors", {
  expect_length(claude_pal("claude", n = 3), 3)
  expect_length(claude_pal("oranges", n = 12, type = "continuous"), 12)
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", claude_pal("brand"))))
})

test_that("claude_pal reverse flips order", {
  expect_identical(
    claude_pal("claude", reverse = TRUE),
    rev(claude_pal("claude"))
  )
})

test_that("claude_pal errors on unknown palette", {
  expect_error(claude_pal("not_a_palette"), "not found")
})

test_that("requesting too many discrete colors warns and recycles", {
  expect_warning(out <- claude_pal("warm", n = 99), "Recycling")
  expect_length(out, 99)
})

test_that("claude_palette builds a printable object", {
  pal <- claude_palette("claude")
  expect_s3_class(pal, "claude_palette")
  expect_identical(as.character(pal), unname(claude_pal("claude")))
  expect_identical(attr(pal, "palette"), "claude")
})
