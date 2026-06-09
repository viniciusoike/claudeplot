# Palette display ----

# Choose readable text color (dark or light) for a given background color.
.claude_text_on <- function(colors) {
  rgb <- grDevices::col2rgb(colors)
  luminance <- 0.299 * rgb[1, ] + 0.587 * rgb[2, ] + 0.114 * rgb[3, ]
  ifelse(luminance > 150, "#141413", "#FAF9F5")
}

#' Display a single claudeplot palette
#'
#' Draws one palette as a row of labelled color swatches.
#'
#' @inheritParams claude_pal
#' @param labels Logical; overlay hex codes on each swatch?
#'
#' @return A ggplot object (invisibly), drawn as a side effect.
#' @seealso [show_claude_palettes()] to display every palette at once.
#' @examples
#' show_claude_palette("claude")
#' show_claude_palette("oranges", n = 7, type = "continuous")
#' @export
show_claude_palette <- function(palette = "claude", n = NULL,
                                type = c("discrete", "continuous"),
                                reverse = FALSE, labels = TRUE) {
  if (missing(type)) {
    type <- .claude_default_type(palette)
  } else {
    type <- match.arg(type)
  }
  colors <- claude_pal(palette, n = n, type = type, reverse = reverse)

  df <- data.frame(
    x = seq_along(colors),
    hex = colors,
    stringsAsFactors = FALSE
  )

  p <- ggplot2::ggplot(df, ggplot2::aes(x = .data$x, y = 1, fill = .data$hex)) +
    ggplot2::geom_tile(width = 0.95, height = 1, color = "#FFFFFF", linewidth = 1.5) +
    ggplot2::scale_fill_identity() +
    ggplot2::labs(title = paste0("claudeplot palette: ", palette)) +
    ggplot2::theme_void(base_size = 12) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", hjust = 0.5),
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )

  if (labels && type == "discrete") {
    p <- p + ggplot2::geom_text(
      ggplot2::aes(label = .data$hex),
      color = .claude_text_on(colors),
      angle = 90, size = 3, fontface = "bold"
    )
  }

  print(p)
  invisible(p)
}

#' Display all available claudeplot palettes
#'
#' Draws every palette (optionally filtered by type) as a stacked grid of
#' color swatches.
#'
#' @param type One of `"all"`, `"qualitative"`, `"sequential"`, or
#'   `"diverging"`.
#'
#' @return A ggplot object (invisibly), drawn as a side effect.
#' @seealso [show_claude_palette()] to display one palette in detail.
#' @examples
#' show_claude_palettes()
#' show_claude_palettes("sequential")
#' @export
show_claude_palettes <- function(type = c("all", "qualitative", "sequential",
                                          "diverging")) {
  type <- match.arg(type)
  pal_names <- claude_palette_names(type)

  rows <- lapply(pal_names, function(nm) {
    cols <- .claude_palette_colors(nm)
    data.frame(
      palette = nm,
      x = seq_along(cols),
      hex = cols,
      stringsAsFactors = FALSE
    )
  })
  df <- do.call(rbind, rows)
  df$palette <- factor(df$palette, levels = rev(pal_names))

  ttl <- if (type == "all") {
    "claudeplot color palettes"
  } else {
    paste0("claudeplot palettes: ", type)
  }

  p <- ggplot2::ggplot(
    df, ggplot2::aes(x = .data$x, y = .data$palette, fill = .data$hex)
  ) +
    ggplot2::geom_tile(width = 0.95, height = 0.85, color = "#FFFFFF", linewidth = 1) +
    ggplot2::scale_fill_identity() +
    ggplot2::scale_x_continuous(expand = ggplot2::expansion(add = 0.5)) +
    ggplot2::labs(title = ttl) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(
      axis.title = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(hjust = 1, family = "mono"),
      panel.grid = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(face = "bold")
    )

  print(p)
  invisible(p)
}
