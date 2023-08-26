# server for sampling strategies

library(shiny)
library(shinythemes)


# place for data files and scripts used in server file

# coordinates for field grid
xleft = rep(seq(1,18,1),18)
xright = xleft + 1
ybottom = c(rep(1,18), rep(2,18), rep(3,18), rep(4,18), 
            rep(5,18), rep(6,18), rep(7,18), rep(8,18), 
            rep(9,18), rep(10,18), rep(11,18), rep(12,18),
            rep(13,18), rep(14,18), rep(15,18), rep(16,28),
            rep(17,18), rep(18,18))
ytop = ybottom + 1

# stats for stratified groups
f_mean = 28
f_sd = 3.03
p_mean = 9
p_sd = 1.73
w_mean = 55
w_sd = 12.0

# set color scheme

palette("Okabe-Ito")

shinyServer(function(input, output, session){
  
  # code for introduction figure
  
  # code for activity 1 plot
  
  output$act1_plot = renderPlot({
    
    old.par = par(mar = c(1,4,1,2))
    
    # how many replicates per sampling site and how many sample sites
    reps = input$act1_reps
    size = input$act1_size
    
    # initialize field grid
    field = matrix(data = rep(0,324), nrow = 18, ncol = 18)
    
    # populate field grid
    for (wi in 1:18){
      for (wj in 1:3){
        field[wi,wj] = round(mean(rnorm(reps, w_mean, w_sd)),1)
      }
    }
    
    for (fi in 1:18){
      for (fj in 4:9){
        field[fi,fj] = round(mean(rnorm(reps, f_mean, f_sd)),1)
      }
    }
    
    for (pi in 1:18){
      for (pj in 10:18){
        field[pi,pj] = round(mean(rnorm(reps, p_mean, p_sd)),1)
      }
    }
    
    # prepare plot
    plot(x = -1, y = -2, 
         xaxt = "n", xlim = c(0,19), xlab = "",
         yaxt = "n", ylim = c(0,19), ylab = "",
         bty = "n", asp = 1)
    
    rect(xleft,ybottom,xright,ytop)
    
    repeat{
      grid_row = rep(0,size)
      grid_column = rep(0,size)
      grid_row = sample(seq(1,18,1), size, replace = TRUE)
      grid_column = sample(seq(1,18,1), size, replace = TRUE)
      check = nrow(unique(data.frame(grid_row,grid_column)))
      if(check == size) break
    }
    
    if (input$act1_display == "yes"){
    field_data = rep(0,size)
    for (i in 1:size){
      field_data[i] = field[grid_row[i],grid_column[i]]
      rect(xleft = grid_column[i], xright = grid_column[i] + 1,
           ybottom = grid_row[i], ytop = grid_row[i] + 1,
           col = rgb(86/255,180/255,233/255,field[grid_row[i],grid_column[i]]/100, maxColorValue = 1))
      text(x = grid_column[i]+0.5, y = grid_row[i]+0.5,
           label = field[grid_row[i],grid_column[i]], 
           adj = c(0.5,0.5), cex = 1)
    }

    title(main = paste0("mean of samples: ", round(mean(field_data),1), "   sd of samples: ", round(sd(field_data),1)))
    }

    par(old.par)
  })
  
  output$act2_plot = renderPlot({
    
    old.par = par(mar = c(1,4,1,2))
    
    # how many replicates per sampling site and how many sample sites
    reps = input$act2_reps
    size1 = input$act2_size
    size2 = size1 * 2
    size3 = size1 * 3
    
    # initialize field grid
    field = matrix(data = rep(0,324), nrow = 18, ncol = 18)
    
    # populate field grid
    for (wi in 1:18){
      for (wj in 1:3){
        field[wi,wj] = round(mean(rnorm(reps, w_mean, w_sd)),1)
      }
    }
    
    for (fi in 1:18){
      for (fj in 4:9){
        field[fi,fj] = round(mean(rnorm(reps, f_mean, f_sd)),1)
      }
    }
    
    for (pi in 1:18){
      for (pj in 10:18){
        field[pi,pj] = round(mean(rnorm(reps, p_mean, p_sd)),1)
      }
    }
    
    # prepare plot
    plot(x = -1, y = -2, 
         xaxt = "n", xlim = c(0,19), xlab = "",
         yaxt = "n", ylim = c(0,19), ylab = "",
         bty = "n", asp = 1)
    lines(x = c(4,4), y = c(1,19), lwd = 4, col = 1)
    lines(x = c(10,10), y = c(1,19), lwd = 4, col = 1)
    text(x = 2.5, y = 0.5, "stratum 1")
    text(x = 7, y = 0.5, "stratum 2")
    text(x = 14.5, y = 0.5, "stratum 3")
    
    rect(xleft = xleft, ybottom = ybottom, xright = xright, ytop = ytop)
    
    # stratum 1
    repeat{
      grid_row1 = rep(0,size1)
      grid_column1 = rep(0,size1)
      grid_row1 = sample(seq(1,18,1), size1, replace = TRUE)
      grid_column1 = sample(seq(1,3,1), size1, replace = TRUE)
      check = nrow(unique(data.frame(grid_row1,grid_column1)))
      if(check == size1) break
    }
    
    field_data1 = rep(0,size1)
    for (i in 1:size1){
      field_data1[i] = field[grid_row1[i],grid_column1[i]]
      rect(xleft = grid_column1[i], xright = grid_column1[i] + 1,
           ybottom = grid_row1[i], ytop = grid_row1[i] + 1,
           col = rgb(86/255,180/255,233/255,field[grid_row1[i],grid_column1[i]]/100, maxColorValue = 1))
      text(x = grid_column1[i]+0.5, y = grid_row1[i]+0.5,
           label = field[grid_row1[i],grid_column1[i]], 
           adj = c(0.5,0.5), cex = 1)
    }
    
    # stratum 2
    repeat{
      grid_row2 = rep(0,size2)
      grid_column2 = rep(0,size2)
      grid_row2 = sample(seq(1,18,1), size2, replace = TRUE)
      grid_column2 = sample(seq(4,9,1), size2, replace = TRUE)
      check = nrow(unique(data.frame(grid_row2,grid_column2)))
      if(check == size2) break
    }
    
    field_data2 = rep(0,size2)
    for (i in 1:size2){
      field_data2[i] = field[grid_row2[i],grid_column2[i]]
      rect(xleft = grid_column2[i], xright = grid_column2[i] + 1,
           ybottom = grid_row2[i], ytop = grid_row2[i] + 1,
           col = rgb(86/255,180/255,233/255,field[grid_row2[i],grid_column2[i]]/100, maxColorValue = 1))
      text(x = grid_column2[i]+0.5, y = grid_row2[i]+0.5,
           label = field[grid_row2[i],grid_column2[i]], 
           adj = c(0.5,0.5), cex = 1)
    }
    
    # stratum3
    repeat{
      grid_row3 = rep(0,size3)
      grid_column3 = rep(0,size3)
      grid_row3 = sample(seq(1,18,1), size3, replace = TRUE)
      grid_column3 = sample(seq(10,18,1), size3, replace = TRUE)
      check = nrow(unique(data.frame(grid_row3,grid_column3)))
      if(check == size3) break
    }
    
    field_data3 = rep(0,size3)
    for (i in 1:size3){
      field_data3[i] = field[grid_row3[i],grid_column3[i]]
      rect(xleft = grid_column3[i], xright = grid_column3[i] + 1,
           ybottom = grid_row3[i], ytop = grid_row3[i] + 1,
           col = rgb(86/255,180/255,233/255,field[grid_row3[i],grid_column3[i]]/100, maxColorValue = 1))
      text(x = grid_column3[i]+0.5, y = grid_row3[i]+0.5,
           label = field[grid_row3[i],grid_column3[i]], 
           adj = c(0.5,0.5), cex = 1)
    }
    
    title(main = paste0("means of strata: ",
                        round(mean(field_data1),1),
                        "/", round(mean(field_data2),1),
                        "/",   round(mean(field_data3),1),
                        "   sd of strata: ",
                        round(sd(field_data1),1),
                        "/", round(sd(field_data2),2),
                        " /", round(sd(field_data1),1)))
     global_mean = mean(field_data1)/6 + mean(field_data2)/3 + mean(field_data3/2)
     text(x = 10, y = 0, label = paste0("overall mean: ",round(global_mean,1)))
    
    par(old.par)
    
  })
  
  output$wrapup_plot1 = renderPlot({
    
    old.par = par(mar = c(1,4,1,2))
    
    # coordinates for field grid
    xleft = rep(seq(1,18,1),18)
    xright = xleft + 1
    ybottom = c(rep(1,18), rep(2,18), rep(3,18), rep(4,18), 
                rep(5,18), rep(6,18), rep(7,18), rep(8,18), 
                rep(9,18), rep(10,18), rep(11,18), rep(12,18),
                rep(13,18), rep(14,18), rep(15,18), rep(16,28),
                rep(17,18), rep(18,18))
    ytop = ybottom + 1
    
    # prepare plot
    plot(x = -1, y = -2, 
         xaxt = "n", xlim = c(0,19), xlab = "",
         yaxt = "n", ylim = c(0,19), ylab = "",
         bty = "n", asp = 1)
    lines(x = c(10,10), y = c(1,19), lwd = 6)
    lines(x = c(1,19), y = c(10,10), lwd = 6)
    
    rect(xleft,ybottom,xright,ytop)
    
    grid_row = c(2,3,3,2,2,3,3,2,8,7,7,8,8,7,7,8,11,12,12,11,11,12,12,11,17,16,16,17,17,16,16,17,14,14,10,9,5,5,5,14,14,5,10,9)
    grid_column = c(2,3,7,8,11,12,16,17,2,3,7,8,11,12,16,17,2,3,7,8,11,12,16,17,2,3,7,8,11,12,16,17,5,14,14,5,5,14,9,10,9,10,5,14)
    rect(xleft = grid_column, xright = grid_column + 1,
         ybottom = grid_row, ytop = grid_row + 1,
         col = 6)
    title(main = "systematic sampling")
    
    par(old.par)
    
  })
  
  output$wrapup_plot2 = renderPlot({
    
    old.par = par(mar = c(1,4,1,2))
    
    # coordinates for field grid
    xleft = rep(seq(1,18,1),18)
    xright = xleft + 1
    ybottom = c(rep(1,18), rep(2,18), rep(3,18), rep(4,18), 
                rep(5,18), rep(6,18), rep(7,18), rep(8,18), 
                rep(9,18), rep(10,18), rep(11,18), rep(12,18),
                rep(13,18), rep(14,18), rep(15,18), rep(16,28),
                rep(17,18), rep(18,18))
    ytop = ybottom + 1
    
    # prepare plot
    plot(x = -1, y = -2, 
         xaxt = "n", xlim = c(0,19), xlab = "",
         yaxt = "n", ylim = c(0,19), ylab = "",
         bty = "n", asp = 1)
    
    rect(xleft,ybottom,xright,ytop)
    
    grid_row = c(1,1,1,1,1,1,1,3,3,3,3,5,5,5,7,7,7,9,12,16,10,14,18,18,13,7,5,18,11)
    grid_column = c(1,3,5,7,9,12,16,1,3,5,7,1,3,5,1,3,7,1,1,1,10,14,18,5,7,13,18,11,18)
    
    rect(xleft = grid_column, xright = grid_column + 1,
         ybottom = grid_row, ytop = grid_row + 1,
         col = 6)
    title(main = "judgmental sampling")
    
    par(old.par)
    
  })
  
  }) # close server
