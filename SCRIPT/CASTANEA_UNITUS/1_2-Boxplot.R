################################################################################

#                         1_2- BOX plot

################################################################################
library(ggplot2); library(gridExtra); library(grid); library(cowplot)

data <- read_csv("./DATA/UNITUS/CSV/data_castagno2_0.csv")

colnames(data)

# Converti la colonna inoculum in un fattore
data$inoculum <- factor(data$inoculum)

# Definizione dei colori desiderati per PC e NI
colors <- c("PC" = "lightcoral", "NI" = "lightblue")

# This is the plot from which I extract the legend.
leg <- ggplot(data, aes(x = treatment, y = length, fill = inoculum)) +
  geom_boxplot() +
  labs(x = "", y = "Length (cm)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) +
  guides(fill = guide_legend(ncol = 3, title = "Inoculum")) +
  scale_fill_manual(values = colors) +
  theme(legend.position = "bottom")

# Extract the legend from one of the graphs.
legend <- cowplot::get_legend(leg)

# Creazione della lista di grafici
plots <- list()

# Ciclo for per creare i grafici
for (var in c("length", "VOLT", "AvgDiam", "RSF")) {
  plot <- ggplot(data, aes_string(x = "treatment", y = var, fill = "inoculum")) +
    geom_boxplot(show.legend = FALSE) +
    labs(x = ifelse(var == "RSF", "Treatments", ""), 
         y = switch(var,
                    "length" = "Total Length (cm)",
                    "VOLT" = "Total Roots Volume (cm3)",
                    "AvgDiam" = "AvgDiam (cm)",
                    "RSF" = "Roots Surface (cm2)")) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) +
    scale_fill_manual(values = colors) +
    theme(legend.position = "none")
  
  plots[[var]] <- plot
}

# Posizionamento della legenda nella griglia
grid1 <- grid.arrange(arrangeGrob(grobs = plots, ncol = 2), bottom = legend)

# Aggiunta del titolo al grafico composto
grid1 <- grid.arrange(grobs = list(grid1), top = textGrob("Castanea Unitus", gp = gpar(fontsize = 16)))

# Specifies the path to save
file_path <- "./GRAPHS/boxPlots_Castanea_Unitus.png"

# Save the grid as a PNG file.
ggsave(file_path, grid1, width = 16, height = 12, dpi = 700)
