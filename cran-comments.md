## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environments

* macOS, R 4.5.1 (local)
* win-builder (devel and release)

## Possibly misspelled words in DESCRIPTION

A spell check may flag the following words. All are intentional proper nouns or
package names:

* Anthropic, Claude (the brand and assistant the package is themed after)
* ggplot2, systemfonts (package names)
* Poppins, Lora (the bundled font families)

## Bundled third-party files

The package bundles two font families under the SIL Open Font License 1.1:

* Poppins (4 .ttf files) in inst/fonts/poppins/
* Lora (4 .ttf files) in inst/fonts/lora/

License texts are in the respective OFL.txt files and provenance is documented
in inst/COPYRIGHTS. The fonts are registered with systemfonts (a Suggested
dependency) on load and render only on ragg/svglite devices, with a graceful
fallback to generic font families otherwise.

## First submission

This is the first submission of claudeplot to CRAN.
