################################################################################
################################################################################
rm(list = ls())
gc()
device <- ifelse(grepl("/LSS/", system("cd &pwd", intern = T)), "IDAS", "argon")
source(paste0(ifelse(device == "IDAS", "~/LSS", "/Dedicated"),
              "/jmichaelson-wdata/msmuhammad/msmuhammad-source.R"))
################################################################################
################################################################################
project.dir <- paste0(ifelse(device == "IDAS", "~/LSS", "/Dedicated"),
                      "/jmichaelson-wdata/msmuhammad/TA/BfB/BfB-M5_RNA-seq-tut")
setwd(project.dir)
################################################################################
################################################################################
################################################################################
ratings <- read_csv("data/students-rtings.csv")

p1 <- ratings %>%
  pivot_longer(cols = c(3:4)) %>%
  mutate(value = factor(value, levels = c(1:5))) %>%
  ggplot(aes(x=value)) +
  geom_bar(width=0.5) +
  facet_wrap(~name)+
  bw.theme

p2 <- ratings %>%
  ggplot(aes(x=sex)) +
  geom_bar(width=0.5) +
  bw.theme

p3 <- ratings %>%
  ggplot(aes(x=confidence, y = rating)) +
  geom_point(shape =1, position = "jitter") +
  geom_smooth(color = six.colors[3], 
              method = "lm") +
  ggpubr::stat_cor(color = "red") +
  bw.theme

p4 <- ratings %>%
  ggplot(aes(x=confidence, y = rating, color = sex)) +
  geom_point(shape =1, position = "jitter") +
  # geom_smooth(aes(x=confidence, y = rating), 
  #             method = "lm", color = "black",
  #             linetype=2) +
  geom_smooth(method = "lm") +
  ggpubr::stat_cor(show.legend = F,
                   label.y.npc = 0.9) +
  # ggpubr::stat_cor(aes(x=confidence, y=rating), 
  #                  show.legend = F,
  #                  color = "black",
  #                  label.y.npc = 1) +
  scale_color_manual(values = redblu.col) +
  bw.theme

p5 <- ratings %>%
  pivot_longer(c(3:4)) %>%
  ggplot(aes(x=sex, y=value, fill = sex)) +
  geom_violin(show.legend = F) +
  geom_boxplot(width = 0.2, fill = "white") +
  ggpubr::stat_compare_means(label.y.npc = 0.9) +
  facet_wrap(~name) +
  scale_fill_manual(values = redblu.col) +
  bw.theme


patchwork::wrap_plots(patchwork::wrap_plots(p1,p2, nrow = 1, widths = c(2.5,1)),
                      patchwork::wrap_plots(p3,p4, nrow = 1), 
                      p5,
                      ncol = 1)
ggsave("figs/ratings-stats.png", bg = "white",
       width = 6, height = 9.5, units = "in", dpi = 360)
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
