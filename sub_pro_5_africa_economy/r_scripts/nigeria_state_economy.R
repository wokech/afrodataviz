# An analysis of Nigerian states by GDP

## Include an explanation of data and a map....

# (A) Load the required libraries

library(tidyverse)
library(rvest)
library(stringr)
library(janitor)
library(gghighlight)
library(readr)

# To export the images
# camcorder::gg_record()

library(camcorder)

gg_record(
  dir = 'sub_pro_5_africa_economy/images',
  width = 12,
  height = 12 * 9 / 16,
  dpi = 300,
  bg = 'white'
)

# (B) Get the data from Wikipedia

link <- "https://en.wikipedia.org/wiki/List_of_Nigerian_states_by_GDP"
nigeria_state <- link %>%
  read_html("[class='wikitable sortable']") %>% 
  html_table(fill = TRUE)

nigeria_state_GDP <- nigeria_state[[1]]

# (C) Clean the data, fix columns and county labels

nigeria_state_GDP_clean <- nigeria_state_GDP %>%
  clean_names() %>%
  mutate(state = str_remove_all(state, " State| state"))

# parsing out the number is very critical as a simple conversion using 
# as._____() will not work

str(nigeria_state_GDP_clean)

#nigeria_state_GDP_clean$gdp_in_trillions_of_naira <- parse_number(nigeria_state_GDP_clean$gdp_in_trillions_of_naira)
#nigeria_state_GDP_clean$gdp_in_billion_of_us_dollar_official_exchange <- parse_number(nigeria_state_GDP_clean$gdp_in_billion_of_us_dollar_official_exchange)
#nigeria_state_GDP_clean$gdp_ppp_in_billion_of_us_dollar <- parse_number(nigeria_state_GDP_clean$gdp_ppp_in_billion_of_us_dollar)
nigeria_state_GDP_clean$gdp_percapita_in_us_dollar_official_exchange <- parse_number(nigeria_state_GDP_clean$gdp_percapita_in_us_dollar_official_exchange)
nigeria_state_GDP_clean$ppp_percapita_in_us_dollar <- parse_number(nigeria_state_GDP_clean$ppp_percapita_in_us_dollar)

str(nigeria_state_GDP_clean)

# Plot 1

ggplot(nigeria_state_GDP_clean, aes(reorder(state, +gdp_in_billion_of_us_dollar_official_exchange), gdp_in_billion_of_us_dollar_official_exchange, fill = state)) +
  geom_bar(stat = "identity") + coord_flip() +
  gghighlight(max(gdp_in_billion_of_us_dollar_official_exchange) > 19.2) + 
  scale_fill_brewer(palette="OrRd") +
  labs(x = "County",
       y = "GDP (billions of US$)",
       title = "",
       subtitle = "",
       caption = "") +
  theme_classic() +
  scale_y_continuous(labels = comma) +
  theme(axis.title.x =element_text(size = 20),
        axis.title.y =element_text(size = 20),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 10),
        plot.title = element_text(family="Helvetica", face="bold", size = 20),
        plot.subtitle = element_text(family="Helvetica", face="bold", size = 15),
        plot.caption = element_text(family = "Helvetica",size = 12, face = "bold"),
        plot.background = element_rect(fill = "azure2", colour = "azure2"),
        panel.background = element_rect(fill = "azure2", colour = "azure2"),
        legend.title = element_blank(),
        legend.position = "none") 
