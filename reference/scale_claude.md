# Claude color and fill scales for ggplot2

Discrete (`_d`) and continuous (`_c`) color and fill scales built from
the claudeplot palettes. The British spelling (`colour`) aliases are
provided for every American (`color`) scale.

## Usage

``` r
scale_color_claude_d(palette = "claude", reverse = FALSE, ...)

scale_colour_claude_d(palette = "claude", reverse = FALSE, ...)

scale_fill_claude_d(palette = "claude", reverse = FALSE, ...)

scale_color_claude_c(palette = "oranges", reverse = FALSE, ...)

scale_colour_claude_c(palette = "oranges", reverse = FALSE, ...)

scale_fill_claude_c(palette = "oranges", reverse = FALSE, ...)
```

## Arguments

- palette:

  Name of a palette. Discrete scales default to `"claude"` (the vivid
  benchmark palette); continuous scales default to `"oranges"`. See
  [`claude_palette_names()`](https://viniciusoike.github.io/claudeplot/reference/claude_palette_names.md).

- reverse:

  Logical; reverse the palette order?

- ...:

  Passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html),
  [`ggplot2::scale_color_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html),
  or
  [`ggplot2::scale_fill_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A ggplot2 scale object.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg, color = factor(gear))) +
  geom_point() +
  scale_color_claude_d()


ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_fill_claude_c(palette = "blues")
```
