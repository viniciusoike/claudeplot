# claudeplot 0.2.0

## Theme

* `theme_claude()` gains an `axis_ticks` argument to draw axis ticks
  independently of `axis_lines` (defaults to `FALSE`).
* The theme is now built on the `theme_sub_*()` API introduced in ggplot2 4.0.0.
* Default legend position moved from `"top"` to `"bottom"`.
* Plot titles and subtitles are now centered (`hjust = 0.5`) rather than
  left-aligned.

## Colors and palettes

* Added two brand colors: `viz_indigo` and `viz_ochre`.
* Added two qualitative palettes: `editorial` (Claude's themed survey charts)
  and `ochre_blue` (the ochre / steel-blue economic-report comparison charts).

## Documentation

* Vignettes migrated from R Markdown to Quarto and plotting dependencies
  switched to gground.
* Expanded the chart-replication gallery and regenerated figures.

# claudeplot 0.1.0

* Initial release.
* `theme_claude()`: an Anthropic/Claude inspired ggplot2 theme.
* Discrete and continuous color/fill scales: `scale_color_claude_d()`,
  `scale_colour_claude_d()`, `scale_fill_claude_d()`, `scale_color_claude_c()`,
  `scale_colour_claude_c()`, `scale_fill_claude_c()`.
* Color palettes (`claude_pal()`, `claude_palette()`) covering qualitative,
  sequential, and diverging families.
* Palette display helpers: `show_claude_palette()` and `show_claude_palettes()`.
* Bundled Poppins and Lora typefaces, registered automatically via
  `systemfonts`; diagnose with `claude_font_status()`.
