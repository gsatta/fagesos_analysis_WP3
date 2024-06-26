################################################################################

#                         1_2- BOX plot

################################################################################
library(ggplot2); library(gridExtra); library(grid); library(cowplot)

data <- read_csv("./DATA/UCO/CSV/selected_columns.csv")

data$...1 <- NULL

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

plots <- list()  # Lista per contenere i grafici

# Creazione dei grafici
for (var in variables) {
  plot <- ggplot(data, aes(x = treatment, y = .data[[var]], fill = inoculum)) +
    geom_boxplot() +
    labs(x = ifelse(var == "length", "Treatments", ""), 
         y = switch(var,
                    "dry_solo" = "Dry Weight (g)",
                    "length" = "Total Length (cm)",
                    "AvgDiam" = "Avg Diameter (cm)",
                    "rootVolume" = "Total Roots Volume (cm3)",
                    "FRL" = "Fine Root Length (cm)",
                    "CRL" = "Coarse Root Length (cm)",
                    "FVOL" = "Fine Root Volume (cm3)",
                    "CVOL" = "Coarse Root Volume (cm3)")) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) +
    scale_fill_manual(values = colors) +
    theme(legend.position = "none")  # Rimuove la legenda dai singoli grafici
  
  plots[[var]] <- plot  # Aggiungi il grafico alla lista
}

# Creazione della legenda separata
legend_plot <- ggplot(data, aes(x = treatment, y = .data[[variables[1]]], fill = inoculum)) +
  geom_boxplot() +
  scale_fill_manual(values = colors) +
  theme(legend.position = "bottom", legend.title = element_blank()) +
  guides(fill = guide_legend(nrow = 1))

legend <- get_legend(legend_plot)

# Posizionamento dei grafici nella griglia con la legenda
grid1 <- grid.arrange(
  arrangeGrob(grobs = plots, ncol = 3), 
  bottom = legend, 
  top = textGrob("Q. ilex UCO", gp = gpar(fontsize = 16))
)

# Specifies the path to save
file_path <- "./GRAPHS/boxPlots_qilex_UCO.png"

# Save the grid as a PNG file.
ggsave(file_path, grid1, width = 16, height = 12, dpi = 700)
