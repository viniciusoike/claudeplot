# Discrete scales ----

#' Claude color and fill scales for ggplot2
#'
#' Discrete (`_d`) and continuous (`_c`) color and fill scales built from the
#' claudeplot palettes. The British spelling (`colour`) aliases are provided
#' for every American (`color`) scale.
#'
#' @param palette Name of a palette. Discrete scales default to `"claude"`
#'   (the vivid benchmark palette); continuous scales default to `"oranges"`.
#'   See [claude_palette_names()].
#' @param reverse Logical; reverse the palette order?
#' @param ... Passed to [ggplot2::discrete_scale()],
#'   [ggplot2::scale_color_gradientn()], or
#'   [ggplot2::scale_fill_gradientn()].
#'
#' @return A ggplot2 scale object.
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, color = factor(gear))) +
#'   geom_point() +
#'   scale_color_claude_d()
#'
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_raster() +
#'   scale_fill_claude_c(palette = "blues")
#' @name scale_claude
NULL

#' @rdname scale_claude
#' @export
scale_color_claude_d <- function(palette = "claude", reverse = FALSE, ...) {
  ggplot2::discrete_scale(
    aesthetics = "colour",
    palette = function(n) claude_pal(palette, n, type = "discrete", reverse = reverse),
    ...
  )
}

#' @rdname scale_claude
#' @export
scale_colour_claude_d <- scale_color_claude_d

#' @rdname scale_claude
#' @export
scale_fill_claude_d <- function(palette = "claude", reverse = FALSE, ...) {
  ggplot2::discrete_scale(
    aesthetics = "fill",
    palette = function(n) claude_pal(palette, n, type = "discrete", reverse = reverse),
    ...
  )
}

# Continuous scales ----

#' @rdname scale_claude
#' @export
scale_color_claude_c <- function(palette = "oranges", reverse = FALSE, ...) {
  pal <- claude_pal(palette, n = 256, type = "continuous", reverse = reverse)
  ggplot2::scale_color_gradientn(colours = pal, ...)
}

#' @rdname scale_claude
#' @export
scale_colour_claude_c <- scale_color_claude_c

#' @rdname scale_claude
#' @export
scale_fill_claude_c <- function(palette = "oranges", reverse = FALSE, ...) {
  pal <- claude_pal(palette, n = 256, type = "continuous", reverse = reverse)
  ggplot2::scale_fill_gradientn(colours = pal, ...)
}
