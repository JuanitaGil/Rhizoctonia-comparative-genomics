#Figure CAZYmes

library(ggplot2)
library(cowplot)
install.packages("patchwork")
library(patchwork)

#Plant cell wall degrading associated CAZYmes
PWC <- ggplot(PCW_CAZYmes, aes(x=Rhizoctonia_isolate, y=PCW, fill=Rhizoctonia_isolate)) +
   geom_bar(stat="identity") + geom_text(aes(label=PCW), vjust=-0.3) + xlab("Rhizoctonia isolate") + ylab("Number of PCW degradation associated CAZYmes")
PWC
PWC + labs(fill="Rhizoctonia isolate") + scale_fill_manual(values = c("#FF0000", "#0000FF", "#00FF00", "#FF00FF"))

#Fungal cell wall degrading associated CAZYmes
FWC <- ggplot(FCW_CAZYmes, aes(x=Rhizoctonia_isolate, y=FCW, fill=Rhizoctonia_isolate)) +
  geom_bar(stat="identity") + geom_text(aes(label=FCW), vjust=-0.3) + xlab("Rhizoctonia isolate") + ylab("Number of FCW degradation associated CAZYmes")
FWC
FWC + labs(fill="Rhizoctonia isolate") + scale_fill_manual(values = c("#FF0000", "#0000FF", "#00FF00", "#FF00FF"))


#Figure effectors
#putative apoplastic effectors
apo <- ggplot(Apoplastic_effectors, aes(x=Category, y=Effectors, fill=Rhizoctonia_isolate)) +
  geom_bar(stat="identity", position = "dodge") + xlab("") + ylab("Number of candidate effectors") +
  coord_flip() + ggtitle("Potential apoplastic effectors") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) + theme(axis.text.x = element_text(size = 11, colour = "black")) +
  theme(axis.text.y = element_text(size = 11, colour = "black")) + theme(legend.position = "none")
apo
apo2 <- apo + scale_fill_manual(values = c("#FF0000", "#0000FF", "chartreuse3", "#FF00FF"))


#putative cytoplasmic effectors
library(readxl)
Cytoplasmic_effectors <- read_excel("Secretome/Cytoplasmic_effectors.xlsx")

cyto <- ggplot(Cytoplasmic_effectors, aes(x=Category, y=Effectors, fill=Rhizoctonia_isolate)) +
  geom_bar(stat="identity", position = "dodge") + xlab("") + ylab("Number of candidate effectors") +
  coord_flip() + ggtitle("Potential cytoplasmic effectors") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) + theme(axis.text.x = element_text(size = 11, colour = "black")) +
  theme(axis.text.y = element_text(size = 11, colour = "black"))
cyto
cyto2 <- cyto + labs(fill="Rhizoctonia isolate") + scale_fill_manual(values = c("#FF0000", "#0000FF", "chartreuse3", "#FF00FF"))


plot_grid(apo2, cyto2)


### Example
library(readxl)
library(tidyverse)
CAZys_analysis <- read_excel("Secretome/CAZys_analysis.xlsx", 
                             sheet = "Sheet2", col_types = c("text", 
                                                             "text", "text", "numeric", "numeric", 
                                                             "numeric", "numeric"))

(Cazy_PCW <- CAZys_analysis %>%
  pivot_longer(cols = starts_with(c("AG","CAG")),
               names_to = "AG_group",
               values_to = "counts")
)               

p1 <- ggplot(Cazy_PCW) + geom_bar(aes(x=AG_group, y = counts, fill=Substrate), 
                             position = "stack", stat = "identity") +
  xlab("Rhizoctonia isolate") + ylab("Number of PCW associated CAZYmes") + facet_wrap(. ~ Family, ncol = 1) +
  ggtitle("Plant Cell Wall")

p1 + theme(axis.title.x = element_text(size = 12)) + theme(axis.title.y = element_text(size = 12)) +
  theme(plot.title = element_text(face = "bold", size = 16, hjust = 0.5)) + theme(axis.text.x = element_text(size = 11, colour = "black")) +
                                                                                  theme(axis.text.y = element_text(size = 11, colour = "black")) +
  theme(strip.text = element_text(size = 12, colour = "black"))


## FCW
CAZys_analysis <- read_excel("Secretome/CAZys_analysis.xlsx", 
                             sheet = "Sheet3", col_types = c("text", 
                                                             "text", "numeric", "numeric", "numeric", 
                                                             "numeric"))

(Cazy_FCW <- CAZys_analysis %>%
    pivot_longer(cols = starts_with(c("AG","CAG")),
                 names_to = "AG_group",
                 values_to = "counts")
)               

p2 <- ggplot(Cazy_FCW) + geom_bar(aes(x=AG_group, y = counts, fill=Family), 
                             position = "stack", stat = "identity") + xlab("Rhizoctonia isolate") + ylab("Number of FCW associated CAZYmes") + facet_wrap(. ~ Family, ncol = 1) +
  ggtitle("Fungal Cell Wall")

p2 + theme(axis.title.x = element_text(size = 12)) + theme(axis.title.y = element_text(size = 12)) +
  theme(plot.title = element_text(face = "bold", size = 16, hjust = 0.5)) + theme(axis.text.x = element_text(size = 11, colour = "black")) +
                                                                                    theme(axis.text.y = element_text(size = 11, colour = "black")) +
                                                                                    theme(strip.text = element_text(size = 12, colour = "black"))



## cowplot function
plot_grid(p1, p2)

## patchwork function
#p1 + p2 + plot_layout(nrow = 1)
