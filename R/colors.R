# Anthropic / Claude colors ----

#' Anthropic and Claude brand colors
#'
#' A named character vector of the core colors used across Anthropic's brand
#' and Claude's data-visualization style. Brand neutrals and accents follow
#' Anthropic's published brand guidelines; the vivid accents (`viz_*`) match
#' the saturated colors used in Claude's benchmark charts.
#'
#' @format A named character vector of hex color strings.
#' @examples
#' claude_colors["orange"]
#' unname(claude_colors[c("viz_green", "viz_blue", "viz_pink")])
#' @export
claude_colors <- c(
  # Brand neutrals
  dark       = "#141413",
  slate      = "#3D3D3A",
  graphite   = "#6E6D66",
  mid_gray   = "#B0AEA5",
  light_gray = "#E8E6DC",
  cloud      = "#F0EEE6",
  light      = "#FAF9F5",
  white      = "#FFFFFF",
  # Brand accents
  orange     = "#D97757",
  blue       = "#6A9BCC",
  green      = "#788C5D",
  # Vivid data-visualization accents
  viz_green  = "#1CA672",
  viz_blue   = "#2C71D6",
  viz_pink   = "#E96B9E",
  viz_orange = "#E8703A",
  viz_amber  = "#F2A516",
  viz_indigo = "#3B2D9E",
  viz_ochre  = "#BD8A2A",
  viz_gray   = "#C9C7BA"
)

# Palette definitions ----

# Qualitative palettes, mapped by family.
.claude_qualitative <- list(
  # Default: the vivid Claude benchmark-chart palette.
  claude = c(
    "#1CA672", "#2C71D6", "#E96B9E", "#E8703A", "#F2A516", "#788C5D"
  ),
  # Muted Anthropic brand accents.
  brand = c(
    "#D97757", "#6A9BCC", "#788C5D", "#B0AEA5", "#141413"
  ),
  # Warm accents only.
  warm = c(
    "#E8703A", "#D97757", "#F2A516", "#A8492B"
  ),
  # Cool accents only.
  cool = c(
    "#2C71D6", "#6A9BCC", "#1CA672", "#788C5D"
  ),
  # Themed survey palette (Claude's "colored by theme" categorical charts).
  editorial = c(
    "#2C71D6", "#E96B9E", "#F2A516", "#E8703A", "#3B2D9E"
  ),
  # Ochre / steel-blue two-tone from the economic-report comparison charts,
  # with a neutral gray third series.
  ochre_blue = c(
    "#BD8A2A", "#3D6A99", "#6E6D66"
  ),
  # Neutral grays from dark to light.
  neutral = c(
    "#141413", "#3D3D3A", "#6E6D66", "#B0AEA5", "#E8E6DC"
  )
)

# Sequential palettes (light -> dark), interpolated for continuous scales.
.claude_sequential <- list(
  oranges = c("#FAF9F5", "#F0CBB9", "#E29C7E", "#D97757", "#A8492B", "#6E2D17"),
  blues   = c("#F4F7FA", "#C5D8EA", "#94B5D7", "#6A9BCC", "#3D6A99", "#21425F"),
  greens  = c("#F2F4ED", "#CCD5BB", "#A1AE84", "#788C5D", "#566640", "#33402A"),
  grays   = c("#FAF9F5", "#E8E6DC", "#B0AEA5", "#6E6D66", "#3D3D3A", "#141413")
)

# Diverging palettes (low -> mid -> high).
.claude_diverging <- list(
  orange_blue = c(
    "#A8492B", "#D97757", "#F0CBB9", "#FAF9F5", "#C5D8EA", "#6A9BCC", "#21425F"
  ),
  green_orange = c(
    "#33402A", "#788C5D", "#CCD5BB", "#FAF9F5", "#F0CBB9", "#D97757", "#6E2D17"
  ),
  spectral = c(
    "#2C71D6", "#6A9BCC", "#CCD5BB", "#F2A516", "#E8703A", "#A8492B"
  )
)

# Metadata describing every palette, used by show helpers and validation.
.claude_palette_meta <- data.frame(
  name = c(
    names(.claude_qualitative),
    names(.claude_sequential),
    names(.claude_diverging)
  ),
  type = c(
    rep("qualitative", length(.claude_qualitative)),
    rep("sequential", length(.claude_sequential)),
    rep("diverging", length(.claude_diverging))
  ),
  stringsAsFactors = FALSE
)

# Internal helpers ----

# Return the raw color vector for a palette name, searching all families.
.claude_palette_colors <- function(palette) {
  pal <- .claude_qualitative[[palette]] %||%
    .claude_sequential[[palette]] %||%
    .claude_diverging[[palette]]

  if (is.null(pal)) {
    cli::cli_abort(c(
      "Palette {.val {palette}} not found.",
      "i" = "Use {.fn claude_palette_names} to list available palettes."
    ))
  }
  pal
}

# Default `type` (discrete/continuous) for a palette, based on its family.
.claude_default_type <- function(palette) {
  if (palette %in% names(.claude_qualitative)) "discrete" else "continuous"
}

#' List available claudeplot palettes
#'
#' @param type One of `"all"`, `"qualitative"`, `"sequential"`, or
#'   `"diverging"`.
#'
#' @return A character vector of palette names (invisible side effects: none).
#' @examples
#' claude_palette_names()
#' claude_palette_names("sequential")
#' @export
claude_palette_names <- function(type = c("all", "qualitative", "sequential",
                                          "diverging")) {
  type <- match.arg(type)
  meta <- .claude_palette_meta
  if (type != "all") {
    meta <- meta[meta$type == type, , drop = FALSE]
  }
  meta$name
}

#' Generate colors from a claudeplot palette
#'
#' Low-level palette generator used internally by the scale functions. Most
#' users will prefer [claude_palette()] (which returns a printable object) or
#' the `scale_*_claude_*()` functions.
#'
#' @param palette Name of a palette. See [claude_palette_names()].
#' @param n Number of colors to return. Defaults to the full palette for
#'   discrete palettes, or all anchor colors for continuous palettes.
#' @param type Either `"discrete"` or `"continuous"`. For `"continuous"`,
#'   colors are interpolated with [grDevices::colorRampPalette()].
#' @param reverse Logical; reverse the color order?
#'
#' @return A character vector of hex colors.
#' @examples
#' claude_pal("claude", n = 3)
#' claude_pal("oranges", n = 9, type = "continuous")
#' @export
claude_pal <- function(palette = "claude", n = NULL,
                       type = c("discrete", "continuous"), reverse = FALSE) {
  if (missing(type)) {
    type <- .claude_default_type(palette)
  } else {
    type <- match.arg(type)
  }

  pal <- .claude_palette_colors(palette)
  if (reverse) pal <- rev(pal)
  if (is.null(n)) n <- length(pal)

  out <- if (type == "continuous") {
    grDevices::colorRampPalette(pal)(n)
  } else {
    if (n > length(pal)) {
      cli::cli_warn(c(
        "Palette {.val {palette}} has {length(pal)} color{?s} but {n} \\
        requested.",
        "i" = "Recycling colors. Use {.code type = \"continuous\"} to \\
        interpolate instead."
      ))
      rep(pal, length.out = n)
    } else {
      pal[seq_len(n)]
    }
  }
  out
}
