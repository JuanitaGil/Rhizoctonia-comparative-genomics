
library(tidyverse)
library(readxl)
library(viridis)

# Read the full set of proteins
AG_A_prot <- read_excel("maker_annotations/Protein_functions_all.xlsx", sheet = "AG-A")
head(AG_A_prot)
AG_E_prot <- read_excel("maker_annotations/Protein_functions_all.xlsx", sheet = "AG-E")
AG_K_prot <- read_excel("maker_annotations/Protein_functions_all.xlsx", sheet = "AG-K")
CAG_3_prot <- read_excel("maker_annotations/Protein_functions_all.xlsx", sheet = "CAG-3")
CAG_6_prot <- read_excel("maker_annotations/Protein_functions_all.xlsx", sheet = "CAG-6")

# Read the list of effectors
AG_A_effe <- read_tsv("Secretome/effectorp/AG-A_effectors_list.txt")
head(AG_A_effe)
AG_E_effe <- read_tsv("Secretome/effectorp/AG-E_effectors_list.txt")
AG_K_effe <- read_tsv("Secretome/effectorp/AG-K_effectors_list.txt")
CAG_3_effe <- read_tsv("Secretome/effectorp/CAG-3_effectors_list.txt")
CAG_6_effe <- read_tsv("Secretome/effectorp/CAG-6_effectors_list.txt")

# Add protein function to effectors' list
AG_A_effe_function <- left_join(AG_A_effe, AG_A_prot, by="ID")
head(AG_A_effe_function)
AG_E_effe_function <- left_join(AG_E_effe, AG_E_prot, by="ID")
AG_K_effe_function <- left_join(AG_K_effe, AG_K_prot, by="ID")
CAG_3_effe_function <- left_join(CAG_3_effe, CAG_3_prot, by="ID")
CAG_6_effe_function <- left_join(CAG_6_effe, CAG_6_prot, by="ID")

# Write files of effectors with protein function
write.table(AG_A_effe_function, file = "Secretome/effectorp/AG_A_effectors_function.tsv",
            sep = "\t", quote = FALSE, row.names = F)
write.table(AG_E_effe_function, file = "Secretome/effectorp/AG_E_effectors_function.tsv",
            sep = "\t", quote = FALSE, row.names = F)
write.table(AG_K_effe_function, file = "Secretome/effectorp/AG_K_effectors_function.tsv",
            sep = "\t", quote = FALSE, row.names = F)
write.table(CAG_3_effe_function, file = "Secretome/effectorp/CAG_3_effectors_function.tsv",
            sep = "\t", quote = FALSE, row.names = F)
write.table(CAG_6_effe_function, file = "Secretome/effectorp/CAG_6_effectors_function.tsv",
            sep = "\t", quote = FALSE, row.names = F)

# Read effectors list with added protein function. I modified the files written in the previous step to rename all IDs just to the corresponding AG.
# No unique protein IDs because I want to know just families per AG
AG_A_effectors_anno <- as.data.frame(read_tsv("Secretome/effectorp/AG_A_effectors_function.tsv"))
head(AG_A_effectors_anno)
AG_E_effectors_anno <- as.data.frame(read_tsv("Secretome/effectorp/AG_E_effectors_function.tsv"))
AG_K_effectors_anno <- as.data.frame(read_tsv("Secretome/effectorp/AG_K_effectors_function.tsv"))
CAG_3_effectors_anno <- as.data.frame(read_tsv("Secretome/effectorp/CAG_3_effectors_function.tsv"))
CAG_6_effectors_anno <- as.data.frame(read_tsv("Secretome/effectorp/CAG_6_effectors_function.tsv"))

## Combine all dataframes into one table with all AGs and all effectors functions
effectors_func <- rbind(AG_A_effectors_anno, AG_E_effectors_anno, AG_K_effectors_anno, CAG_3_effectors_anno, CAG_6_effectors_anno)
dim(effectors_func)
head(effectors_func)

families_all <- read_excel("Secretome/effectorp/effectors_function_summary.xlsx", sheet = "All")

effectors_per_AG <- families_all %>% group_by(ID) %>%
 summarise(n=n()) %>% ungroup() %>% mutate(prop = n/sum(n))
effectors_per_AG

families_per_AG <- effectors_func %>% group_by(ID) %>%
  summarise(count = n_distinct(Function))
families_by_AG
dim(families_by_AG)

families_by_AG <- with(effectors_func, tapply(Function, ID, unique))
common_families <- Reduce(intersect, families_by_AG)

print(common_families)

families_by_AG <- with(effectors_func, split(ID, Function))

unique_families_by_AG <- lapply(names(families_by_AG),
function(current_AG) {
  unique_families <- setdiff(unique_families_by_AG[[current_AG]],
                             unlist(families_by_AG_new[names(families_by_AG_new) != current_AG]))
  return(unique_families)
})

names(unique_families_by_AG) <- names(families_by_AG_new)
print(unique_families_by_AG)

#Plots

# Read effectors functions
eff_function <- read_excel("Secretome/effectorp/effectors_function_summary.xlsx", sheet = "Function", range = "A1:C40")

p1 <- ggplot(eff_function, aes(fill=Function, y=Number, x=AG)) +
  geom_bar(position = "stack", stat = "identity") + #coord_flip() +
  labs(y="Effector count", x="Rhizoctonia AG group") +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 18)) +
  theme(axis.text.x = element_text(size = 16), axis.text.y = element_text(size = 16))

(p2 <- p1 + scale_fill_discrete(name = "Effector family"))

# Read effectors families
eff_families <- read_excel("Secretome/effectorp/effectors_function_summary.xlsx", sheet = "families")
head(eff_families)

eff_families$Families <- factor(eff_families$Families, levels = c("Total", "Unique"))

p3 <- ggplot(eff_families, aes(fill=Families, y=Effector_count, x=AG_Group)) +
  geom_bar(position = "dodge", stat = "identity") + #coord_flip() +
  #geom_text(aes(label=Percent_effectors), position = position_dodge(width = 0.9), vjust=-0.3, size = 5) +
  labs(y="Family count", x="Rhizoctonia AG group") +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 18)) +
  theme(axis.text.x = element_text(size = 16), axis.text.y = element_text(size = 16))

(p4 <- p3 + scale_fill_discrete(name = "Families", direction = -1))


#Read effector categories
eff_categories <- read_excel("Secretome/effectorp/effectors_function_summary.xlsx", sheet = "categories")

p5 <- ggplot(eff_categories, aes(fill=Category, y=Number, x=AG)) +
  geom_bar(position = "stack", stat = "identity") + coord_flip() +
  ylab("Effector count") + xlab("AG Group") +
  theme(legend.title = element_text(size = 18), legend.text = element_text(size = 16)) +
  theme(axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 18)) +
  theme(axis.text.x = element_text(size = 16), axis.text.y = element_text(size = 16))

(p6 <- p5 + scale_fill_manual(values = c("#440154FF", "#31688EFF", "#35B779FF", "#FDE725FF")))
