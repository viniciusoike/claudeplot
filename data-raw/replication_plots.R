library(claudeplot)
library(gground)
library(ggplot2)
library(dplyr)
library(patchwork)

dat <- tribble(
  ~model            , ~benchmark      , ~performance ,
  "Claude Fable"    , "SWE-Bench Pro" , 80.3         ,
  "Claude Opus 4.8" , "SWE-Bench Pro" , 69.2         ,
  "GPT 5.5"         , "SWE-Bench Pro" , 58.6         ,
  "Claude Fable"    , "FrontierCode"  , 29.3         ,
  "Claude Opus 4.8" , "FrontierCode"  , 13.4         ,
  "GPT 5.5"         , "FrontierCode"  ,  5.7
)

pal_cols <- c(
  claude_palette("warm")[1],
  claude_palette("claude")[1],
  claude_palette("brand")[4]
)

p1 <- ggplot(
  subset(dat, benchmark == "SWE-Bench Pro"),
  aes(model, performance, fill = model)
) +
  geom_round_col() +
  geom_text(
    aes(label = performance),
    size = 4,
    family = "Poppins",
    nudge_y = 5
  ) +
  scale_x_discrete(labels = c("", "\nSWE-Bench Pro", "")) +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  scale_fill_manual(values = pal_cols) +
  guides(fill = "none") +
  labs(y = "Success Rate (%)") +
  theme_claude() +
  theme_sub_strip(
    text.x.bottom = element_text()
  ) +
  theme_sub_axis_x(
    ticks = element_blank(),
    title = element_blank(),
    text = element_text(face = "bold", size = 10)
  )

p2 <- ggplot(
  subset(dat, benchmark == "FrontierCode"),
  aes(model, performance, fill = model)
) +
  geom_round_col(key_glyph = "point") +
  geom_text(
    aes(label = performance),
    size = 4,
    family = "Poppins",
    nudge_y = 2
  ) +
  scale_x_discrete(labels = c("", "\nFrontierCode", "")) +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  scale_fill_manual(name = NULL, values = pal_cols) +
  guides(fill = guide_legend(override.aes = list(shape = 21, size = 3))) +
  labs(y = "Success Rate (%)") +
  theme_claude() +
  theme_sub_legend(
    position = "inside",
    position.inside = c(0.6, 0.85),
    direction = "vertical",
    background = element_rect(fill = "gray90", color = "gray80")
  ) +
  theme_sub_strip(
    text.x.bottom = element_text()
  ) +
  theme_sub_axis_x(
    ticks = element_blank(),
    title = element_blank(),
    text = element_text(face = "bold", size = 10)
  )


rep1 <- (p1 | p2) +
  plot_annotation(
    title = "Agentic coding",
    theme = theme_claude() + theme(plot.title = element_text(hjust = 0.5))
  )

ggsave("inst/figures/replication-example-1.png", rep1, width = 10, height = 6)


library(tibble)
# https://www.anthropic.com/research/coding-agents-social-sciences
panel_a <- tribble(
  ~use_case        , ~group             , ~share ,
  "Code"           , "Coding agent use" ,     97 ,
  "Code"           , "Other AI users"   ,     77 ,
  "Edit prose"     , "Coding agent use" ,     87 ,
  "Edit prose"     , "Other AI users"   ,     72 ,
  "Method advice"  , "Coding agent use" ,     77 ,
  "Method advice"  , "Other AI users"   ,     63 ,
  "Lit review"     , "Coding agent use" ,     76 ,
  "Lit review"     , "Other AI users"   ,     60 ,
  "Draft prose"    , "Coding agent use" ,     54 ,
  "Draft prose"    , "Other AI users"   ,     30 ,
  "Generate ideas" , "Coding agent use" ,     47 ,
  "Generate ideas" , "Other AI users"   ,     32
)

lvls_use_case <- panel_a |>
  tidyr::pivot_wider(
    id_cols = "use_case",
    names_from = "group",
    values_from = "share"
  ) |>
  arrange(`Coding agent use`) |>
  pull(use_case)

panel_a <- panel_a |>
  mutate(
    use_case = factor(use_case, levels = lvls_use_case),
    group = factor(group, levels = c("Other AI users", "Coding agent use"))
  )

claudeplot::show_claude_palettes()
claudeplot::claude_pal("spectral")

main_color <- c("#f2c977", "#c08434")
bg_fill <- "#fbf9f5"

