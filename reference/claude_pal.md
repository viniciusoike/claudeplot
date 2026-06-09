# Generate colors from a claudeplot palette

Low-level palette generator used internally by the scale functions. Most
users will prefer
[`claude_palette()`](https://viniciusoike.github.io/claudeplot/reference/claude_palette.md)
(which returns a printable object) or the `scale_*_claude_*()`
functions.

## Usage

``` r
claude_pal(
  palette = "claude",
  n = NULL,
  type = c("discrete", "continuous"),
  reverse = FALSE
)
```

## Arguments

- palette:

  Name of a palette. See
  [`claude_palette_names()`](https://viniciusoike.github.io/claudeplot/reference/claude_palette_names.md).

- n:

  Number of colors to return. Defaults to the full palette for discrete
  palettes, or all anchor colors for continuous palettes.

- type:

  Either `"discrete"` or `"continuous"`. For `"continuous"`, colors are
  interpolated with
  [`grDevices::colorRampPalette()`](https://rdrr.io/r/grDevices/colorRamp.html).

- reverse:

  Logical; reverse the color order?

## Value

A character vector of hex colors.

## Examples

``` r
claude_pal("claude", n = 3)
#> [1] "#1CA672" "#2C71D6" "#E96B9E"
claude_pal("oranges", n = 9, type = "continuous")
#> [1] "#FAF9F5" "#F3DCCF" "#ECBFAA" "#E3A185" "#DD896A" "#D27151" "#B45436"
#> [8] "#923E23" "#6E2D17"
```
