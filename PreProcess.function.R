#### License ####
#Copyright (C) {2014}  {Fichou Dimitri}
#{dimitrifichou@laposte.net}

#This program is free software; you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation; either version 2 of the License, or
# any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along
#with this program; if not, write to the Free Software Foundation, Inc.,
#51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

#### rTLC ######

f.preprocess <- function(data,preprocess.order,preprocess.option,training.data){
  for(i in preprocess.order){
    if(i == 'Warping'){
      data <- eval(parse(text=paste0(i,'(data,preprocess.option,training.data)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,preprocess.option,training.data)')))
    }
    if(i == 'medianFilter'){
      data <- apply(data,c(2,3),medianFilter,preprocess.option$medianFilter)
      training.data <- apply(training.data,c(2,3),medianFilter,preprocess.option$medianFilter)
    }
    if(i == 'gammaCorrection'){
      data <- data^preprocess.option$gammaCorrection
      training.data <- training.data^preprocess.option$gammaCorrection
    }
    if(i == 'Standard.Normal.Variate'){
      data <- eval(parse(text=paste0(i,'(data)')))
      training.data <- eval(parse(text=paste0(i,'(training.data)')))
    }
    if(i == 'Baseline.correction'){
      data <- eval(parse(text=paste0(i,'(data,preprocess.option)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,preprocess.option)')))
    }
    if(i == 'Smoothing'){
      data <- eval(parse(text=paste0(i,'(data,preprocess.option)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,preprocess.option)')))
    }
    if(i == 'Mean.centering'){
      data <- eval(parse(text=paste0(i,'(data,training.data)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,training.data)')))
    }
    if(i == 'Autoscaling'){
      data <- eval(parse(text=paste0(i,'(data,training.data)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,training.data)')))
    }
    if(i == 'Baseline.correction'){
      data <- eval(parse(text=paste0(i,'(data,preprocess.option)')))
      training.data <- eval(parse(text=paste0(i,'(training.data,preprocess.option)')))
    }
  }
  return(data)
}
Baseline.correction <- function(data,input){
  input <- input$Baseline
  data.tot <- data
  data<-data.tot[,,1]    
  if(input$method == "als"){data<-baseline(data,method=input$method,lambda=input$lambda.1,p=input$p,maxit=input$maxit.1)}
  if(input$method == "fillPeaks"){data<-baseline(data,method=input$method,lambda=input$lambda.2,hwi=input$hwi,it=input$it,int=input$int)}
  if(input$method == "irls"){data<-baseline(data,method=input$method,lambda1=input$lambda1,lambda2=input$lambda2,maxit=input$maxit.2,wi=input$wi)}
  if(input$method == "lowpass"){data<-baseline(data,method=input$method,steep=input$steep,half=input$half)}
  if(input$method == "medianWindow"){data<-baseline(data,method=input$method,hwm=input$hwm,hws=input$hws,end=input$end)}
  if(input$method == "modpolyfit"){data<-baseline(data,method=input$method,degree=input$degree,tol=input$tol,rep=input$rep)}
  if(input$method == "peakDetection"){data<-baseline(data,method=input$method,left=input$left,right=input$right,lwin=input$lwin,rwin=input$rwin)}
  if(input$method == "rfBaseline"){data<-baseline(data,method=input$method)}
  if(input$method == "rollingBall"){data<-baseline(data,method=input$method,wm=input$wm,ws=input$ws)}
  data.tot[,,1]<-getCorrected(data)
  data<-data.tot[,,2]    
  if(input$method == "als"){data<-baseline(data,method=input$method,lambda=input$lambda.1,p=input$p,maxit=input$maxit.1)}
  if(input$method == "fillPeaks"){data<-baseline(data,method=input$method,lambda=input$lambda.2,hwi=input$hwi,it=input$it,int=input$int)}
  if(input$method == "irls"){data<-baseline(data,method=input$method,lambda1=input$lambda1,lambda2=input$lambda2,maxit=input$maxit.2,wi=input$wi)}
  if(input$method == "lowpass"){data<-baseline(data,method=input$method,steep=input$steep,half=input$half)}
  if(input$method == "medianWindow"){data<-baseline(data,method=input$method,hwm=input$hwm,hws=input$hws,end=input$end)}
  if(input$method == "modpolyfit"){data<-baseline(data,method=input$method,degree=input$degree,tol=input$tol,rep=input$rep)}
  if(input$method == "peakDetection"){data<-baseline(data,method=input$method,left=input$left,right=input$right,lwin=input$lwin,rwin=input$rwin)}
  if(input$method == "rfBaseline"){data<-baseline(data,method=input$method)}
  if(input$method == "rollingBall"){data<-baseline(data,method=input$method,wm=input$wm,ws=input$ws)}
  data.tot[,,2]<-getCorrected(data)
  data<-data.tot[,,3]    
  if(input$method == "als"){data<-baseline(data,method=input$method,lambda=input$lambda.1,p=input$p,maxit=input$maxit.1)}
  if(input$method == "fillPeaks"){data<-baseline(data,method=input$method,lambda=input$lambda.2,hwi=input$hwi,it=input$it,int=input$int)}
  if(input$method == "irls"){data<-baseline(data,method=input$method,lambda1=input$lambda1,lambda2=input$lambda2,maxit=input$maxit.2,wi=input$wi)}
  if(input$method == "lowpass"){data<-baseline(data,method=input$method,steep=input$steep,half=input$half)}
  if(input$method == "medianWindow"){data<-baseline(data,method=input$method,hwm=input$hwm,hws=input$hws,end=input$end)}
  if(input$method == "modpolyfit"){data<-baseline(data,method=input$method,degree=input$degree,tol=input$tol,rep=input$rep)}
  if(input$method == "peakDetection"){data<-baseline(data,method=input$method,left=input$left,right=input$right,lwin=input$lwin,rwin=input$rwin)}
  if(input$method == "rfBaseline"){data<-baseline(data,method=input$method)}
  if(input$method == "rollingBall"){data<-baseline(data,method=input$method,wm=input$wm,ws=input$ws)}
  data.tot[,,3]<-getCorrected(data)
  data<-data.tot[,,4]    
  if(input$method == "als"){data<-baseline(data,method=input$method,lambda=input$lambda.1,p=input$p,maxit=input$maxit.1)}
  if(input$method == "fillPeaks"){data<-baseline(data,method=input$method,lambda=input$lambda.2,hwi=input$hwi,it=input$it,int=input$int)}
  if(input$method == "irls"){data<-baseline(data,method=input$method,lambda1=input$lambda1,lambda2=input$lambda2,maxit=input$maxit.2,wi=input$wi)}
  if(input$method == "lowpass"){data<-baseline(data,method=input$method,steep=input$steep,half=input$half)}
  if(input$method == "medianWindow"){data<-baseline(data,method=input$method,hwm=input$hwm,hws=input$hws,end=input$end)}
  if(input$method == "modpolyfit"){data<-baseline(data,method=input$method,degree=input$degree,tol=input$tol,rep=input$rep)}
  if(input$method == "peakDetection"){data<-baseline(data,method=input$method,left=input$left,right=input$right,lwin=input$lwin,rwin=input$rwin)}
  if(input$method == "rfBaseline"){data<-baseline(data,method=input$method)}
  if(input$method == "rollingBall"){data<-baseline(data,method=input$method,wm=input$wm,ws=input$ws)}
  data.tot[,,4]<-getCorrected(data)
  return(data.tot)
}