p_left <- ggplot(
  panel_a,
  aes(share, use_case, group = group)
) +
  geom_col(
    aes(fill = group),
    width = 0.6,
    key_glyph = "point",
    position = position_dodge(width = 0.6)
  ) +
  geom_label(
    aes(x = share + 7, label = scales::percent(share, scale = 1)),
    position = position_dodge(width = 0.6),
    size = 3,
    family = "Poppins",
    fontface = "bold",
    fill = bg_fill,
    color = "#73716d",
    border.color = NA
  ) +
  scale_x_continuous(
    breaks = seq(0, 100, 25),
    expand = expansion(c(0, 0.1))
  ) +
  scale_fill_manual(
    values = c(main_color, main_color)
  ) +
  guides(fill = guide_legend(override.aes = list(shape = 21, size = 3))) +
  labs(
    title = "A. Coding agent vs non-agent LLM users",
    x = "Share selecting this use case",
    y = NULL
  ) +
  theme_claude() +
  theme(
    text = element_text(color = "#73716d")
  ) +
  theme_sub_plot(
    title = element_text(size = 10, face = "bold", color = "#73716d"),
    title.position = "panel",
    background = element_rect(fill = bg_fill, color = bg_fill),
    margin = margin(20, 20, 20, 20)
  ) +
  theme_sub_panel(
    grid.major.x = element_line(color = "#c2c0bc"),
    grid.major.y = element_blank(),
    background = element_rect(fill = bg_fill, color = bg_fill)
  ) +
  theme_sub_axis_x(
    line = element_line(linewidth = 0.5, color = "#73716d"),
    ticks = element_line(color = "#73716d")
  ) +
  theme_sub_axis_y(
    line = element_line(linewidth = 0.5, color = "#d3d2ce"),
    ticks = element_blank()
  ) +
  theme_sub_legend(
    title = element_blank(),
    background = element_rect(fill = bg_fill, color = "#74726e"),
    position = "inside",
    position.inside = c(0.6, 0.15),
    text = element_text(size = 8),
    key.spacing = unit(0.1, "lines")
  )

use_cases <- c(
  "Code",
  "Edit prose",
  "Method advice",
  "Lit review",
  "Draft prose",
  "Generate ideas"
)

disciplines <- c(
  "Economics",
  "Political Science",
  "Sociology",
  "Psychology",
  "Management Science",
  "Health, Educ, Comms"
)

# fmt: skip
panel_b <- tibble(
  use_case = rep(use_cases, each = 6),
  discipline = rep(disciplines, times = 6),
  share = c(
    93, 85, 82, 81, 75, 71, 80, 61, 73, 75, 87, 80, 71, 67, 65, 60, 72, 61,
    75, 58, 55, 60, 76, 59, 50, 26, 29, 31, 46, 31, 36, 27, 35, 29, 49, 38
  )
)

panel_b <- panel_b |>
  mutate(
    use_case = factor(use_case, levels = rev(use_cases)),
    discipline = factor(discipline, levels = disciplines),
    label = scales::percent(share, scale = 1),
    label_col = if_else(share > 50, "#ffffff", "#747169")
  )

p_right <- ggplot(panel_b, aes(discipline, use_case, fill = share)) +
  geom_tile() +
  geom_text(
    aes(color = label_col, label = scales::percent(share, scale = 1)),
    size = 3,
    fontface = "bold",
    family = "Poppins"
  ) +
  scale_x_discrete(
    labels = \(x) stringr::str_wrap(x, 5),
    expand = expansion(c(0, 0.25))
  ) +
  scale_y_discrete(expand = expansion(c(0, 0.15))) +
  scale_color_identity() +
  scale_fill_gradient(low = "#dedccf", high = "#000000") +
  labs(
    title = "B. Share selecting each use case, by discipline",
    x = NULL,
    y = NULL
  ) +
  theme_claude() +
  theme(
    text = element_text(color = "#73716d")
  ) +
  theme_sub_plot(
    title = element_text(size = 10, face = "bold", color = "#73716d"),
    title.position = "panel",
    background = element_rect(fill = bg_fill, color = bg_fill),
    margin = margin(20, 20, 20, 20)
  ) +
  theme_sub_panel(
    grid.major = element_blank(),
    background = element_rect(fill = bg_fill, color = bg_fill)
  ) +
  theme_sub_legend(position = "none") +
  theme_sub_axis(
    line = element_blank(),
    ticks = element_blank()
  )

panel <- p_left | p_right

panel <- panel +
  plot_annotation(
    title = "What researchers use AI to do",
    theme = theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        family = "Poppins",
        size = 22,
        margin = margin(20, 0, 20, 0)
      ),
      plot.background = element_rect(fill = "#eae6de", color = "#eae6de")
    )
  )

ggsave("inst/figures/replication-example-4.png", panel, width = 11, height = 6)

claudeplot::show_claude_palettes()

# https://www.anthropic.com/research/anthropic-economic-index-january-2026-report
