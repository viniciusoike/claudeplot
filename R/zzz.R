# Font registration ----

.onLoad <- function(libname, pkgname) {
  if (requireNamespace("systemfonts", quietly = TRUE)) {
    register_claude_fonts(pkgname)
  }
  invisible(NULL)
}

# Register the bundled Poppins and Lora families with systemfonts so that
# ragg/svglite devices can render them without a manual system install.
register_claude_fonts <- function(pkgname = "claudeplot") {
  font_dir <- system.file("fonts", package = pkgname)
  if (!nzchar(font_dir)) return(invisible(NULL))

  poppins <- file.path(font_dir, "poppins")
  lora <- file.path(font_dir, "lora")

  tryCatch(
    {
      systemfonts::register_font(
        name = "Poppins",
        plain = file.path(poppins, "Poppins-Regular.ttf"),
        bold = file.path(poppins, "Poppins-Bold.ttf"),
        italic = file.path(poppins, "Poppins-Italic.ttf"),
        bolditalic = file.path(poppins, "Poppins-BoldItalic.ttf")
      )
      systemfonts::register_font(
        name = "Lora",
        plain = file.path(lora, "Lora-Regular.ttf"),
        bold = file.path(lora, "Lora-Bold.ttf"),
        italic = file.path(lora, "Lora-Italic.ttf"),
        bolditalic = file.path(lora, "Lora-BoldItalic.ttf")
      )
    },
    error = function(e) invisible(NULL)
  )
  invisible(NULL)
}
