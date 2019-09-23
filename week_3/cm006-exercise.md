---
title: "cm006: `dplyr` Exercise"
output: 
  html_document:
    keep_md: true
editor_options: 
  chunk_output_type: inline
---

<!---The following chunk allows errors when knitting--->



**Optional, but recommended startup**:

1. Change the file output to both html and md _documents_ (not notebook).

2. `knit` the document. 

3. Stage and commit the rmd, and knitted documents.

# Intro to `dplyr` syntax

Load the `gapminder` and `tidyverse` packages. Hint: `suppressPackageStartupMessages()`!
    - This loads `dplyr`, too.
    

```r
# load your packages here:
library(gapminder)
library(tidyverse)
```
    

## `select()` (8 min)

1. Make a data frame containing the columns `year`, `lifeExp`, `country` from the gapminder data, in that order.


```r
# gapminder is a tibble
select(gapminder, year, lifeExp, country) # select() takes.. first argument: tibble /  following arguments: names of columns
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country    
##    <int>   <dbl> <fct>      
##  1  1952    28.8 Afghanistan
##  2  1957    30.3 Afghanistan
##  3  1962    32.0 Afghanistan
##  4  1967    34.0 Afghanistan
##  5  1972    36.1 Afghanistan
##  6  1977    38.4 Afghanistan
##  7  1982    39.9 Afghanistan
##  8  1987    40.8 Afghanistan
##  9  1992    41.7 Afghanistan
## 10  1997    41.8 Afghanistan
## # ... with 1,694 more rows
```


2. Select all variables, from `country` to `lifeExp`.


```r
# This will work:
select(gapminder, country, continent, year, lifeExp)
```

```
## # A tibble: 1,704 x 4
##    country     continent  year lifeExp
##    <fct>       <fct>     <int>   <dbl>
##  1 Afghanistan Asia       1952    28.8
##  2 Afghanistan Asia       1957    30.3
##  3 Afghanistan Asia       1962    32.0
##  4 Afghanistan Asia       1967    34.0
##  5 Afghanistan Asia       1972    36.1
##  6 Afghanistan Asia       1977    38.4
##  7 Afghanistan Asia       1982    39.9
##  8 Afghanistan Asia       1987    40.8
##  9 Afghanistan Asia       1992    41.7
## 10 Afghanistan Asia       1997    41.8
## # ... with 1,694 more rows
```

```r
# Better way:
select(gapminder, country:lifeExp) # all columns from country to lifeExp
```

```
## # A tibble: 1,704 x 4
##    country     continent  year lifeExp
##    <fct>       <fct>     <int>   <dbl>
##  1 Afghanistan Asia       1952    28.8
##  2 Afghanistan Asia       1957    30.3
##  3 Afghanistan Asia       1962    32.0
##  4 Afghanistan Asia       1967    34.0
##  5 Afghanistan Asia       1972    36.1
##  6 Afghanistan Asia       1977    38.4
##  7 Afghanistan Asia       1982    39.9
##  8 Afghanistan Asia       1987    40.8
##  9 Afghanistan Asia       1992    41.7
## 10 Afghanistan Asia       1997    41.8
## # ... with 1,694 more rows
```


3. Select all variables, except `lifeExp`.


```r
select(gapminder, -lifeExp) # '-' Excludes lifeExp
```

```
## # A tibble: 1,704 x 5
##    country     continent  year      pop gdpPercap
##    <fct>       <fct>     <int>    <int>     <dbl>
##  1 Afghanistan Asia       1952  8425333      779.
##  2 Afghanistan Asia       1957  9240934      821.
##  3 Afghanistan Asia       1962 10267083      853.
##  4 Afghanistan Asia       1967 11537966      836.
##  5 Afghanistan Asia       1972 13079460      740.
##  6 Afghanistan Asia       1977 14880372      786.
##  7 Afghanistan Asia       1982 12881816      978.
##  8 Afghanistan Asia       1987 13867957      852.
##  9 Afghanistan Asia       1992 16317921      649.
## 10 Afghanistan Asia       1997 22227415      635.
## # ... with 1,694 more rows
```

4. Put `continent` first. Hint: use the `everything()` function.


```r
select(gapminder, continent, everything()) # everything(): other columns
```

