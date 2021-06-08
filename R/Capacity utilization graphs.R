#Had to change the original objects' (dataframe) names 
#in this script to match the csv file name

#necessary packages:
library(tidyverse)
library(patchwork)

#Use the next lines below only to build the average lines.
#The corresponding geoms are 
#deactivated (commented #) in the graph codes

#max_cap_avg_bra <- mean(bra_arrs_cap_util$MAX_CAP)
#max_n_avg_bra <- mean(bra_arrs_cap_util$MAX_N)
#max_cap_avg_eur <- mean(eur_arrs_cap_util$MAX_CAP)
#max_n_avg_eur <- mean(eur_arrs_cap_util$MAX_N)
#avg_util_rate_bra <- scales::percent(mean(bra_arrs_cap_util$UTIL_RATE), accuracy = 0.1)
#avg_util_rate_eur <- scales::percent(mean(eur_arrs_cap_util$UTIL_RATE), accuracy = 0.1)

#Brazilian graph
g1 <- bra_arrs_cap_util %>%
  ggplot(aes(y=reorder(APT_ICAO, MAX_CAP))) +
  geom_col(aes(x = MAX_CAP), color = "darkblue", fill = "royalblue4") + 
  geom_col(aes(x = MAX_N), color = "royalblue4", fill = "lightblue", alpha = .9, width = .7) +
  geom_text(aes(x = MAX_N, label = scales::percent(UTIL_RATE, accuracy = 1)), hjust = 1.1) +
  geom_text(aes(x = MAX_CAP, label = MAX_CAP), hjust = 1.1, color = "white" )+
  #geom_vline(aes(xintercept = max_cap_avg_bra), linetype = 2) +
  #geom_vline(aes(xintercept = max_n_avg_bra), linetype = 3) +
  #annotate("text", x = max_cap_avg_bra + 1, y = 2, label = paste0("The\nmax cap\naverage is\n", round(max_cap_avg_bra, 1)), hjust = "left", size = 3) +
  #annotate("rect", xmin = max_n_avg_bra - 5.2, xmax = max_n_avg_bra - 0.1, ymin = 8.7, ymax = 10.3, alpha = 0.7) +
  #annotate("text", x = max_n_avg_bra - 0.5, y = 9.55, label = paste0("The\nutil rate\naverage is\n", avg_util_rate_bra), hjust = "right", size = 3, color = "white") +
  labs(x = NULL, y = NULL) +
  #scale_x_continuous() +
  theme_minimal()
#g1

  #European graph
g2 <- eur_arrs_cap_util %>%
  ggplot(aes(y=reorder(APT_ICAO, MAX_CAP))) +
  geom_col(mapping = aes(x = MAX_CAP), color = "darkgreen", fill = "aquamarine4") + 
  geom_col(mapping = aes(x = MAX_N), color = "aquamarine4", fill = "aquamarine1", alpha = .9, width = .7) +
  geom_text(mapping = aes(x = MAX_N, label = scales::percent(UTIL_RATE, accuracy = 1)), hjust = 1.1) +
  geom_text(mapping = aes(x = MAX_CAP, label = MAX_CAP), hjust = 1.1, color = "white" )+
  #geom_vline(aes(xintercept = max_cap_avg_eur), linetype = 2) +
  #geom_vline(aes(xintercept = max_n_avg_eur), linetype = 3) +
  #annotate("text", x = max_cap_avg_eur + 1, y = 2, label = paste0("The\nmax cap\naverage is\n", round(max_cap_avg_eur, 1)), hjust = "left", size = 3) +
  #annotate("rect", xmin = max_n_avg_eur + 0.1, xmax = max_n_avg_eur + 10.5, ymin = 4.7, ymax = 6.3, alpha = 0.7) +
  #annotate("text", x = max_n_avg_eur + 0.5, y = 5.55, label = paste0("The\nutil rate\naverage is\n", avg_util_rate_eur), hjust = "left", size = 3, color = "white") +
  labs(x = NULL, y = NULL)+
  #scale_x_continuous() +
  theme_minimal()
#g2

g2 / g1 + labs(x = "Maximum and utilized throughput")
