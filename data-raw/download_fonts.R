# Download bundled fonts ----
#
# Re-creates inst/fonts/ from the official Google Fonts repository. Both
# Poppins and Lora are licensed under the SIL Open Font License 1.1. Run
# manually; not part of the build.

dl <- function(url, dest) {
  dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
  utils::download.file(url, dest, mode = "wb", quiet = TRUE)
}

base <- "https://github.com/google/fonts/raw/main/ofl"

# Poppins ----
poppins <- c("Regular", "Bold", "Italic", "BoldItalic")
for (style in poppins) {
  dl(
    sprintf("%s/poppins/Poppins-%s.ttf", base, style),
    sprintf("inst/fonts/poppins/Poppins-%s.ttf", style)
  )
}
dl(paste0(base, "/poppins/OFL.txt"), "inst/fonts/poppins/OFL.txt")

# Lora ----
lora <- c("Regular", "Bold", "Italic", "BoldItalic")
for (style in lora) {
  dl(
    sprintf("%s/lora/static/Lora-%s.ttf", base, style),
    sprintf("inst/fonts/lora/Lora-%s.ttf", style)
  )
}
dl(paste0(base, "/lora/OFL.txt"), "inst/fonts/lora/OFL.txt")
