# Display a single claudeplot palette

Draws one palette as a row of labelled color swatches.

## Usage

``` r
show_claude_palette(
  palette = "claude",
  n = NULL,
  type = c("discrete", "continuous"),
  reverse = FALSE,
  labels = TRUE
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

- labels:

  Logical; overlay hex codes on each swatch?

## Value

A ggplot object (invisibly), drawn as a side effect.

## See also

[`show_claude_palettes()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palettes.md)
to display every palette at once.

## Examples

``` r
show_claude_palette("claude")

show_claude_palette("oranges", n = 7, type = "continuous")
```
