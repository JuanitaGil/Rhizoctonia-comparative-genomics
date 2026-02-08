library(tidyverse)
library(readxl)
library(viridis)
library(pheatmap)
library(cowplot)

# Read effectors functions and core families
core_effectors <- read_excel("effectorp/effectors_function_summary.xlsx", sheet = "Core")
core_effectors_matrix <- as.data.frame(core_effectors)

str(core_effectors_matrix)
  
row.names(core_effectors_matrix) <- core_effectors_matrix[,1]
core_effectors_matrix <- core_effectors_matrix[,-1]
class(core_effectors_matrix)

effec_matrix <- as.matrix(core_effectors_matrix)
effec_matrix <- apply(effec_matrix,2,as.numeric)
  
pheatmap(effec_matrix,
               show_colnames = TRUE,
               show_rownames = TRUE,
               cluster_rows = FALSE, 
               cluster_cols = TRUE,
               border_color = NA,
               angle_col = 0
)


## Same data as bubble plot
core_effectors_bp <- read_excel("effectorp/effectors_function_summary.xlsx", sheet = "Sheet3")
dim(core_effectors_bp)
head(core_effectors_bp)

bp <- ggplot(core_effectors_bp, aes(x=AG, y=Effector_Family, size = Effectors)) +
  geom_point(alpha=0.5) +
  scale_size(range = c(0,16), name = "Effectors") +
  theme_bw() +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
  theme(axis.text.x = element_text(size = 16), axis.text.y = element_text(size = 16))
bp


?pheatmap
#dev.off()
