# Undernourishment

# 1) Load the Required Libraries

# Solve package loading issues with options(timeout = 600) 
# increase download length time

library(readxl)
library(readr)
library(tidyverse)
library(ggplot2)
library(janitor)
library(tidyverse)
library(tidyr)
library(tidyr)
library(scales)
library(devtools)
#devtools::install_github('bbc/bbplot')
#library(bbplot)
#install.packages("wordcloud")
library(wordcloud)
# install.packages("ggwordcloud")
library(ggwordcloud)
# install.packages("treemapify")
library(treemapify)
# install.packages("ggrepel")
library(ggrepel)
library(patchwork)
library(stringr)
library(magick)
library(tidyverse)
library(ggstream)
library(showtext)
library(ggtext)

# 2) Data Cleaning and Organization

# Load and clean the required data sets

undernourishment <- read_csv("sub_pro_13_agriculture_owid/processed_tables/prevalence-of-undernourishment.csv")

# Clean the column headings

undernourishment_clean <- undernourishment %>%
  clean_names()

# Change the column title names

undernourishment_clean <- undernourishment_clean %>%
  rename("country" = "entity",
         "undernourishment_percent" = "prevalence_of_undernourishment_percent_of_population") 

# Filter by income

undernourishment_clean_income_1 <- undernourishment_clean %>%
  filter(is.na(code) | code == "OWID_WRL") %>%
  select(c(1,3,4)) 

# 1080 by 1080 square plot

# 3) Line chart for income

undernourishment_clean_income_2 <- undernourishment_clean_income_1 %>%
  filter(country %in% c("High-income countries", 
                        "Low-income countries", 
                        "Lower-middle-income countries", 
                        "Middle-income countries",
                        "Upper-middle-income countries",
                        "World"))

undernourishment_clean_income_2 %>%
  ggplot(aes(year, undernourishment_percent, group = country, color = country)) + 
  geom_line(size = 2) +
  geom_point(size = 4) +
  labs(x = "Year",
       y = "Percentage (%) ",
       title = "Share of the worldwide population that\nis undernourished (by income)",
       subtitle = "",
       caption = "Data Source: Our World in Data    |     By @afro_dataviz") +
  theme_classic() +
  scale_fill_brewer(palette = "Set1") +
  scale_color_brewer(palette = "Set1") +
# scale_y_continuous(limits = c(0, 200000000), labels  = 
#                    label_number(scale = 1e-6)) +
  theme(axis.title.x =element_text(size = 28, vjust = 1, face = "bold"),
        axis.title.y =element_text(size = 28,  vjust = 1, face = "bold"),
        axis.text.x = element_text(size = 28, face = "bold", color = "black"),
        axis.text.y = element_text(size = 28, face = "bold", color = "black"),
        plot.title = element_text(family="Helvetica", face="bold", size = 40, colour = "#000000", hjust = 0.5),
        plot.subtitle = element_text(family="Helvetica", face="bold", size = 15),
        plot.caption = element_text(family = "Helvetica",size = 24, hjust = 0.5, vjust = 1),
        plot.background = element_rect(fill = "bisque1", colour = "bisque1"),
        panel.background = element_rect(fill = "bisque1", colour = "bisque1"),
        legend.title = element_blank(),
        legend.text = element_text(size = 20),
        legend.background = element_rect("bisque1"),
        legend.position = c(.90, 1),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6))

ggsave("sub_pro_13_agriculture_owid/images/undernourished_income.png", width = 12, height = 12, dpi = 72)

# Filter by region

undernourishment_clean_region <- undernourishment_clean %>%
  filter(grepl('(WB)', country) | country == "World")

undernourishment_clean_region %>%
  ggplot(aes(year, undernourishment_percent, group = country, color = country)) + 
  geom_line(size = 2) +
  geom_point(size = 4) +
  labs(x = "Year",
       y = "Percentage (%) ",
       title = "Share of the worldwide population that\nis undernourished (by region)",
       subtitle = "",
       caption = "Data Source: Our World in Data    |     By @afro_dataviz") +
  theme_classic() +
  # scale_y_continuous(limits = c(0, 200000000), labels  = 
  #                    label_number(scale = 1e-6)) +
  theme(axis.title.x =element_text(size = 28, vjust = 1, face = "bold"),
        axis.title.y =element_text(size = 28,  vjust = 1, face = "bold"),
        axis.text.x = element_text(size = 28, face = "bold", color = "black"),
        axis.text.y = element_text(size = 28, face = "bold", color = "black"),
        plot.title = element_text(family="Helvetica", face="bold", size = 40, colour = "#000000", hjust  = 0.5),
        plot.subtitle = element_text(family="Helvetica", face="bold", size = 15),
        plot.caption = element_text(family = "Helvetica",size = 24, hjust = 0.5, vjust = 1),
        plot.background = element_rect(fill = "bisque1", colour = "bisque1"),
        panel.background = element_rect(fill = "bisque1", colour = "bisque1"),
        legend.title = element_blank(),
        legend.text = element_text(size = 20),
        legend.background = element_rect("bisque1"),
        legend.position = c(.90, 1),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6))

