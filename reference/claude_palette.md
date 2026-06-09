# Build a claudeplot palette object

Returns the colors of a palette as a `claude_palette` object, which
prints as a color swatch (via
[`scales::show_col()`](https://scales.r-lib.org/reference/show_col.html)).

## Usage

``` r
claude_palette(
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

A character vector of hex colors with class `claude_palette`.

## See also

[`show_claude_palette()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palette.md)
and
[`show_claude_palettes()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palettes.md)
for plots.

## Examples

``` r
claude_palette("claude")

#> claudeplot palette: claude (6 colors)
claude_palette("oranges", n = 9, type = "continuous")

#> claudeplot palette: oranges (9 colors)
```
