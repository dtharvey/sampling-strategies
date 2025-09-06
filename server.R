# server for sampling strategies

shinyServer(function(input, output, session){
  
  # code for activity 1 plot
  
  output$act1_plot = renderPlot({
    
    old.par = par(mar = c(1,4,1,2))
    
    # how many replicates per sampling site and how many sample sites
    sample_size = input$sample_size
    reps = 1
    
    observe({
      if (input$grid_type == "random sampling"){
        updateSliderInput(session, "sample_size", 
                          max = 15, 
                          label = "number of sites to sample")
      }
    })
    
    observe({
      if (input$grid_type == "proportional stratified sampling"){
        updateSliderInput(session, "sample_size",
                          max = 15,
                          label = "number of sites to sample")
      }
    })
    
    observe({
      if (input$grid_type == "basic sampling grid"){
        updateSliderInput(session, "sample_size",
                          max = 15, 
                          label = "number of sites to sample")
      }
    })
    
    if(input$grid_type == "basic sampling grid"){
      # prepare plot
      plot(x = -1, y = -2, 
           xaxt = "n", xlim = c(0,19), xlab = "",
           yaxt = "n", ylim = c(0,19), ylab = "",
           bty = "n", asp = 1)
      
      rect(xleft,ybottom,xright,ytop)
      
    } else if(input$grid_type == "random sampling"){
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
        grid_row = rep(0,sample_size)
        grid_column = rep(0,sample_size)
        grid_row = sample(seq(1,18,1), sample_size, replace = TRUE)
        grid_column = sample(seq(1,18,1), sample_size, replace = TRUE)
        check = nrow(unique(data.frame(grid_row,grid_column)))
        if(check == sample_size) break
      }

        field_data = rep(0,sample_size)
        for (i in 1:sample_size){
          field_data[i] = field[grid_row[i],grid_column[i]]
          rect(xleft = grid_column[i], xright = grid_column[i] + 1,
               ybottom = grid_row[i], ytop = grid_row[i] + 1,
               col = rgb(86/255,180/255,233/255,field[grid_row[i],grid_column[i]]/100, maxColorValue = 1))
          text(x = grid_column[i]+0.5, y = grid_row[i]+0.5,
               label = field[grid_row[i],grid_column[i]], 
               adj = c(0.5,0.5), cex = 1)
        }
        
        title(main = paste0("mean of samples: ", 
                            round(mean(field_data),1), 
                            "   sd of samples: ", 
                            round(sd(field_data),1)))

    } else {
      
      old.par = par(mar = c(1,4,1,2))
      
      # how many replicates per sampling site and how many sample sites
      size1 = input$sample_size
      size2 = size1 * 2
      size3 = size1 * 3
      reps = 1
      
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
      
      rect(xleft = xleft, ybottom = ybottom, 
           xright = xright, ytop = ytop)
      
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
                          " /", round(sd(field_data3),1)))
      global_mean = mean(field_data1)/6 + mean(field_data2)/3 + mean(field_data3/2)
      text(x = 10, y = 0, label = paste0("overall mean: ",round(global_mean,1)))
      
      par(old.par)
  }
    
    
  })
  
  output$act2_plot = renderPlot({
    
    samples = input$act2_n
    trials = 50
    prob = input$act2_p
    
    results = rbinom(trials, samples, prob)
      
    old.par = par(mar = c(5,4,1,2))
    plot(x = seq(1,trials,1), 
         y = 100*results/samples, type = "b", 
         pch = 19, col = 6, cex = 2,
         xlab = "trial", xlim = c(1,trials),
         ylab = "percent drawn", ylim = c(0,110))
    legend(x = "top", bty = "n", cex = 1, horiz = TRUE,
           legend = c(paste0("number drawn: ", samples),
                      paste0("mean drawn: ", round(mean(results),2)), 
                      paste0("stdev: ", round(sd(results),3)), 
                      paste0("rel stdev: ", round(sd(results)/mean(results),3))),
           text.width = c(10,10,10,10)
           )
    grid()
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
  
  output$act3_plota = renderPlot({
    old.par = par(mar = c(0,0,0,0))
    alpha = 1 - as.numeric(input$act3_ci)/100
    n = seq(2,120,1)
    t = abs(qt(alpha/2,n-1))
    es_ratio = t/sqrt(n)
    improve = c(0.5,1,2,3,4,5)
    samples = rep(0,6)
    rect_color = rep(0,6)
    for (i in 1:6){
      samples[i] = n[which.min(abs(es_ratio - 1/improve[i]))]
      if (samples[i] > input$act3_samplesize){rect_color[i] = 6}
      if (samples[i] > input$act3_samplesize){samples[i] = NA}
    }
    xl = seq(1,6,1)
    xr = xl + 1
    yb = rep(1,7)
    yt = yb + 1
    plot(x = -1, y = -1, xaxt = "n", xlim = c(0,8), xlab = "",
         yaxt = "n", ylim = c(0,3), ylab = "", bty = "n")
    rect(xleft = xl, xright = xr, ybottom = yb, ytop = yt,
         col = rect_color)
    text(x = xl[4], y = yt[4] + 0.5, adj = c(0.5,0.5), cex = 1,
         labels = "number of samples needed to achieve...")
    text(x = xl + 0.5, y = yb - 0.35, adj = c(0.5,0.5), cex = 1,
         labels = c("2", "1", "1/2", "1/3", "1/4", "1/5"))
    text(x = xl[4], y = yb[4] - 0.70, adj = c(0.5,0.5), cex = 1, 
         labels = "...a sampling error/sampling standard deviation ratio of...")
    text(x = xl + 0.5, y = yb + 0.5, adj = c(0.5,0.5), cex = 1,
         labels = samples)
    par(old.par)
  })
  
  output$act4_plot = renderPlot({
    old.par = par(mar = c(0,0,0,0))
    alpha = 1 - as.numeric(input$act4_ci)/100
    xl = seq(1,10,1)
    xr = xl + 1
    yb = c(rep(1,10),rep(2,10),rep(3,10),rep(4,10),rep(5,10),
           rep(6,10), rep(7,10), rep(8,10),rep(9,10),rep(10,10))
    yt = yb + 1
    
    ssamp = input$act4_ssamp
    smeth = input$act4_smeth
    maxerror = input$act4_maxerr
    nrep = 10
    nsamp = 10
    
    error = matrix(data = NA, nrow = nrep, ncol = nsamp)
    for (i in 1:nrep){
      for (j in 1:nsamp){
        if (i == 1 & j == 1){error[i,j = NA]} else {
        error[i,j] = round(abs(qt(alpha/2,i*j-1)) * sqrt(ssamp^2/j + smeth^2/(i*j)),2)
      }}
    }
    
    plot(x = -10, y = -10, xaxt = "n", 
         xlim = c(-1,12), xlab = "", asp = 1,
         yaxt = "n", ylim = c(-1,12), ylab = "", bty = "n")
    text(x = xl+0.5, y = yb[1] - 0.5, labels = xl, adj = c(0.5,0.5), cex = 1)
    text(x = 0.5, y = yb+0.5, labels = yb, adj = c(0.5,0.5), cex = 1, srt = 90)
    for (i in 1:10){
      for (j in 1:10){
        if (i == 1 & j == 1){
          text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 1, labels = Inf)
        } else if (error[i,j] > maxerror){
          text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 1, labels = error[i,j])
        } else {
          text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), 
               cex = 1, labels = error[i,j], col = 6, font = 4)
        }
        rect(xleft = xl, xright = xr, ybottom = yb, ytop = yt)
      }
    }
    text(x = 6,  y = 0, adj = c(0.5,0.5), labels = "number of samples", cex = 1)
    text(x = 0, y = 6, adj = c(0.5,0.5), 
         labels = "number of replicates per sample", cex = 1, srt = 90)
    par(old.par)
  })
  
  }) # close server
