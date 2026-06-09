# Font availability ----

# Is a given family available to render, via systemfonts registry or the
# operating system? Gated on ragg, since registered fonts only render on
# ragg/svglite devices (not base PDF/PostScript).
claude_font_is_available <- function(family) {
  if (!requireNamespace("systemfonts", quietly = TRUE)) return(FALSE)
  if (!requireNamespace("ragg", quietly = TRUE)) return(FALSE)

  tryCatch(
    {
      reg <- systemfonts::registry_fonts()
      if (nrow(reg) > 0 &&
          any(grepl(family, reg$family, ignore.case = TRUE))) {
        return(TRUE)
      }
      sys <- systemfonts::system_fonts()
      any(grepl(family, sys$family, ignore.case = TRUE))
    },
    error = function(e) FALSE
  )
}

# Resolve a preferred family, falling back to a generic family when the
# bundled font cannot be rendered.
claude_resolve_font <- function(family, fallback = "sans") {
  if (claude_font_is_available(family)) family else fallback
}

#' Report claudeplot font status
#'
#' Prints whether the bundled Anthropic typefaces (Poppins and Lora) are
#' available to render and whether the optional `ragg` and `systemfonts`
#' packages are installed. Useful for diagnosing why [theme_claude()] falls
#' back to generic fonts.
#'
#' @return Invisibly, a named list with logical entries `poppins`, `lora`,
#'   `systemfonts`, and `ragg`.
#' @examples
#' claude_font_status()
#' @export
claude_font_status <- function() {
  has_systemfonts <- requireNamespace("systemfonts", quietly = TRUE)
  has_ragg <- requireNamespace("ragg", quietly = TRUE)
  poppins <- claude_font_is_available("Poppins")
  lora <- claude_font_is_available("Lora")

  cli::cli_h1("claudeplot font status")

  if (poppins) {
    cli::cli_alert_success("Poppins (headings): {.strong available}")
  } else {
    cli::cli_alert_warning("Poppins (headings): {.strong not available}")
  }
  if (lora) {
    cli::cli_alert_success("Lora (body/subtitle): {.strong available}")
  } else {
    cli::cli_alert_warning("Lora (body/subtitle): {.strong not available}")
  }

  if (has_systemfonts) {
    cli::cli_alert_success("systemfonts: {.strong installed}")
  } else {
    cli::cli_alert_info("systemfonts: not installed (needed to register fonts)")
  }
  if (has_ragg) {
    cli::cli_alert_success("ragg: {.strong installed}")
  } else {
    cli::cli_alert_info("ragg: not installed (recommended rendering device)")
  }

  if (poppins && lora && has_ragg) {
    cli::cli_alert_success(
      "{.fn theme_claude} will use Poppins and Lora automatically."
    )
  } else {
    cli::cli_alert_info(
      "Install {.pkg systemfonts} and {.pkg ragg}, then reload the package, \\
      to enable the bundled fonts."
    )
  }

  invisible(list(
    poppins = poppins,
    lora = lora,
    systemfonts = has_systemfonts,
    ragg = has_ragg
  ))
}
