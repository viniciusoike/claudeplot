library(claudeplot)
library(ggrounded)
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
  geom_col_rounded() +
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
  geom_col_rounded(key_glyph = "point") +
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
    position.inside = c(0.7, 0.85),
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

ggsave("inst/figures/replication-example-1.png", rep1, width = 8, height = 5)
