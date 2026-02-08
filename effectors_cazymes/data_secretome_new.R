setwd("Secretome")
library(here)
library(tidyverse)

here::i_am("data_secretome_new.R")

#SignalP data
read_signalP <- function(x){
  read_delim(x, "\t", escape_double = FALSE, trim_ws = TRUE, 
             skip = 1) %>% 
    rename(ID = `# ID`)
}

AG_A.signalP <- read_signalP("signalp/AG-A_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")

AG_E.signalP <- read_signalP("signalp/AG-E_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")

AG_K.signalP <- read_signalP("signalp/AG-K_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")

CAG_3.signalP <- read_signalP("signalp/CAG-3_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")

CAG_6.signalP <- read_signalP("signalp/CAG-6_NGSEP_polished2.all.maker.proteins.putative_function_summary.signalp5")

AG_I.signalP <- read_signalP("signalp/AG-I_signalp_summary.signalp5")

HG81.signalP <- read_signalP("signalp/HG81_signalp_summary.signalp5")

#TMHMM data
read_tmhmm <- function(x){
  read_delim(x, 
             "\t", escape_double = FALSE, trim_ws = TRUE, 
             col_names = FALSE) %>%
    mutate(across(X2:X6, function(x) gsub(".*=","",x))) %>%
    mutate(across(X2:X5, as.double)) %>%
    rename(ID=X1, len=X2, ExpAA=X3, First60=X4, PredHel=X5, Topology=X6)
}

AG_A_tmhmm <- read_tmhmm("tmhmm/AG-A_tmhmm.out")

AG_E_tmhmm <- read_tmhmm("tmhmm/AG-E_tmhmm.out")

AG_K_tmhmm <- read_tmhmm("tmhmm/AG-K_tmhmm.out")

CAG_3_tmhmm <- read_tmhmm("tmhmm/CAG-3_tmhmm.out")

CAG_6_tmhmm <- read_tmhmm("tmhmm/CAG-6_tmhmm.out")

AG_I_tmhmm <- read_tmhmm("tmhmm/AG-I_tmhmm.out")

HG81_tmhmm <- read_tmhmm("tmhmm/HG81_tmhmm.out")

#TargetP data
read_targetP <- function(x){
  read_delim(x, "\t", escape_double = FALSE, trim_ws = TRUE, 
             skip = 1) %>% 
    rename(ID = `# ID`)
}

AG_A.targetP <- read_targetP("targetp/AG-A_signalp_targetp_summary.targetp2")

AG_E.targetP <- read_targetP("targetp/AG-E_signalp_targetp_summary.targetp2")

AG_K.targetP <- read_targetP("targetp/AG-K_signalp_targetp_summary.targetp2")

CAG_3.targetP <- read_targetP("targetp/CAG-3_signalp_targetp_summary.targetp2")

CAG_6.targetP <- read_targetP("targetp/CAG-6_signalp_targetp_summary.targetp2")

AG_I.targetP <- read_targetP("targetp/AG-I_signalp_targetp_summary.targetp2")

HG81.targetP <- read_targetP("targetp/HG81_signalp_targetp_summary.targetp2")

##Filter data
AG_A_targetP_filtered <- AG_A.targetP %>% filter(`Prediction` == 'noTP')
AG_E_targetP_filtered <- AG_E.targetP %>% filter(`Prediction` == 'noTP')
AG_K_targetP_filtered <- AG_K.targetP %>% filter(`Prediction` == 'noTP')
CAG_3_targetP_filtered <- CAG_3.targetP %>% filter(`Prediction` == 'noTP')
CAG_6_targetP_filtered <- CAG_6.targetP %>% filter(`Prediction` == 'noTP')
AG_I_targetP_filtered <- AG_I.targetP %>% filter(`Prediction` == 'noTP')
HG81_targetP_filtered <- HG81.targetP %>% filter(`Prediction` == 'noTP')

##SignalP vs TMHMM
#This will produce a table with all the proteins with a signal peptide with a 
# probability higher than 0.5 (SP(Sec/SPI)) and merge with the one from TMHMM
AG_A_signalP_TM <- AG_A.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(AG_A_tmhmm, by="ID") %>%
  left_join(AG_A_targetP_filtered, by= "ID")

AG_E_signalP_TM <- AG_E.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(AG_E_tmhmm, by="ID") %>%
  left_join(AG_E_targetP_filtered, by= "ID")

AG_K_signalP_TM <- AG_K.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(AG_K_tmhmm, by="ID") %>%
  left_join(AG_K_targetP_filtered, by= "ID")

CAG_3_signalP_TM <- CAG_3.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(CAG_3_tmhmm, by="ID") %>%
  left_join(CAG_3_targetP_filtered, by= "ID")

CAG_6_signalP_TM <- CAG_6.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(CAG_6_tmhmm, by="ID") %>%
  left_join(CAG_6_targetP_filtered, by= "ID")

AG_I_signalP_TM <- AG_I.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(AG_I_tmhmm, by="ID") %>%
  left_join(AG_I_targetP_filtered, by= "ID")

HG81_signalP_TM <- HG81.signalP %>% filter(`SP(Sec/SPI)` >= 0.5) %>%
  left_join(HG81_tmhmm, by="ID") %>%
  left_join(HG81_targetP_filtered, by= "ID")

#Filter those that lack TMHMM but have signal peptide
AG_A_filtered <- AG_A_signalP_TM %>% 
  filter(ExpAA < 10)

AG_E_filtered <- AG_E_signalP_TM %>% 
  filter(ExpAA < 10)

AG_K_filtered <- AG_K_signalP_TM %>% 
  filter(ExpAA < 10)

CAG_3_filtered <- CAG_3_signalP_TM %>% 
  filter(ExpAA < 10)

CAG_6_filtered <- CAG_6_signalP_TM %>% 
  filter(ExpAA < 10)

AG_I_filtered <- AG_I_signalP_TM %>% 
  filter(ExpAA < 10)

HG81_filtered <- HG81_signalP_TM %>% 
  filter(ExpAA < 10)

#Save final files
write.table(AG_A_filtered, file = "Secretome/AG_A_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(AG_E_filtered, file = "Secretome/AG_E_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(AG_K_filtered, file = "Secretome/AG_K_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(CAG_3_filtered, file = "Secretome/CAG_3_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(CAG_6_filtered, file = "Secretome/CAG_6_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(AG_I_filtered, file = "Secretome/AG_I_secretome.tsv",
            sep = "\t", quote = FALSE)

write.table(HG81_filtered, file = "Secretome/HG81_secretome.tsv",
            sep = "\t", quote = FALSE)