```
## # A tibble: 1,704 x 6
##    continent country      year lifeExp      pop gdpPercap
##    <fct>     <fct>       <int>   <dbl>    <int>     <dbl>
##  1 Asia      Afghanistan  1952    28.8  8425333      779.
##  2 Asia      Afghanistan  1957    30.3  9240934      821.
##  3 Asia      Afghanistan  1962    32.0 10267083      853.
##  4 Asia      Afghanistan  1967    34.0 11537966      836.
##  5 Asia      Afghanistan  1972    36.1 13079460      740.
##  6 Asia      Afghanistan  1977    38.4 14880372      786.
##  7 Asia      Afghanistan  1982    39.9 12881816      978.
##  8 Asia      Afghanistan  1987    40.8 13867957      852.
##  9 Asia      Afghanistan  1992    41.7 16317921      649.
## 10 Asia      Afghanistan  1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


5. Rename `continent` to `cont`.


```r
# compare
select(gapminder, cont = continent, everything()) 
```

```
## # A tibble: 1,704 x 6
##    cont  country      year lifeExp      pop gdpPercap
##    <fct> <fct>       <int>   <dbl>    <int>     <dbl>
##  1 Asia  Afghanistan  1952    28.8  8425333      779.
##  2 Asia  Afghanistan  1957    30.3  9240934      821.
##  3 Asia  Afghanistan  1962    32.0 10267083      853.
##  4 Asia  Afghanistan  1967    34.0 11537966      836.
##  5 Asia  Afghanistan  1972    36.1 13079460      740.
##  6 Asia  Afghanistan  1977    38.4 14880372      786.
##  7 Asia  Afghanistan  1982    39.9 12881816      978.
##  8 Asia  Afghanistan  1987    40.8 13867957      852.
##  9 Asia  Afghanistan  1992    41.7 16317921      649.
## 10 Asia  Afghanistan  1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

```r
# a new column cont takes the continent column. everything() keeps everything else.

rename(gapminder, cont = continent) # the order of columns is retained but the column name 'continent' became 'cont.'
```

```
## # A tibble: 1,704 x 6
##    country     cont   year lifeExp      pop gdpPercap
##    <fct>       <fct> <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia   1952    28.8  8425333      779.
##  2 Afghanistan Asia   1957    30.3  9240934      821.
##  3 Afghanistan Asia   1962    32.0 10267083      853.
##  4 Afghanistan Asia   1967    34.0 11537966      836.
##  5 Afghanistan Asia   1972    36.1 13079460      740.
##  6 Afghanistan Asia   1977    38.4 14880372      786.
##  7 Afghanistan Asia   1982    39.9 12881816      978.
##  8 Afghanistan Asia   1987    40.8 13867957      852.
##  9 Afghanistan Asia   1992    41.7 16317921      649.
## 10 Afghanistan Asia   1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


## `arrange()` (8 min)

1. Order by year.


```r
arrange(gapminder, year) # from old to new
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Albania     Europe     1952    55.2  1282697     1601.
##  3 Algeria     Africa     1952    43.1  9279525     2449.
##  4 Angola      Africa     1952    30.0  4232095     3521.
##  5 Argentina   Americas   1952    62.5 17876956     5911.
##  6 Australia   Oceania    1952    69.1  8691212    10040.
##  7 Austria     Europe     1952    66.8  6927772     6137.
##  8 Bahrain     Asia       1952    50.9   120447     9867.
##  9 Bangladesh  Asia       1952    37.5 46886859      684.
## 10 Belgium     Europe     1952    68    8730405     8343.
## # ... with 1,694 more rows
```

2. Order by year, in descending order.


```r
arrange(gapminder, desc(year)) 
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp       pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Afghanistan Asia       2007    43.8  31889923      975.
##  2 Albania     Europe     2007    76.4   3600523     5937.
##  3 Algeria     Africa     2007    72.3  33333216     6223.
##  4 Angola      Africa     2007    42.7  12420476     4797.
##  5 Argentina   Americas   2007    75.3  40301927    12779.
##  6 Australia   Oceania    2007    81.2  20434176    34435.
##  7 Austria     Europe     2007    79.8   8199783    36126.
##  8 Bahrain     Asia       2007    75.6    708573    29796.
##  9 Bangladesh  Asia       2007    64.1 150448339     1391.
## 10 Belgium     Europe     2007    79.4  10392226    33693.
## # ... with 1,694 more rows
```

3. Order by year, then by life expectancy.


```r
arrange(gapminder, year, lifeExp)
```

```
## # A tibble: 1,704 x 6
##    country       continent  year lifeExp     pop gdpPercap
##    <fct>         <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Afghanistan   Asia       1952    28.8 8425333      779.
##  2 Gambia        Africa     1952    30    284320      485.
##  3 Angola        Africa     1952    30.0 4232095     3521.
##  4 Sierra Leone  Africa     1952    30.3 2143249      880.
##  5 Mozambique    Africa     1952    31.3 6446316      469.
##  6 Burkina Faso  Africa     1952    32.0 4469979      543.
##  7 Guinea-Bissau Africa     1952    32.5  580653      300.
##  8 Yemen, Rep.   Asia       1952    32.5 4963829      782.
##  9 Somalia       Africa     1952    33.0 2526994     1136.
## 10 Guinea        Africa     1952    33.6 2664249      510.
## # ... with 1,694 more rows
```

## Piping, `%>%` (8 min)

Note: think of `%>%` as the word "then"!

Demonstration:

Here I want to combine `select()` Task 1 with `arrange()` Task 3.

This is how I could do it by *nesting* the two function calls:


```r
# Nesting function calls can be hard to read
arrange(select(gapminder, year, lifeExp, country), year, lifeExp) # first select() and put the result to arrange() --> not intuitive :(
```

Now using with pipes:


```r
# alter the below to include 2 "pipes"
arrange(select(gapminder, year, lifeExp, country), year, lifeExp) # before: nesting
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```

```r
gapminder %>%
    select(year, lifeExp, country) %>%
    arrange(year, lifeExp)                                  # after: using pipes
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```

# Resume lecture 

Return to guide at section 6.7.

## `filter()` (10 min)

1. Only take data with population greater than 100 million.


```r
gapminder %>%
  filter(pop > 100000000)
