# Changelog

## claudeplot 0.2.0

### Theme

- [`theme_claude()`](https://viniciusoike.github.io/claudeplot/reference/theme_claude.md)
  gains an `axis_ticks` argument to draw axis ticks independently of
  `axis_lines` (defaults to `FALSE`).
- The theme is now built on the `theme_sub_*()` API introduced in
  ggplot2 4.0.0.
- Default legend position moved from `"top"` to `"bottom"`.
- Plot titles and subtitles are now centered (`hjust = 0.5`) rather than
  left-aligned.

### Colors and palettes

- Added two brand colors: `viz_indigo` and `viz_ochre`.
- Added two qualitative palettes: `editorial` (Claude’s themed survey
  charts) and `ochre_blue` (the ochre / steel-blue economic-report
  comparison charts).

### Documentation

- Vignettes migrated from R Markdown to Quarto and plotting dependencies
  switched to gground.
- Expanded the chart-replication gallery and regenerated figures.

## claudeplot 0.1.0

- Initial release.
- [`theme_claude()`](https://viniciusoike.github.io/claudeplot/reference/theme_claude.md):
  an Anthropic/Claude inspired ggplot2 theme.
- Discrete and continuous color/fill scales:
  [`scale_color_claude_d()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md),
  [`scale_colour_claude_d()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md),
  [`scale_fill_claude_d()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md),
  [`scale_color_claude_c()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md),
  [`scale_colour_claude_c()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md),
  [`scale_fill_claude_c()`](https://viniciusoike.github.io/claudeplot/reference/scale_claude.md).
- Color palettes
  ([`claude_pal()`](https://viniciusoike.github.io/claudeplot/reference/claude_pal.md),
  [`claude_palette()`](https://viniciusoike.github.io/claudeplot/reference/claude_palette.md))
  covering qualitative, sequential, and diverging families.
- Palette display helpers:
  [`show_claude_palette()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palette.md)
  and
  [`show_claude_palettes()`](https://viniciusoike.github.io/claudeplot/reference/show_claude_palettes.md).
- Bundled Poppins and Lora typefaces, registered automatically via
  `systemfonts`; diagnose with
  [`claude_font_status()`](https://viniciusoike.github.io/claudeplot/reference/claude_font_status.md).
