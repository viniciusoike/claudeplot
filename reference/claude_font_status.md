# Report claudeplot font status

Prints whether the bundled Anthropic typefaces (Poppins and Lora) are
available to render and whether the optional `ragg` and `systemfonts`
packages are installed. Useful for diagnosing why
[`theme_claude()`](https://viniciusoike.github.io/claudeplot/reference/theme_claude.md)
falls back to generic fonts.

## Usage

``` r
claude_font_status()
```

## Value

Invisibly, a named list with logical entries `poppins`, `lora`,
`systemfonts`, and `ragg`.

## Examples

``` r
claude_font_status()
#> 
#> ── claudeplot font status ──────────────────────────────────────────────────────
#> ✔ Poppins (headings): available
#> ✔ Lora (body/subtitle): available
#> ✔ systemfonts: installed
#> ✔ ragg: installed
#> ✔ `theme_claude()` will use Poppins and Lora automatically.
```