```

```
## # A tibble: 77 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 Brazil     Americas   1972    59.5 100840058     4986.
##  7 Brazil     Americas   1977    61.5 114313951     6660.
##  8 Brazil     Americas   1982    63.3 128962939     7031.
##  9 Brazil     Americas   1987    65.2 142938076     7807.
## 10 Brazil     Americas   1992    67.1 155975974     6950.
## # ... with 67 more rows
```

2. Your turn: of those rows filtered from step 1., only take data from Asia.


```r
gapminder %>%
  filter(pop > 100000000) %>%
  filter(continent == "Asia")
```

```
## # A tibble: 52 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 China      Asia       1952    44   556263527      400.
##  7 China      Asia       1957    50.5 637408000      576.
##  8 China      Asia       1962    44.5 665770000      488.
##  9 China      Asia       1967    58.4 754550000      613.
## 10 China      Asia       1972    63.1 862030000      677.
## # ... with 42 more rows
```

```r
gapminder %>%
  filter(pop > 100000000 & continent == "Asia")
```

```
## # A tibble: 52 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 China      Asia       1952    44   556263527      400.
##  7 China      Asia       1957    50.5 637408000      576.
##  8 China      Asia       1962    44.5 665770000      488.
##  9 China      Asia       1967    58.4 754550000      613.
## 10 China      Asia       1972    63.1 862030000      677.
## # ... with 42 more rows
```

```r
gapminder %>%
  filter(pop > 100000000,
         continent == "Asia")
```

```
## # A tibble: 52 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 China      Asia       1952    44   556263527      400.
##  7 China      Asia       1957    50.5 637408000      576.
##  8 China      Asia       1962    44.5 665770000      488.
##  9 China      Asia       1967    58.4 754550000      613.
## 10 China      Asia       1972    63.1 862030000      677.
## # ... with 42 more rows
```

3. Repeat 2, but take data from countries Brazil, and China. 


```r
gapminder %>%
  filter(pop > 100000000) %>%
  filter(country == "Brazil" | country == "China")
```

```
## # A tibble: 20 x 6
##    country continent  year lifeExp        pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Brazil  Americas   1972    59.5  100840058     4986.
##  2 Brazil  Americas   1977    61.5  114313951     6660.
##  3 Brazil  Americas   1982    63.3  128962939     7031.
##  4 Brazil  Americas   1987    65.2  142938076     7807.
##  5 Brazil  Americas   1992    67.1  155975974     6950.
##  6 Brazil  Americas   1997    69.4  168546719     7958.
##  7 Brazil  Americas   2002    71.0  179914212     8131.
##  8 Brazil  Americas   2007    72.4  190010647     9066.
##  9 China   Asia       1952    44    556263527      400.
## 10 China   Asia       1957    50.5  637408000      576.
## 11 China   Asia       1962    44.5  665770000      488.
## 12 China   Asia       1967    58.4  754550000      613.
## 13 China   Asia       1972    63.1  862030000      677.
## 14 China   Asia       1977    64.0  943455000      741.
## 15 China   Asia       1982    65.5 1000281000      962.
## 16 China   Asia       1987    67.3 1084035000     1379.
## 17 China   Asia       1992    68.7 1164970000     1656.
## 18 China   Asia       1997    70.4 1230075000     2289.
## 19 China   Asia       2002    72.0 1280400000     3119.
## 20 China   Asia       2007    73.0 1318683096     4959.
```

```r
gapminder %>%
  filter(pop > 100000000 & (country == "Brazil" | country == "China"))
