## To update the airport country list, run the chunk below
airports <- read_csv("https://ourairports.com/data/airports.csv")
apt_countries <- airports %>% select(ICAO = ident, COUNTRY = iso_country)
#write_csv(apt_countries, "data-raw/airports_countries.csv")

flight_list <- ds %>% mutate(DATE = date(ATOT)) %>% select(ADEP, ADES, DATE)
flight_list <- merge(flight_list, apt_countries, by.x = "ADES", by.y = "ICAO") %>%
  mutate(FLIGHT_TYPE = case_when(COUNTRY == "BR" ~ "DOMESTIC", TRUE ~ "INTERNATIONAL"))
flt_type_per_day <- flight_list %>% group_by(DATE, FLIGHT_TYPE) %>% summarise(N = n())

flt_type_curve <- flt_type_per_day %>% ggplot(aes(x=DATE)) +
  geom_line(aes(y = N, color = FLIGHT_TYPE)) +
  labs( title = "Daily Departures"
        , x = "Date", y = "Departures"
        , caption = "Source: DECEA & EUROCONTROL") +
  theme_minimal()

flt_type_curve
