library(tidyverse)
library(gapminder)
library(here)

# how to export data as a file: write_csv()
write_csv(gapminder, './gapminder.csv') # export the 'gapminder' dataset in the current folder (./) as a csv file named 'gapminder.csv'
write_csv(gapminder, './week_6/Dataset/gapminder.csv') # But I want to save it under week_6!

## summarize gapminder and export it as a file
gapminder_sum <- gapminder %>%
  group_by(continent) %>%
  summarize(ave_lifeExp = mean(lifeExp)) # mean lifeExp by continent

View(gapminder_sum) # sanity check ;-)

gapminder_sum %>%
  ggplot(aes(continent, ave_lifeExp)) +
  geom_point() +
  theme_minimal() # simple plotting

write_csv(gapminder_sum, './week_6/Dataset/gapminder_sum.csv')


# how to import data from a file: read_csv()
gapminder_csv <- read_csv('./week_6/Dataset/gapminder_sum.csv') 

View(gapminder_csv)

# remove all the variants 
ls() # [1] "gapminder_csv" "gapminder_sum"

list = ls() # This assigns the list of user-objects (i.e., "gapminder_csv" and "gapminder_sum") as an object 'list'.

remove(list = ls())

ls() # character(0)

# use the 'here' package for exporting and importing a file
gapminder_sum <- gapminder %>%
  group_by(continent) %>%
  summarize(ave_lifeExp = mean(lifeExp)) # mean lifeExp by continent

write_csv(gapminder_sum, here::here('week_6','Dataset','gapminder_sum.csv'))

# download xls file from the web using 'download.file'
data_url <- 'http://gattonweb.uky.edu/sheather/book/docs/datasets/GreatestGivers.xls'

download.file(url = data_url, 
              destfile = paste('./week_6/Dataset/', 'GreatestGivers.xls')) # old way of downloading a file

## Task: Change above to use the "here :: here" package
download.file(url = data_url,
              destfile = here::here('week_6', 'Dataset', 'GreatestGivers.xls'))

## Recommendation: use 'basename'
?basename # help

file_name <- basename(data_url)

download.file(url = data_url,
              destfile = here::here('week_6', 'Dataset', file_name))

# Use 'readxl' to import MS Excel files (.xls). (the xls file we have already downloaded as above)
install.packages("readxl")
library(readxl)

philanthropists <- read_excel(here::here('week_6', 'Dataset','GreatestGivers.xls'), 
                              trim_ws = TRUE) # trim_ws: should leadning and trailing whitespace be trimmed?

View(philanthropists)

# loading another excel file! (this time, .xlsx)
mri_file <- here::here('week_6','Dataset','Firas-MRI.xlsx') # define a path to the xlsx file

mri <- read_excel(mri_file, range='A1:L12')

View(mri)

mri<-mri[,-10] # deleting columns

mri <- mri %>%
  pivot_longer(cols = 'Slice 1':'Slice 8',
               names_to = 'slice_no',
               values_to = 'value')

View(mri)