```

```
## # A tibble: 20 x 6
##    country continent  year lifeExp        pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Brazil  Americas   1972    59.5  100840058     4986.
##  2 Brazil  Americas   1977    61.5  114313951     6660.
##  3 Brazil  Americas   1982    63.3  128962939     7031.
##  4 Brazil  Americas   1987    65.2  142938076     7807.
##  5 Brazil  Americas   1992    67.1  155975974     6950.
##  6 Brazil  Americas   1997    69.4  168546719     7958.
##  7 Brazil  Americas   2002    71.0  179914212     8131.
##  8 Brazil  Americas   2007    72.4  190010647     9066.
##  9 China   Asia       1952    44    556263527      400.
## 10 China   Asia       1957    50.5  637408000      576.
## 11 China   Asia       1962    44.5  665770000      488.
## 12 China   Asia       1967    58.4  754550000      613.
## 13 China   Asia       1972    63.1  862030000      677.
## 14 China   Asia       1977    64.0  943455000      741.
## 15 China   Asia       1982    65.5 1000281000      962.
## 16 China   Asia       1987    67.3 1084035000     1379.
## 17 China   Asia       1992    68.7 1164970000     1656.
## 18 China   Asia       1997    70.4 1230075000     2289.
## 19 China   Asia       2002    72.0 1280400000     3119.
## 20 China   Asia       2007    73.0 1318683096     4959.
```

```r
gapminder %>%
  filter(pop > 100000000,
         country == "Brazil" | country == "China")
```

```
## # A tibble: 20 x 6
##    country continent  year lifeExp        pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Brazil  Americas   1972    59.5  100840058     4986.
##  2 Brazil  Americas   1977    61.5  114313951     6660.
##  3 Brazil  Americas   1982    63.3  128962939     7031.
##  4 Brazil  Americas   1987    65.2  142938076     7807.
##  5 Brazil  Americas   1992    67.1  155975974     6950.
##  6 Brazil  Americas   1997    69.4  168546719     7958.
##  7 Brazil  Americas   2002    71.0  179914212     8131.
##  8 Brazil  Americas   2007    72.4  190010647     9066.
##  9 China   Asia       1952    44    556263527      400.
## 10 China   Asia       1957    50.5  637408000      576.
## 11 China   Asia       1962    44.5  665770000      488.
## 12 China   Asia       1967    58.4  754550000      613.
## 13 China   Asia       1972    63.1  862030000      677.
## 14 China   Asia       1977    64.0  943455000      741.
## 15 China   Asia       1982    65.5 1000281000      962.
## 16 China   Asia       1987    67.3 1084035000     1379.
## 17 China   Asia       1992    68.7 1164970000     1656.
## 18 China   Asia       1997    70.4 1230075000     2289.
## 19 China   Asia       2002    72.0 1280400000     3119.
## 20 China   Asia       2007    73.0 1318683096     4959.
```

## `mutate()` (10 min)

Let's get: 

- GDP by multiplying GPD per capita with population, and
- GDP in billions, named (`gdpBill`), rounded to two decimals.


```r
gapminder %>%
  mutate(gdpBill = round(gdpPercap * pop / 1000000000, 2))
```

```
## # A tibble: 1,704 x 7
##    country     continent  year lifeExp      pop gdpPercap gdpBill
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>   <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.    6.57
##  2 Afghanistan Asia       1957    30.3  9240934      821.    7.59
##  3 Afghanistan Asia       1962    32.0 10267083      853.    8.76
##  4 Afghanistan Asia       1967    34.0 11537966      836.    9.65
##  5 Afghanistan Asia       1972    36.1 13079460      740.    9.68
##  6 Afghanistan Asia       1977    38.4 14880372      786.   11.7 
##  7 Afghanistan Asia       1982    39.9 12881816      978.   12.6 
##  8 Afghanistan Asia       1987    40.8 13867957      852.   11.8 
##  9 Afghanistan Asia       1992    41.7 16317921      649.   10.6 
## 10 Afghanistan Asia       1997    41.8 22227415      635.   14.1 
## # ... with 1,694 more rows
```

```r
gapminder %>%
  mutate(gdpBill = (gdpPercap * pop / 1000000000) %>% round(2))
