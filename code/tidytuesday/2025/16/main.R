
library(tidyverse)
library(plotly)

daily_accidents_420 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents_420_time.csv')

DT::datatable(daily_accidents_420 %>% rename_with(~c("Date", "d420", "Fatalities Count")))


table1 = daily_accidents_420  %>%
  pivot_wider(
    names_from = d420,
    values_from = fatalities_count,
  ) %>%
  rename(d420_false = `FALSE`, d420_true = `TRUE`, d420_na = `NA`) %>%
  mutate(year = year(date), month = month(date, label = TRUE), day = day(date)) %>% 
  rowwise() %>%
  mutate(d_total = sum(d420_false, d420_true, ifelse(is.na(d420_na),0,d420_na)))

DT::datatable(table1 %>% rename_with(~c("Date", "d420_false", "d420_true", "d420_na", "Year", "Month", "Day", "Fatalities Count")), class = 'cell-border stripe')

ggplot(daily_accidents_420, aes(x = date, y = fatalities_count, color = d420)) + 
  geom_point(aes(color = d420, shape = d420)) +
  labs(
    title = "Fatalities Count",
    color = "Accident between 4:20pm and 11:59pm", 
    shape = "Accident between 4:20pm and 11:59pm",
    x = "Date", 
    y = "Fatalities",
    tag = "Figure 1"
  ) +
  theme(legend.box = "horizontal", legend.position = "bottom")

ggplot(daily_accidents_420, aes(x = date, y = fatalities_count, color = d420)) + 
  geom_smooth(aes(color = d420)) + 
  geom_smooth(method = "lm", aes(x = date, y = fatalities_count, color = "Overall Fatalities")) + 
  labs(
    title = "Fatalities Trend",
    color = "Accident between 4:20pm and 11:59pm", 
    x = "Date", 
    y = "Fatalities",
    tag = "Figure 2"
  ) +
  theme(legend.box = "horizontal", legend.position = "bottom")

p = ggplot(table1, aes(x = year, y = month, fill = d_total)) + 
  geom_tile() + 
  scale_fill_gradient(low="white", high="red") +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
  labs(
    title = "Heatmap of accidents cooresponding to Year and Month",
    fill = "Fatalities",
    x = "Year", y = "Month",
    tag = "Figure 3"
  ) + 
  theme_classic(base_size = 8, base_family = "JetBrains Mono")

plotly::ggplotly(p)

DT::datatable(
  table1 %>%
    arrange(desc(d_total)) %>%
    select(year,month,day,d_total) %>%
    rename("Fatalities Count" = d_total)  
)