# The dataset is "ds"

daily_traffic <- function(.ds){
  
  DLY_DEP <- .ds %>% group_by(DATE = date(ATOT)) %>%
    summarise(N_DEP =  n(), .groups = "drop") %>%
    mutate( ROLLSEV = rollmean(x=N_DEP, k=7, fill = NA)
          , WEEKDAY = weekdays(DATE, abbreviate = TRUE)
          , WEEKEND = (WEEKDAY == "Sat" | WEEKDAY == "Sun")) %>%
    filter(!is.na(WEEKEND))
  
  DLY_DEP_CURVE <- DLY_DEP %>% ggplot(aes(x=DATE)) +
    geom_point(aes(y = N_DEP, color = WEEKEND)) +
    geom_line(aes(y = ROLLSEV), color = "royalblue4") +
    labs( title = "Daily Departures"
         , x = "Date", y = "Departures"
         , caption = "Source: DECEA & EUROCONTROL") +
    theme_minimal()
  
  return(DLY_DEP_CURVE)
}