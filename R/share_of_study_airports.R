library(readr)
library(dplyr)
library(scales)
library(tidyverse)


bra_apts <- c("SBBR","SBGR","SBSP","SBKP","SBRJ","SBGL","SBCF","SBSV","SBPA","SBCT")

SBGR_2019 <- c("SBGR", "Guarulhos", 298207, -0.6)
SBSP_2019 <- c("SBSP", "Congonhas", 222784, -2.7)
SBBR_2019 <- c("SBBR", "Brasilia", 154331, -6.2)
SBKP_2019 <- c("SBKP", "Campinas", 117458, 5.4)
SBRJ_2019 <- c("SBRJ", "Santos Dumont", 114825, -2.5)
SBGL_2019 <- c("SBGL", "Galeao", 107900, -7.6)
SBCF_2019 <- c("SBCF", "Confins", 102349, 0.2)
SBJR_2019 <- c("SBJR", "Jacarepagua", 86253, 4.1)
SBRF_2019 <- c("SBRF", "Recife", 84490, 2.9)
SBPA_2019 <- c("SBPA", "Porto Alegre", 82461, -4.1)
SBSV_2019 <- c("SBSV", "Salvador", 79684, -4.6)
SBMT_2019 <- c("SBMT","Campo de Marte", 76599, -12.0)
SBCT_2019 <- c("SBCT", "Curitiba", 70416, 1.7)
SBFZ_2019 <- c("SBFZ", "Fortaleza", 60800, 0.7)
SBGO_2019 <- c("SBGO", "Goiania", 59201, -15.9)
SBFL_2019 <- c("SBFL", "Florianopolis", 46358, -7.3)
SBVT_2019 <- c("SBVT", "Vitoria", 45204, -3.7)
SBBE_2019 <- c("SBBE", "Belem", 43335, 0.0)
SBBH_2019 <- c("SBBH", "Pampulha", 43115, -1.2)
SBEG_2019 <- c("SBEG", "Manaus", 41801, 1.6)
SBNF_2019 <- c("SBNF", "Navegantes", 33377, -4.2)
SBCG_2019 <- c("SBCG", "Campo Grande", 33001, -3.9)
SBRP_2019 <- c("SBRP", "Ribeirao Preto",31149, -4.5)
SBUL_2019 <- c("SBUL", "Uberlandia", 28141, -4.4)
SBSJ_2019 <- c("SBSJ", "Sao Jose dos Campos", 26758, 1.0)
SBLO_2019 <- c("SBLO", "Londrina", 25463, -13.2)
SBFI_2019 <- c("SBFI", "Foz do Iguacu", 21956, -2.1)
SBSL_2019 <- c("SBSL", "Sao Luis", 20433, -2.8)
SBMO_2019 <- c("SBMO", "Maceio", 18459, -3.3)
SBPJ_2019 <- c("SBPJ", "Palmas", 11949, -10.2)
SBJV_2019 <- c("SBJV", "Joinville", 8431, -6.5)
SBUR_2019 <- c("SBUR", "Uberaba", 6233, -1.0)

ds <- rbind(SBGR_2019, SBSP_2019, SBBR_2019, SBKP_2019, SBRJ_2019, SBGL_2019, SBCF_2019, SBJR_2019, SBRF_2019, SBPA_2019, SBSV_2019, SBMT_2019, SBCT_2019, SBFZ_2019, SBGO_2019, SBFL_2019, SBVT_2019, SBBE_2019, SBBH_2019, SBEG_2019, SBNF_2019, SBCG_2019, SBRP_2019, SBUL_2019, SBSJ_2019, SBLO_2019, SBFI_2019, SBSL_2019, SBMO_2019, SBPJ_2019, SBJV_2019, SBUR_2019)
colnames(ds) <- c("APT_ICAO", "APT_NAME", "N_MOV", "VAR_TO_2018")
rownames(ds) <- c(NULL)
ds <- data.frame(ds)
ds <- ds %>% 
  transmute(APT_ICAO = as.factor(APT_ICAO),
            APT_NAME = APT_NAME,
            YEAR = as.factor(2019),
            N_MOV = as.numeric(N_MOV),
            VAR_TO_2018 = as.numeric(VAR_TO_2018)) %>%
  mutate(IN_STUDY = case_when(APT_ICAO %in% bra_apts ~ "In study", TRUE ~ "Out of scope"), SHARE = (N_MOV/sum(N_MOV)))

summ_ds <- ds %>% group_by(YEAR, IN_STUDY) %>% summarise(TOTAL = sum(N_MOV), groups = "drop")

g1 <- summ_ds %>% ggplot(aes(x=YEAR)) +
  geom_col(aes(y = TOTAL, fill = IN_STUDY))+
  geom_label(aes(label = percent(TOTAL/sum(TOTAL), accuracy = 0.1), y = TOTAL-250000, color = IN_STUDY)) +
  theme(legend.title = element_blank()) + 
  theme_minimal()

ds
g1