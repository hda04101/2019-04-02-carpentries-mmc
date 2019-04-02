# tidyr
# install.packages("tidyr")

# To install skimr:
install.packages("skimr")


# Create gap_wide
gap_wide <- gapminder %>%
  gather(key = 'key', value = 'value', c('pop', 'lifeExp', 'gdpPercap')) %>%
  mutate(year_var = paste(key, year, sep = '_')) %>%
  select(country, continent, year_var, value) %>%
  spread(key = 'year_var', value = 'value')

skimr::skim(gap_wide)

str(gap_wide)

gap_long <- gap_wide %>%
  gather(obstype_year, obs_values, starts_with('pop'),
         starts_with('lifeExp'), starts_with('gdpPercap'))
str(gap_long)

gap_long <- gap_wide %>% gather(obstype_year,obs_values,-continent,-country)
str(gap_long)

gap_long <- gap_long %>% separate(obstype_year,into=c('obs_type','year'),sep="_")
gap_long$year <- as.integer(gap_long$year)


#Using gap_long, calculate the mean life expectancy, population, and gdpPercap for each continent.
#Hint: use the group_by() and summarize() functions we learned in the dplyr lesson

# group_by 
# split into groups

gap_long %>% group_by(continent,obs_type) %>%
  summarize(means=mean(obs_values))


# spread
gap_normal <- gap_long %>% spread(obs_type,obs_values)
dim(gap_normal)
dim(gapminder)

names(gap_normal)
names(gap_long)

# unite(new_var_name,var1,var2,sep="char")
gap_temp <- gap_long %>% unite(var_ID,continent,country,sep="_")
str(gap_temp)

gap_temp <- gap_long %>%
  unite(ID_var,continent,country,sep="_") %>%
  unite(var_names,obs_type,year,sep="_")
str(gap_temp)

gap_wide_new <- gap_long %>%
  unite(ID_var,continent,country,sep="_") %>%
  unite(var_names,obs_type,year,sep="_") %>%
  spread(var_names,obs_values)
str(gap_wide_new)

# Take this 1 step further and create a gap_ludicrously_wide format data by spreading over countries, 
# year and the 3 metrics? Hint this new dataframe should only have 5 rows.

gap_ludicrously_wide <- gap_long %>%
  unite(var_names,obs_type,year,country,sep="_") %>%
  spread(var_names,obs_values)































































































































































































































































































































































