ggsave("sub_pro_13_agriculture_owid/images/undernourished_region.png", width = 12, height = 12, dpi = 72)

# 1080 by 1920 portrait plot

# 3) Line chart for income

undernourishment_clean_income_2 <- undernourishment_clean_income_1 %>%
  filter(country %in% c("High-income countries", 
                        "Low-income countries", 
                        "Lower-middle-income countries", 
                        "Middle-income countries",
                        "Upper-middle-income countries",
                        "World"))

undernourishment_clean_income_2 %>%
  ggplot(aes(year, undernourishment_percent, group = country, color = country)) + 
  geom_line(size = 2) +
  geom_point(size = 4) +
  labs(x = "Year",
       y = "Percentage (%) ",
       title = "Share of the worldwide population\nthat is undernourished (by income)",
       subtitle = "",
       caption = "Data Source: Our World in Data    |     By @afro_dataviz") +
  theme_classic() +
  scale_fill_brewer(palette = "Set1") +
  scale_color_brewer(palette = "Set1") +
  # scale_y_continuous(limits = c(0, 200000000), labels  = 
  #                    label_number(scale = 1e-6)) +
  theme(axis.title.x =element_text(size = 28, vjust = 1, face = "bold"),
        axis.title.y =element_text(size = 28,  vjust = 1, face = "bold"),
        axis.text.x = element_text(size = 28, face = "bold", color = "black"),
        axis.text.y = element_text(size = 28, face = "bold", color = "black"),
        plot.title = element_text(family="Helvetica", face="bold", size = 32, colour = "#000000", hjust = 0.5),
        plot.subtitle = element_text(family="Helvetica", face="bold", size = 15),
        plot.caption = element_text(family = "Helvetica",size = 24, vjust = 1),
        plot.background = element_rect(fill = "bisque1", colour = "bisque1"),
        panel.background = element_rect(fill = "bisque1", colour = "bisque1"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24),
        legend.background = element_rect("bisque1"),
        legend.position = c(.92, 1),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6))

ggsave("sub_pro_13_agriculture_owid/images/undernourished_income_portrait.png", width = 9, height = 16, dpi = 72)

# Filter by region

undernourishment_clean_region <- undernourishment_clean %>%
  filter(grepl('(WB)', country) | country == "World")

undernourishment_clean_region %>%
  ggplot(aes(year, undernourishment_percent, group = country, color = country)) + 
  geom_line(size = 2) +
  geom_point(size = 4) +
  labs(x = "Year",
       y = "Percentage (%) ",
       title = "Share of the worldwide population\nthat is undernourished (by region)",
       subtitle = "",
       caption = "Data Source: Our World in Data    |     By @afro_dataviz") +
  theme_classic() +
  # scale_y_continuous(limits = c(0, 200000000), labels  = 
  #                    label_number(scale = 1e-6)) +
  theme(axis.title.x =element_text(size = 28, vjust = 1, face = "bold"),
        axis.title.y =element_text(size = 28,  vjust = 1, face = "bold"),
        axis.text.x = element_text(size = 28, face = "bold", color = "black"),
        axis.text.y = element_text(size = 28, face = "bold", color = "black"),
        plot.title = element_text(family="Helvetica", face="bold", size = 32, colour = "#000000", hjust  = 0.5),
        plot.subtitle = element_text(family="Helvetica", face="bold", size = 15),
        plot.caption = element_text(family = "Helvetica",size = 24, vjust = 1),
        plot.background = element_rect(fill = "bisque1", colour = "bisque1"),
        panel.background = element_rect(fill = "bisque1", colour = "bisque1"),
        legend.title = element_blank(),
        legend.text = element_text(size = 22),
        legend.background = element_rect("bisque1"),
        legend.position = c(.98, 1),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6))

ggsave("sub_pro_13_agriculture_owid/images/undernourished_region_portrait.png", width = 9, height = 16, dpi = 72)
