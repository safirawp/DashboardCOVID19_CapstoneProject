library(tidyverse)
library(scales)
library(lubridate)
options(scipen=123)
library(DT)
library(shiny)
library(shinydashboard)
library(echarts4r)
options(shiny.maxRequestSize=200*1024^2)

# Read data
covid19_allcol <- read.csv("data_input/owid-covid-data.csv", stringsAsFactors = T)

# Cleansing Data
covid19 <- covid19_allcol %>% 
  select(c(iso_code, continent, location, date, total_cases, new_cases, total_deaths, new_deaths, people_vaccinated, people_fully_vaccinated, total_boosters, population)) %>%
  mutate(
    date = mdy(date),
    covid_per_population = total_cases/population * 100
  )

# Data Global
covid19_world <- filter(.data = covid19,
                        location == "World")

# Data Country
covid19_country <- filter(.data = covid19,
                          continent != "")

# Total Cases Global (Lastest)
total_cases_updated <- covid19_world %>%
  filter(date=="2022-04-30") %>%
  select(c(total_cases))

# Total New Cases Global (Lastest)
new_cases_updated <-covid19_world %>%
  filter(date=="2022-04-30") %>%
  select(c(new_cases))

# Total Deaths Global (Lastest)
total_deaths_update <- covid19_world %>%
  filter(date=="2022-04-30") %>%
  select(c(total_deaths))

# Total New Deaths Global (Lastest)
new_deaths_update <-covid19_world %>%
  filter(date=="2022-04-30") %>%
  select(c(new_deaths))

# Total Cases Country (Lastest)
country_cases <- covid19_country %>% 
  select(c(date,location,total_cases)) %>% 
  filter(date == "2022-04-30") %>% 
  arrange(total_cases) %>% 
  top_n(20)

# Total Deaths Country (Lastest)
country_deaths <- covid19_country %>% 
  select(c(date,location,total_deaths)) %>% 
  filter(date == "2022-04-30") %>% 
  arrange(total_deaths) %>% 
  top_n(20)

# Total Cases Per Population Country (Lastest)
country_casespop <- covid19_country %>% 
  select(c(date,location,covid_per_population)) %>% 
  filter(date == "2022-04-30") %>% 
  arrange(covid_per_population) %>% 
  top_n(20)