```

```
## # A tibble: 1,704 x 7
##    country     continent  year lifeExp      pop gdpPercap gdpBill
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>   <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.    6.57
##  2 Afghanistan Asia       1957    30.3  9240934      821.    7.59
##  3 Afghanistan Asia       1962    32.0 10267083      853.    8.76
##  4 Afghanistan Asia       1967    34.0 11537966      836.    9.65
##  5 Afghanistan Asia       1972    36.1 13079460      740.    9.68
##  6 Afghanistan Asia       1977    38.4 14880372      786.   11.7 
##  7 Afghanistan Asia       1982    39.9 12881816      978.   12.6 
##  8 Afghanistan Asia       1987    40.8 13867957      852.   11.8 
##  9 Afghanistan Asia       1992    41.7 16317921      649.   10.6 
## 10 Afghanistan Asia       1997    41.8 22227415      635.   14.1 
## # ... with 1,694 more rows
```

Notice the backwards compatibility! No need for loops!

Try the same thing, but with `transmute` (drops all other variables). 


```r
gapminder %>%
  transmute(gdpBill = round(gdpPercap * pop / 1000000000, 2)) # returns gdpBill only
```

```
## # A tibble: 1,704 x 1
##    gdpBill
##      <dbl>
##  1    6.57
##  2    7.59
##  3    8.76
##  4    9.65
##  5    9.68
##  6   11.7 
##  7   12.6 
##  8   11.8 
##  9   10.6 
## 10   14.1 
## # ... with 1,694 more rows
```

The `if_else` function is useful for changing certain elements in a data frame.

Example: Suppose Canada's 1952 life expectancy was mistakenly entered as 68.8 in the data frame, but is actually 70. Fix it using `if_else` and `mutate`. 


```r
gapminder %>%
  mutate(lifeExp = if_else(country == 'Canada' & year == 1952, 70, lifeExp))
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

Your turn: Make a new column called `cc` that pastes the country name followed by the continent, separated by a comma. (Hint: use the `paste` function with the `sep=", "` argument).


```r
gapminder %>%
  mutate(cc = paste(country, continent, sep = ", "))
```

```
## # A tibble: 1,704 x 7
##    country     continent  year lifeExp      pop gdpPercap cc               
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl> <chr>            
##  1 Afghanistan Asia       1952    28.8  8425333      779. Afghanistan, Asia
##  2 Afghanistan Asia       1957    30.3  9240934      821. Afghanistan, Asia
##  3 Afghanistan Asia       1962    32.0 10267083      853. Afghanistan, Asia
##  4 Afghanistan Asia       1967    34.0 11537966      836. Afghanistan, Asia
##  5 Afghanistan Asia       1972    36.1 13079460      740. Afghanistan, Asia
##  6 Afghanistan Asia       1977    38.4 14880372      786. Afghanistan, Asia
##  7 Afghanistan Asia       1982    39.9 12881816      978. Afghanistan, Asia
##  8 Afghanistan Asia       1987    40.8 13867957      852. Afghanistan, Asia
##  9 Afghanistan Asia       1992    41.7 16317921      649. Afghanistan, Asia
## 10 Afghanistan Asia       1997    41.8 22227415      635. Afghanistan, Asia
## # ... with 1,694 more rows
```

These functions we've seen are called __vectorized functions__.

## git stuff (Optional)

Knit, commit, push!

# Bonus Exercises

If there's time remaining, we'll practice with these three exercises. I'll give you 1 minute for each, then we'll go over the answer.

1. Take all countries in Europe that have a GDP per capita greater than 10000, and select all variables except `gdpPercap`. (Hint: use `-`).


```r
gapminder %>%
  filter(gdpPercap > 10000 & continent == "Europe") %>% 
  select(-gdpPercap)
```

```
## # A tibble: 214 x 5
##    country continent  year lifeExp     pop
##    <fct>   <fct>     <int>   <dbl>   <int>
##  1 Austria Europe     1962    69.5 7129864
##  2 Austria Europe     1967    70.1 7376998
##  3 Austria Europe     1972    70.6 7544201
##  4 Austria Europe     1977    72.2 7568430
##  5 Austria Europe     1982    73.2 7574613
##  6 Austria Europe     1987    74.9 7578903
##  7 Austria Europe     1992    76.0 7914969
##  8 Austria Europe     1997    77.5 8069876
##  9 Austria Europe     2002    79.0 8148312
## 10 Austria Europe     2007    79.8 8199783
## # ... with 204 more rows
```

