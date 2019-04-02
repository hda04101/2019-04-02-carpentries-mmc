library(here)
library(tidyverse)

gapminder <- readr::read_csv(here("data/gapminder/raw/gapminder_data.csv"))

mean(gapminder$gdpPercap[gapminder$continent == "Africa"])
mean(gapminder$gdpPercap[gapminder$continent == "Americas"])

# more efficient method
year_country_gdp <- select(gapminder, year, country, gdpPercap)

year_country_gdp <- gapminder %>%
  select(year, country, gdpPercap, continent) %>%
  filter(continent == "Europe")


#alternative filter first then keep
year_country_gdp <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)
 
year_country_gdp <- gapminder %>%
  filter(continent == "Africa") %>%
  select(year, country, lifeExp)


# group_by
 gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap =mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap)
            ) 

 
# challenge 2
 gapminder %>%
   group_by(country) %>%
   summarize(mean_lifeExp =mean(lifeExp)) %>%
   filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))
   

 
 # 
# ggplot code:
   ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) +
   geom_line() +
   facet_wrap( ~ country)
 



