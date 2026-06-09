# List available claudeplot palettes

List available claudeplot palettes

## Usage

``` r
claude_palette_names(type = c("all", "qualitative", "sequential", "diverging"))
```

## Arguments

- type:

  One of `"all"`, `"qualitative"`, `"sequential"`, or `"diverging"`.

## Value

A character vector of palette names (invisible side effects: none).

## Examples

``` r
claude_palette_names()
#>  [1] "claude"       "brand"        "warm"         "cool"         "neutral"     
#>  [6] "oranges"      "blues"        "greens"       "grays"        "orange_blue" 
#> [11] "green_orange" "spectral"    
claude_palette_names("sequential")
#> [1] "oranges" "blues"   "greens"  "grays"  
```
