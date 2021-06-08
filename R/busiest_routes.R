## Busiest routes
# Choose your "top" below by changing the value of N (i.e. for a Top 10, select N = 10)

plot_busiest_routes <- function(.ds, .N = 10){

  CTY_PRS <- .ds %>% select(ADEP, ADES) %>% 
    group_by(ADEP, ADES) %>% 
    summarise(NUM_FLTS = n()) %>% 
    arrange(desc(NUM_FLTS))

  TOP_CTY_PRS <- CTY_PRS[1:.N,]
  TOP_CTY_PRS <- TOP_CTY_PRS %>% 
    mutate(Route = paste(ADEP, ADES, sep = "-"))

  g <- TOP_CTY_PRS %>% ggplot() +
  geom_col(aes(reorder(Route, NUM_FLTS),NUM_FLTS), fill = "royalblue4") +
  geom_label(aes(x = Route, y = NUM_FLTS, label = NUM_FLTS), color = "royalblue4") +
  labs(title = "Brazil Top routes", x = "Routes", y = "Flights", caption = "Developed by Fábio Barbosa") +
  coord_flip() +
  theme_minimal()

return(g)
}
