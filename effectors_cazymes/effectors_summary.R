library(ggplot2)
library(readxl)

effectors <- read_excel("Secretome/effectorp/effectors_summary.xlsx", sheet = "Figure_data", range = "A1:C17")
head(effectors)
effectors$AG_group <- factor(effectors$AG_group, levels = unique(effectors$AG_group))


p1 <- ggplot(effectors, aes(fill=Effector_type, y=Effector_count, x=AG_group)) +
                                  geom_bar(position = "stack", stat = "identity") + #coord_flip() +
  labs(y="Effector count") +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_text(size = 18)) +
  theme(axis.text.x = element_text(size = 12), axis.text.y = element_text(size = 16))

(p2 <- p1 + scale_fill_discrete(name = "Effector type"))
p2

secreted_prot <- read_excel("Secretome/effectorp/effectors_summary.xlsx", sheet = "Figure_summary_prot", range = "A1:D17")

secreted_prot$Protein_type <- factor(secreted_prot$Protein_type, levels = c("Secreted", "Effector"))
secreted_prot$AG_group <- factor(secreted_prot$AG_group, levels = unique(effectors$AG_group))

p3 <- ggplot(secreted_prot, aes(fill=Protein_type, y=Protein_count, x=AG_group)) +
  geom_bar(position = "dodge", stat = "identity") + #coord_flip() +
  geom_text(aes(label=Percent_effectors), position = position_dodge(width = 0.9), vjust=0.001) +
  labs(y="Protein count") +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_text(size = 18)) +
  theme(axis.text.x = element_text(size = 12), axis.text.y = element_text(size = 16))

(p4 <- p3 + scale_fill_discrete(name = "Protein type", direction = -1))
p4
