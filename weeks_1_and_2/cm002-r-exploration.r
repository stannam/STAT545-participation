number * 2
number <- 5 + 2
number * 2
a * 2 # error. as 'a' is not specified

times <- c(60, 35, 40, 33, 15, 20, 10) # This is an in-line comment
(times <- c(60, 35, 40, 33, 15, 20, 10)) # assign and print
times_hour <- times / 60

mean(times)
sqrt(times)
range(times) # minimum and maximum


times < 30
times == 20
times != 20
times > 20 & times < 50
times > 20 | times < 50
which(times < 30)
any(times < 30) # is there any true?
all(times < 30) # are all true?
sum(times < 30) # count number of trues. as TRUE equals 1, FALSE equals 0.

# subsetting:
times[3]
times[-3] # all except 3rd
times[c(2, 4)]
times[c(4, 2)] # order matters
times[1:5]
times[times < 30]

# cap entries
times[times > 50] <- 50 # AWESOME!!! 
times

# NA:
length(times) # returned 7
times[8] <- NA
times

mean(times) # returned NA
?mean
mean(times, na.rm = TRUE)
mean(times, 0, TRUE)
mean(na.rm = TRUE, x = times)

mtcars
str(mtcars)
names(mtcars)
mtcars$mpg
