library(tidyverse)
library(readxl)
library(pheatmap)
library(ggplot2)
library(RColorBrewer)
library(viridis)
library(cowplot)
library(scales)

# Read the Cazyme data
AG_A_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "AG-A")
dim(AG_A_cazys)
head(AG_A_cazys)

AG_E_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "AG-E")
AG_K_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "AG-K")
CAG_3_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "CAG-3")
CAG_6_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "CAG-6")

#Filter Cazys. Retain only predicted cazymes that have an e-value < than 1e-15
AG_A_cazys_filtered <- AG_A_cazys %>% filter(`E-value` <= 1e-15)
dim(AG_A_cazys_filtered)

AG_E_cazys_filtered <- AG_E_cazys %>% filter(`E-value` <= 1e-15)
AG_K_cazys_filtered <- AG_K_cazys %>% filter(`E-value` <= 1e-15)
CAG_3_cazys_filtered <- CAG_3_cazys %>% filter(`E-value` <= 1e-15)
CAG_6_cazys_filtered <- CAG_6_cazys %>% filter(`E-value` <= 1e-15)

#SignalP data
read_signalP <- function(x){
  read_delim(x, "\t", escape_double = FALSE, trim_ws = TRUE, 
             skip = 1) %>% 
    rename(ID = `# ID`)
}

AG_A.signalP <- read_signalP("Secretome/signalp/AG-A_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")
AG_E.signalP <- read_signalP("Secretome/signalp/AG-E_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")
AG_K.signalP <- read_signalP("Secretome/signalp/AG-K_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")
CAG_3.signalP <- read_signalP("Secretome/signalp/CAG-3_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")
CAG_6.signalP <- read_signalP("Secretome/signalp/CAG-6_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")



## Final set of Cazymes per AG. Filter by enzymes with signal peptide.
## If left_join delete NAs in E-value of cazys
## If right_join delete NAs in SP(Sec/SPI) in secreted proteins
AG_A_signalP_cazys <- AG_A.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  right_join(AG_A_cazys_filtered, by="ID")

AG_E_signalP_cazys <- AG_E.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(AG_E_cazys_filtered, by="ID")

AG_K_signalP_cazys <- AG_K.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  right_join(AG_K_cazys_filtered, by="ID")

CAG_3_signalP_cazys <- CAG_3.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  right_join(CAG_3_cazys_filtered, by="ID")

CAG_6_signalP_cazys <- CAG_6.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  right_join(CAG_6_cazys_filtered, by="ID")

Rzeae_signalP_cazys <- Rzeae.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  right_join(Rzeae_cazys_filtered, by="ID")


### Print to file. File contains the final list of cazymes for analysis
write.table(AG_A_signalP_cazys, file = "AG_A_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(AG_E_signalP_cazys, file = "AG_E_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(AG_K_signalP_cazys, file = "AG_K_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(CAG_3_signalP_cazys, file = "CAG_3_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(CAG_6_signalP_cazys, file = "CAG_6_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(Rzeae_signalP_cazys, file = "Rzeae_cazys.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)


## PLots

## Plot 1 summary of cazys per major cazy category

cazy_categories <- read_excel("CAZys_summary_2023.xlsx", sheet = "All_Cazy_families", range = "A1:C37")
head(cazy_categories)

p1 <- ggplot(cazy_categories, aes(x=Cazy_family, y=Cazys, fill=AG)) +
  geom_bar(stat = "identity", position = "dodge", color = "grey10") + coord_flip() +
  labs(y="Number of CAZymes", x=NULL) +
  scale_fill_brewer(palette = 1) +
  theme(axis.text.x = element_text(size = 16), axis.title.x = element_text(size = 18)) +
  theme(axis.text.y = element_text(size = 16), axis.title.y = element_text(size = 18)) +
  theme(legend.title = element_blank(), legend.text = element_text(size = 16))



p2 <- ggplot(cazy_categories, aes(x=AG, y=Cazys, fill=Cazy_family)) +
  geom_bar(stat = "identity", position = "stack", color = "grey10") +
  #labs(y=NULL, x=NULL) +
  labs(y="Number of CAZymes", x="\nAG group") +
  scale_y_continuous(label=comma) +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(size = 14, angle = 0, vjust = 0.5), axis.title.x = element_text(size = 18)) +
  theme(axis.text.y = element_text(size = 14), axis.title.y = element_text(size = 18)) +
  theme(legend.title = element_blank(), legend.text = element_text(size = 16))
  

total_cazys <- read_excel("CAZys_summary_2023.xlsx", sheet = "All_Cazy_families", range = "F1:G7")
head(total_cazys)

p3 <- ggplot(total_cazys, aes(x=AG, y=Total)) +
  geom_bar(stat = "identity", fill="#2A788EFF", position = "dodge") +
  geom_text(aes(y = Total, label = Total), vjust = 1.6, color = "white", size=6) +
  labs(y="Number of CAZymes", x=NULL) +
  theme(axis.text.x = element_text(size = 16, angle = 45, vjust = 0.5), axis.title.x = element_text(size = 18)) +
  theme(axis.text.y = element_text(size = 16), axis.title.y = element_text(size = 18))
p3
  
# Assemble for figure 9 chapter 1

plot_grid(p3, p2, labels = c("A", "B"), nrow = 1, ncol = 2, rel_widths = c(1,2), label_size = 16)


## Plot 2 heatmap for PCWDE and FCWDE

# Read cazy families families
cazy_families <- read_excel("CAZys_summary_2023.xlsx", sheet = "cazys_heatmap")
cazy_families <- as.data.frame(cazy_families)

str(cazy_families)


# Read metadata with information about substrate and major category
annotations <- read_excel("cazymes_metadata.xlsx")
annotations <- annotations %>% column_to_rownames("Cazy_family")

ann_colors = list(
  Category = c(PCWDE = "#03051AFF", PCWD_CBMs = "#CB1B4FFF", FCWDE = "#FAEBDDFF"),
  Substrate = c(Cellulose = "#440154FF", Hemicellulose = "#443A83FF", 'Hemicellulose-Pectin' = "#31688EFF", 
                Pectin = "#21908CFF", Lignin = "#35B779FF", Undetermined = "#8FD744FF", FCW = "#FDE725FF")
  )




row.names(cazy_families) <- cazy_families[,1]
cazy_families <- cazy_families[,-1]
class(cazy_families)

cazy_families_matrix <- as.matrix(cazy_families)
#effec_matrix <- apply(effec_matrix,2,as.numeric)

png("cazy_families_abundant.png", height = 10, width = 8, units = "in", res = 400)

pheatmap(cazy_families_matrix,
         annotation_row = annotations,
         annotation_colors = ann_colors,
         show_colnames = TRUE,
         show_rownames = TRUE,
         cluster_rows = FALSE, 
         cluster_cols = TRUE,
         angle_col = 0,
         annotation_names_row = TRUE,
         clustering_method = "average"
)

dev.off()
