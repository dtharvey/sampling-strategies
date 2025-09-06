

xl = seq(1,10,1)
xr = xl + 1
yb = c(rep(1,10),rep(2,10),rep(3,10),rep(4,10),rep(5,10),
       rep(6,10), rep(7,10), rep(8,10),rep(9,10),rep(10,10))
yt = yb + 1

ssamp = sqrt(0.4)
smeth = sqrt(0.07)

maxerroxl = seq(1,10,1)
xr = xl + 1
yb = c(rep(1,10),rep(2,10),rep(3,10),rep(4,10),rep(5,10),
       rep(6,10), rep(7,10), rep(8,10),rep(9,10),rep(10,10))
yt = yb + 1

ssamp = sqrt(0.4)
smeth = sqrt(0.07)
nsamp = 10
nrep = 10
maxerror = 0.5

error = matrix(data = NA, nrow = nrep, ncol = nsamp)
for (i in 1:nrep){
  for (j in 1:nsamp){
    error[i,j] = round(abs(qt(0.025,i*j-1)) * sqrt(ssamp^2/j + smeth^2/(i*j)),2)
  }
}

plot(x = -10, y = -10, xaxt = "n", 
     xlim = c(-1,12), xlab = "",
     yaxt = "n", ylim = c(-1,12), ylab = "", bty = "n")
text(x = xl+0.5, y = yb[1] - 0.5, labels = xl, adj = c(0.5,0.5), cex = 0.5)
text(x = 0.5, y = yb+0.5, labels = yb, adj = c(0.5,0.5), cex = 0.5, srt = 90)
for (i in 1:10){
  for (j in 1:10){
    if (i == 1 & j == 1){
      text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 0.5, labels = error[i,j])
    } else if (error[i,j] > maxerror){
      text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 0.5, labels = error[i,j])
    } else {
    text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), 
         cex = 0.75, labels = error[i,j], col = 6, font = 2)
    }
    rect(xleft = xl, xright = xr, ybottom = yb, ytop = yt)
  }
}
text(x = 6,  y = 0, adj = c(0.5,0.5), labels = "number of samples", cex = 0.5)
text(x = 0, y = 6, adj = c(0.5,0.5), 
     labels = "number of replicates per sample", cex = 0.5, srt = 90)
r = 0.5

error = matrix(data = NA, nrow = nrep, ncol = nsamp)
for (i in 1:nrep){
  for (j in 1:nsamp){
    error[i,j] = round(abs(qt(0.025,i*j-1)) * sqrt(ssamp^2/j + smeth^2/(i*j)),2)
  }
}

plot(x = -10, y = -10, xaxt = "n", 
     xlim = c(-1,12), xlab = "",
     yaxt = "n", ylim = c(-1,12), ylab = "", bty = "n")
text(x = xl+0.5, y = yb[1] - 0.5, labels = xl, adj = c(0.5,0.5), cex = 0.5)
text(x = 0.5, y = yb+0.5, labels = yb, adj = c(0.5,0.5), cex = 0.5, srt = 90)
for (i in 1:10){
  for (j in 1:10){
    if (i == 1 & j == 1){
      text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 0.5, labels = error[i,j])
    } else if (error[i,j] > maxerror){
      text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), cex = 0.5, labels = error[i,j])
    } else {
    text(x = i + 0.5, y = j + 0.5, adj = c(0.5,0.5), 
         cex = 0.75, labels = error[i,j], col = 6, font = 2)
    }
    rect(xleft = xl, xright = xr, ybottom = yb, ytop = yt)
  }
}
text(x = 6,  y = 0, adj = c(0.5,0.5), labels = "number of samples", cex = 0.5)
text(x = 0, y = 6, adj = c(0.5,0.5), 
     labels = "number of replicates per sample", cex = 0.5, srt = 90)
