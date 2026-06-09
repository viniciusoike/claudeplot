# Display all available claudeplot palettes

Draws every palette (optionally filtered by type) as a stacked grid of
color swatches.

## Usage

``` r
show_claude_palettes(type = c("all", "qualitative", "sequential", "diverging"))
```

## Arguments

- type:

  One of `"all"`, `"qualitative"`, `"sequential"`, or `"diverging"`.

## Value

A ggplot object (invisibly), drawn as a side effect.

## See also

[`show_claude_palette()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palette.md)
to display one palette in detail.

## Examples

``` r
show_claude_palettes()

show_claude_palettes("sequential")
```