2. Take the first three columns, and extract the names.


```r
gapminder %>%
  select(country:year)
```

```
## # A tibble: 1,704 x 3
##    country     continent  year
##    <fct>       <fct>     <int>
##  1 Afghanistan Asia       1952
##  2 Afghanistan Asia       1957
##  3 Afghanistan Asia       1962
##  4 Afghanistan Asia       1967
##  5 Afghanistan Asia       1972
##  6 Afghanistan Asia       1977
##  7 Afghanistan Asia       1982
##  8 Afghanistan Asia       1987
##  9 Afghanistan Asia       1992
## 10 Afghanistan Asia       1997
## # ... with 1,694 more rows
```

3. Of the `iris` data frame, take all columns that start with the word "Petal". 
    - Hint: take a look at the "Select helpers" documentation by running the following code: `?tidyselect::select_helpers`.
    

```r
iris %>%
  select(starts_with("Petal"))
```

```
##     Petal.Length Petal.Width
## 1            1.4         0.2
## 2            1.4         0.2
## 3            1.3         0.2
## 4            1.5         0.2
## 5            1.4         0.2
## 6            1.7         0.4
## 7            1.4         0.3
## 8            1.5         0.2
## 9            1.4         0.2
## 10           1.5         0.1
## 11           1.5         0.2
## 12           1.6         0.2
## 13           1.4         0.1
## 14           1.1         0.1
## 15           1.2         0.2
## 16           1.5         0.4
## 17           1.3         0.4
## 18           1.4         0.3
## 19           1.7         0.3
## 20           1.5         0.3
## 21           1.7         0.2
## 22           1.5         0.4
## 23           1.0         0.2
## 24           1.7         0.5
## 25           1.9         0.2
## 26           1.6         0.2
## 27           1.6         0.4
## 28           1.5         0.2
## 29           1.4         0.2
## 30           1.6         0.2
## 31           1.6         0.2
## 32           1.5         0.4
## 33           1.5         0.1
## 34           1.4         0.2
## 35           1.5         0.2
## 36           1.2         0.2
## 37           1.3         0.2
## 38           1.4         0.1
## 39           1.3         0.2
## 40           1.5         0.2
## 41           1.3         0.3
## 42           1.3         0.3
## 43           1.3         0.2
## 44           1.6         0.6
## 45           1.9         0.4
## 46           1.4         0.3
## 47           1.6         0.2
## 48           1.4         0.2
## 49           1.5         0.2
## 50           1.4         0.2
## 51           4.7         1.4
## 52           4.5         1.5
## 53           4.9         1.5
## 54           4.0         1.3
## 55           4.6         1.5
## 56           4.5         1.3
## 57           4.7         1.6
## 58           3.3         1.0
## 59           4.6         1.3
## 60           3.9         1.4
## 61           3.5         1.0
## 62           4.2         1.5
## 63           4.0         1.0
## 64           4.7         1.4
## 65           3.6         1.3
## 66           4.4         1.4
## 67           4.5         1.5
## 68           4.1         1.0
## 69           4.5         1.5
## 70           3.9         1.1
## 71           4.8         1.8
## 72           4.0         1.3
## 73           4.9         1.5
## 74           4.7         1.2
## 75           4.3         1.3
## 76           4.4         1.4
## 77           4.8         1.4
## 78           5.0         1.7
## 79           4.5         1.5
## 80           3.5         1.0
## 81           3.8         1.1
## 82           3.7         1.0
## 83           3.9         1.2
## 84           5.1         1.6
## 85           4.5         1.5
## 86           4.5         1.6
## 87           4.7         1.5
## 88           4.4         1.3
## 89           4.1         1.3
## 90           4.0         1.3
## 91           4.4         1.2
## 92           4.6         1.4
## 93           4.0         1.2
## 94           3.3         1.0
## 95           4.2         1.3
## 96           4.2         1.2
## 97           4.2         1.3
## 98           4.3         1.3
## 99           3.0         1.1
## 100          4.1         1.3
## 101          6.0         2.5
## 102          5.1         1.9
## 103          5.9         2.1
## 104          5.6         1.8
## 105          5.8         2.2
## 106          6.6         2.1
## 107          4.5         1.7
## 108          6.3         1.8
## 109          5.8         1.8
## 110          6.1         2.5
## 111          5.1         2.0
## 112          5.3         1.9
## 113          5.5         2.1
## 114          5.0         2.0
## 115          5.1         2.4
## 116          5.3         2.3
## 117          5.5         1.8
## 118          6.7         2.2
## 119          6.9         2.3
## 120          5.0         1.5
## 121          5.7         2.3
## 122          4.9         2.0
## 123          6.7         2.0
## 124          4.9         1.8
## 125          5.7         2.1
## 126          6.0         1.8
## 127          4.8         1.8
## 128          4.9         1.8
## 129          5.6         2.1
## 130          5.8         1.6
## 131          6.1         1.9
## 132          6.4         2.0
## 133          5.6         2.2
## 134          5.1         1.5
## 135          5.6         1.4
## 136          6.1         2.3
## 137          5.6         2.4
## 138          5.5         1.8
## 139          4.8         1.8
## 140          5.4         2.1
## 141          5.6         2.4
## 142          5.1         2.3
## 143          5.1         1.9
## 144          5.9         2.3
## 145          5.7         2.5
## 146          5.2         2.3
## 147          5.0         1.9
## 148          5.2         2.0
## 149          5.4         2.3
## 150          5.1         1.8
```
  