Mean.centering <- function(data,training.data){
  data.a<-scale(data[,,1],center=colMeans(training.data[,,1]),scale=F)
  data.b<-scale(data[,,2],center=colMeans(training.data[,,2]),scale=F)
  data.c<-scale(data[,,3],center=colMeans(training.data[,,3]),scale=F)
  data.d<-scale(data[,,4],center=colMeans(training.data[,,4]),scale=F)
  return(abind(data.a,data.b,data.c,data.d,along=3))
}
Autoscaling <- function(data,training.data){
  data.a<-scale(data[,,1],center=F,scale=apply(training.data[,,1],2,sd))
  data.b<-scale(data[,,2],center=F,scale=apply(training.data[,,2],2,sd))
  data.c<-scale(data[,,3],center=F,scale=apply(training.data[,,3],2,sd))
  data.d<-scale(data[,,4],center=F,scale=apply(training.data[,,4],2,sd))
  return(abind(data.a,data.b,data.c,data.d,along=3))
}


Standard.Normal.Variate <- function(data){
  data.a<-standardNormalVariate(data[,,1])
  data.b<-standardNormalVariate(data[,,2])
  data.c<-standardNormalVariate(data[,,3])
  data.d<-standardNormalVariate(data[,,4])
  return(abind(data.a,data.b,data.c,data.d,along=3))
}

Smoothing <- function(data,input){
  input <- input$Smoothing
  data.a<-aaply(data[,,1],.margins=c(1),.fun=savitzkyGolay,w=input$window.size,p=input$poly.order,m=input$diff.order)
  data.b<-aaply(data[,,2],.margins=c(1),.fun=savitzkyGolay,w=input$window.size,p=input$poly.order,m=input$diff.order)
  data.c<-aaply(data[,,3],.margins=c(1),.fun=savitzkyGolay,w=input$window.size,p=input$poly.order,m=input$diff.order)
  data.d<-aaply(data[,,4],.margins=c(1),.fun=savitzkyGolay,w=input$window.size,p=input$poly.order,m=input$diff.order)
  return(abind(data.a,data.b,data.c,data.d,along=3))
}

Warping <- function(data,input,training.data){
  input <- input$Warping
  if(input$warpmethod == "ptw"){
    truc <- c(init.coef=input$ptw.init.coef,warp.type=input$ptw.warp.type,
              optim.crit=input$ptw.optim.crit,trwdth=input$ptw.trwdth)
    data <- do.ptw(data=data,ref=input$ptw.warp.ref,training.data =training.data)
  }
  if(input$warpmethod=='dtw'){
    data <- do.dtw(data=data,ref=input$dtw.warp.ref,training.data =training.data,split=input$dtw.split)
  }
  return(data)
}
do.dtw <- function(data,ref,training.data,split=T){
  if(split == T){
    for(i in seq(4)){
      for(j in seq(nrow(data))){
        al <- dtw(data[j,,i],training.data[ref,,i])
        truc <- redim(rbind(data[j,al$index1,i],training.data[ref,al$index2,i]),2,ncol(data))[1,]
        data[j,,i] <- truc
      }
    }
  }else{
    for(j in seq(nrow(data))){
      al <- dtw(data[j,,],training.data[ref,,])
      truc <- redim(data[j,al$index1,],ncol(data),4)
      data[j,,] <- truc
    }
  }
  return(data)
}
do.ptw <- function(data,ref,training.data){
  data[,,1]<-ptw(ref = training.data[ref,,1],data[,,1])$warped.sample
  data[,,2]<-ptw(ref = training.data[ref,,2],data[,,2])$warped.sample
  data[,,3]<-ptw(ref = training.data[ref,,3],data[,,3])$warped.sample
  data[,,4]<-ptw(ref = training.data[ref,,4],data[,,4])$warped.sample
  # data<-abind(data.a,data.b,data.c,data.d,along=3)
  data[is.na(data)] <- 0
  return(data)
}