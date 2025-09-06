# global.R file for sampling learning module

#packages to load
library(shiny)
library(shinythemes)

# coordinates for field grid used to construct figures
xleft = rep(seq(1,18,1),18)
xright = xleft + 1
ybottom = c(rep(1,18), rep(2,18), rep(3,18), rep(4,18), 
            rep(5,18), rep(6,18), rep(7,18), rep(8,18), 
            rep(9,18), rep(10,18), rep(11,18), rep(12,18),
            rep(13,18), rep(14,18), rep(15,18), rep(16,28),
            rep(17,18), rep(18,18))
ytop = ybottom + 1

# mean and standard deviations for stratified groups
f_mean = 28
f_sd = 3.03
p_mean = 9
p_sd = 1.73
w_mean = 55
w_sd = 12.0

# set color scheme
palette("Okabe-Ito")
