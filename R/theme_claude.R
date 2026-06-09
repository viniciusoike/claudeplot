# Theme ----

#' Anthropic and Claude inspired ggplot2 theme
#'
#' A clean, publication-ready theme modelled on the data visualizations in
#' Anthropic's model reports: a light background, light horizontal grid lines,
#' strong black axis lines, a bold geometric-sans title (Poppins), and a serif
#' subtitle (Lora). Custom fonts render on `ragg`/`svglite` devices; when the
#' bundled fonts are unavailable the theme falls back to generic families.
#'
#' @param base_size Base font size in points.
#' @param font_title Family for the plot title. Defaults to Poppins (with a
#'   `"sans"` fallback).
#' @param font_text Family for axis, legend, and other text. Defaults to
#'   Poppins (with a `"sans"` fallback).
#' @param font_subtitle Family for the subtitle and caption. Defaults to Lora
#'   (with a `"serif"` fallback).
#' @param grid Which major grid lines to draw: `"y"` (default), `"x"`, `"xy"`,
#'   or `"none"`.
#' @param axis_lines Logical; draw strong axis lines and ticks on the left and
#'   bottom? Defaults to `TRUE`.
#' @param background Panel and plot background fill. Use `"white"` (default) or
#'   `"cloud"` for Anthropic's warm off-white, or any color string.
#' @param ... Passed to [ggplot2::theme_minimal()].
#'
#' @return A ggplot2 theme object.
#' @details
#' The bundled Poppins and Lora fonts only render on `ragg` or `svglite`
#' devices. On the base PDF/PostScript device (used by `R CMD check`) custom
#' fonts are unavailable, so the examples below pass generic families. In your
#' own work, omit the `font_*` arguments to use the Anthropic typefaces and
#' save with a `ragg` device, e.g.
#' `ggsave("plot.png", device = ragg::agg_png)`.
#' @examples
#' library(ggplot2)
#'
#' # Generic fonts keep the example device-agnostic.
#' ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'   geom_point(size = 3) +
#'   labs(
#'     title = "Fuel efficiency by weight",
#'     subtitle = "Heavier cars travel fewer miles per gallon",
#'     color = "Cylinders"
#'   ) +
#'   scale_color_claude_d() +
#'   theme_claude(font_title = "sans", font_text = "sans", font_subtitle = "serif")
#'
#' \dontrun{
#' # With the bundled Anthropic fonts (requires systemfonts + a ragg device):
#' ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'   geom_point(size = 3) +
#'   theme_claude()
#' }
#' @export
theme_claude <- function(base_size = 12,
                         font_title = "Poppins",
                         font_text = "Poppins",
                         font_subtitle = "Lora",
                         grid = c("y", "x", "xy", "none"),
                         axis_lines = TRUE,
                         background = "white",
                         ...) {
  grid <- match.arg(grid)
  if (!is.logical(axis_lines) || length(axis_lines) != 1) {
    cli::cli_abort("{.arg axis_lines} must be a single {.cls logical} value.")
  }

  # Resolve fonts with graceful fallback ----
  font_title <- claude_resolve_font(font_title, "sans")
  font_text <- claude_resolve_font(font_text, "sans")
  font_subtitle <- claude_resolve_font(font_subtitle, "serif")

  # Colors ----
  bg <- switch(
    background,
    white = claude_colors[["white"]],
    cloud = claude_colors[["cloud"]],
    background
  )
  ink <- claude_colors[["dark"]]
  grid_col <- claude_colors[["light_gray"]]
  text_col <- claude_colors[["slate"]]
  muted_col <- claude_colors[["graphite"]]

  # Grid lines ----
  grid_y <- if (grid %in% c("y", "xy")) {
    ggplot2::element_line(color = grid_col, linewidth = 0.4)
  } else {
    ggplot2::element_blank()
  }
  grid_x <- if (grid %in% c("x", "xy")) {
    ggplot2::element_line(color = grid_col, linewidth = 0.4)
  } else {
    ggplot2::element_blank()
  }

  # Axis lines ----
  axis_theme <- if (axis_lines) {
    ggplot2::theme_sub_axis(
      line = ggplot2::element_line(color = ink, linewidth = 0.8),
      ticks = ggplot2::element_line(color = ink, linewidth = 0.8),
      ticks.length = ggplot2::unit(5, "pt")
    )
  } else {
    ggplot2::theme_sub_axis(
      line = ggplot2::element_blank(),
      ticks = ggplot2::element_blank()
    )
  }

  # Assemble ----
  ggplot2::theme_minimal(base_size = base_size, base_family = font_text, ...) %+replace%
    ggplot2::theme(
      text = ggplot2::element_text(family = font_text, color = text_col),
      plot.background = ggplot2::element_rect(fill = bg, color = NA),
      panel.background = ggplot2::element_rect(fill = bg, color = NA),
      panel.grid.major.y = grid_y,
      panel.grid.major.x = grid_x,
      panel.grid.minor = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(
        family = font_title, face = "bold", size = ggplot2::rel(1.45),
        color = ink, hjust = 0, margin = ggplot2::margin(b = 4)
      ),
      plot.subtitle = ggplot2::element_text(
        family = font_subtitle, size = ggplot2::rel(1.0),
        color = muted_col, hjust = 0, margin = ggplot2::margin(b = 10)
      ),
      plot.caption = ggplot2::element_text(
        family = font_subtitle, size = ggplot2::rel(0.7),
        color = muted_col, hjust = 1, margin = ggplot2::margin(t = 8)
      ),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      plot.margin = ggplot2::margin(14, 16, 12, 14),
      axis.title = ggplot2::element_text(size = ggplot2::rel(0.9), color = text_col),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 6)),
      axis.title.y = ggplot2::element_text(
        angle = 90, margin = ggplot2::margin(r = 6)
      ),
      axis.text = ggplot2::element_text(size = ggplot2::rel(0.85), color = text_col),
      legend.position = "top",
      legend.justification = "left",
      legend.title = ggplot2::element_text(size = ggplot2::rel(0.9), color = text_col),
      legend.text = ggplot2::element_text(size = ggplot2::rel(0.85), color = text_col),
      legend.key = ggplot2::element_blank(),
      legend.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(
        family = font_text, face = "bold", size = ggplot2::rel(0.9), color = ink
      )
    ) +
    axis_theme
}
