# Anthropic and Claude brand colors

A named character vector of the core colors used across Anthropic's
brand and Claude's data-visualization style. Brand neutrals and accents
follow Anthropic's published brand guidelines; the vivid accents
(`viz_*`) match the saturated colors used in Claude's benchmark charts.

## Usage

``` r
claude_colors
```

## Format

A named character vector of hex color strings.

## Examples

``` r
claude_colors["orange"]
#>    orange 
#> "#D97757" 
unname(claude_colors[c("viz_green", "viz_blue", "viz_pink")])
#> [1] "#1CA672" "#2C71D6" "#E96B9E"
```
