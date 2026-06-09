# Palette accessor ----

#' Build a claudeplot palette object
#'
#' Returns the colors of a palette as a `claude_palette` object, which prints
#' as a color swatch (via [scales::show_col()]).
#'
#' @inheritParams claude_pal
#'
#' @return A character vector of hex colors with class `claude_palette`.
#' @seealso [show_claude_palette()] and [show_claude_palettes()] for plots.
#' @examples
#' claude_palette("claude")
#' claude_palette("oranges", n = 9, type = "continuous")
#' @export
claude_palette <- function(palette = "claude", n = NULL,
                           type = c("discrete", "continuous"), reverse = FALSE) {
  if (missing(type)) {
    type <- .claude_default_type(palette)
  } else {
    type <- match.arg(type)
  }
  cols <- claude_pal(palette, n = n, type = type, reverse = reverse)
  structure(
    cols,
    class = c("claude_palette", "character"),
    palette = palette
  )
}

#' @export
print.claude_palette <- function(x, ...) {
  name <- attr(x, "palette")
  n <- length(x)
  scales::show_col(unclass(x), ...)
  cli::cli_text("{.strong claudeplot palette}: {name} ({n} color{?s})")
  invisible(x)
}

#' @export
as.character.claude_palette <- function(x, ...) {
  out <- unclass(x)
  attr(out, "palette") <- NULL
  out
}