4. Convert the population to a number in billions.


```r
gapminder %>%
  mutate(pop = round(gdpPercap * pop / 1000000000, 2)) # overwrites 'pop.' 
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp   pop gdpPercap
##    <fct>       <fct>     <int>   <dbl> <dbl>     <dbl>
##  1 Afghanistan Asia       1952    28.8  6.57      779.
##  2 Afghanistan Asia       1957    30.3  7.59      821.
##  3 Afghanistan Asia       1962    32.0  8.76      853.
##  4 Afghanistan Asia       1967    34.0  9.65      836.
##  5 Afghanistan Asia       1972    36.1  9.68      740.
##  6 Afghanistan Asia       1977    38.4 11.7       786.
##  7 Afghanistan Asia       1982    39.9 12.6       978.
##  8 Afghanistan Asia       1987    40.8 11.8       852.
##  9 Afghanistan Asia       1992    41.7 10.6       649.
## 10 Afghanistan Asia       1997    41.8 14.1       635.
## # ... with 1,694 more rows
```

5. Filter the rows of the iris dataset for Sepal.Length >= 4.6 and Petal.Width >= 0.5.


```r
iris %>%
  filter(Sepal.Length >= 4.6, Petal.Width >= 0.5)
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1            5.1         3.3          1.7         0.5     setosa
## 2            5.0         3.5          1.6         0.6     setosa
## 3            7.0         3.2          4.7         1.4 versicolor
## 4            6.4         3.2          4.5         1.5 versicolor
## 5            6.9         3.1          4.9         1.5 versicolor
## 6            5.5         2.3          4.0         1.3 versicolor
## 7            6.5         2.8          4.6         1.5 versicolor
## 8            5.7         2.8          4.5         1.3 versicolor
## 9            6.3         3.3          4.7         1.6 versicolor
## 10           4.9         2.4          3.3         1.0 versicolor
## 11           6.6         2.9          4.6         1.3 versicolor
## 12           5.2         2.7          3.9         1.4 versicolor
## 13           5.0         2.0          3.5         1.0 versicolor
## 14           5.9         3.0          4.2         1.5 versicolor
## 15           6.0         2.2          4.0         1.0 versicolor
## 16           6.1         2.9          4.7         1.4 versicolor
## 17           5.6         2.9          3.6         1.3 versicolor
## 18           6.7         3.1          4.4         1.4 versicolor
## 19           5.6         3.0          4.5         1.5 versicolor
## 20           5.8         2.7          4.1         1.0 versicolor
## 21           6.2         2.2          4.5         1.5 versicolor
## 22           5.6         2.5          3.9         1.1 versicolor
## 23           5.9         3.2          4.8         1.8 versicolor
## 24           6.1         2.8          4.0         1.3 versicolor
## 25           6.3         2.5          4.9         1.5 versicolor
## 26           6.1         2.8          4.7         1.2 versicolor
## 27           6.4         2.9          4.3         1.3 versicolor
## 28           6.6         3.0          4.4         1.4 versicolor
## 29           6.8         2.8          4.8         1.4 versicolor
## 30           6.7         3.0          5.0         1.7 versicolor
## 31           6.0         2.9          4.5         1.5 versicolor
## 32           5.7         2.6          3.5         1.0 versicolor
## 33           5.5         2.4          3.8         1.1 versicolor
## 34           5.5         2.4          3.7         1.0 versicolor
## 35           5.8         2.7          3.9         1.2 versicolor
## 36           6.0         2.7          5.1         1.6 versicolor
## 37           5.4         3.0          4.5         1.5 versicolor
## 38           6.0         3.4          4.5         1.6 versicolor
## 39           6.7         3.1          4.7         1.5 versicolor
## 40           6.3         2.3          4.4         1.3 versicolor
## 41           5.6         3.0          4.1         1.3 versicolor
## 42           5.5         2.5          4.0         1.3 versicolor
## 43           5.5         2.6          4.4         1.2 versicolor
## 44           6.1         3.0          4.6         1.4 versicolor
## 45           5.8         2.6          4.0         1.2 versicolor
## 46           5.0         2.3          3.3         1.0 versicolor
## 47           5.6         2.7          4.2         1.3 versicolor
## 48           5.7         3.0          4.2         1.2 versicolor
## 49           5.7         2.9          4.2         1.3 versicolor
## 50           6.2         2.9          4.3         1.3 versicolor
## 51           5.1         2.5          3.0         1.1 versicolor
## 52           5.7         2.8          4.1         1.3 versicolor
## 53           6.3         3.3          6.0         2.5  virginica
## 54           5.8         2.7          5.1         1.9  virginica
## 55           7.1         3.0          5.9         2.1  virginica
## 56           6.3         2.9          5.6         1.8  virginica
## 57           6.5         3.0          5.8         2.2  virginica
## 58           7.6         3.0          6.6         2.1  virginica
## 59           4.9         2.5          4.5         1.7  virginica
## 60           7.3         2.9          6.3         1.8  virginica
## 61           6.7         2.5          5.8         1.8  virginica
## 62           7.2         3.6          6.1         2.5  virginica
## 63           6.5         3.2          5.1         2.0  virginica
## 64           6.4         2.7          5.3         1.9  virginica
## 65           6.8         3.0          5.5         2.1  virginica
## 66           5.7         2.5          5.0         2.0  virginica
## 67           5.8         2.8          5.1         2.4  virginica
## 68           6.4         3.2          5.3         2.3  virginica
## 69           6.5         3.0          5.5         1.8  virginica
## 70           7.7         3.8          6.7         2.2  virginica
## 71           7.7         2.6          6.9         2.3  virginica
## 72           6.0         2.2          5.0         1.5  virginica
## 73           6.9         3.2          5.7         2.3  virginica
## 74           5.6         2.8          4.9         2.0  virginica
## 75           7.7         2.8          6.7         2.0  virginica
## 76           6.3         2.7          4.9         1.8  virginica
## 77           6.7         3.3          5.7         2.1  virginica
## 78           7.2         3.2          6.0         1.8  virginica
## 79           6.2         2.8          4.8         1.8  virginica
## 80           6.1         3.0          4.9         1.8  virginica
## 81           6.4         2.8          5.6         2.1  virginica
## 82           7.2         3.0          5.8         1.6  virginica
## 83           7.4         2.8          6.1         1.9  virginica
## 84           7.9         3.8          6.4         2.0  virginica
## 85           6.4         2.8          5.6         2.2  virginica
## 86           6.3         2.8          5.1         1.5  virginica
## 87           6.1         2.6          5.6         1.4  virginica
## 88           7.7         3.0          6.1         2.3  virginica
## 89           6.3         3.4          5.6         2.4  virginica
## 90           6.4         3.1          5.5         1.8  virginica
## 91           6.0         3.0          4.8         1.8  virginica
## 92           6.9         3.1          5.4         2.1  virginica
## 93           6.7         3.1          5.6         2.4  virginica
## 94           6.9         3.1          5.1         2.3  virginica
## 95           5.8         2.7          5.1         1.9  virginica
## 96           6.8         3.2          5.9         2.3  virginica
## 97           6.7         3.3          5.7         2.5  virginica
## 98           6.7         3.0          5.2         2.3  virginica
## 99           6.3         2.5          5.0         1.9  virginica
## 100          6.5         3.0          5.2         2.0  virginica
## 101          6.2         3.4          5.4         2.3  virginica
## 102          5.9         3.0          5.1         1.8  virginica
```

Exercises 3. and 5. are from [r-exercises](https://www.r-exercises.com/2017/10/19/dplyr-basic-functions-exercises/).
