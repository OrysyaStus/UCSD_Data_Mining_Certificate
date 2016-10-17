

##
## Assignment 2 - Solution
##


##
## -----------------------------------------------------------
## Problem 1 
## -----------------------------------------------------------
##

extreme=function(x){
    extreme.t=abs(x-mean(x))>3*sd(x)
    if (any(extreme.t))
       print(paste("There are", sum(extreme.t), "extreme values found."))
    else print("There are no extreme values.")
}

test=rnorm(1000)
extreme(test)

##
## -----------------------------------------------------------
## Problem 2 
## -----------------------------------------------------------
##
calCS=function(cal,r){
      cal.u=toupper(cal)
      if (cal.u=="AC") return(round(pi*r^2,3))
      else if (cal.u=="CC") return(round(2*pi*r,3))
      else if (cal.u=="VS") return(round(4*pi*r^3/3,3))
      else if (cal.u=="AS") return(round(4*pi*r^2,3))
      else stop("Your method is not supported")
}

calCS('ac',4)


##
## -----------------------------------------------------------
## Problem 3 
## -----------------------------------------------------------
##
radii=seq(5,25,5)

for (i in radii) {
    print(calCS('AC',i))
}

##
## -----------------------------------------------------------
## Problem 4
## -----------------------------------------------------------
##
library(MASS)

## Create a data set which contains observations with Colour >=17 and School equals "D"
d1=painters[painters$Colour>=17 & painters$School=='D',]

## Create a data set that contains only Da Udine and Barocci.
d2=painters[is.element(row.names(painters), c('Da Udine','Barocci')),]

## Create a data set which contains observations with Colour >=17 and School equals "D", 
## but only with the Composition and Drawing variables.
d3=painters[painters$Colour>=17 & painters$School=='D', 
   c('Composition','Drawing')]

## Create a categorical variable Comp.cat with three approximate equal levels based on Composition.
boundry=quantile(painters$Composition,seq(0,1,by=1/3))
painters$Comp.cat=cut(painters$Composition,boundry,labels=c(1,2,3),
      include.lowest=T,right=F)

 

##
## -----------------------------------------------------------
## Problem 5
## -----------------------------------------------------------
##

data.wide = data.frame(Program = c("CONT", "RI", "WI"), s1 = c(85, 79, 84),
    s2 = c(85, 79, 85), s3 = c(86, 79, 84), s4 = c(85, 80, 83))

## transform it into the long form.
 
long=reshape(data.wide,varying=list(c('s1','s2','s3','s4')),
      v.names='score',timevar='time',direction='long')

## Then transform the long form back to the wide form.
wide=reshape(long,varying=list(c('s1','s2','s3','s4')),idvar='id',
      v.names='score',timevar='time',direction='wide')



##
## -----------------------------------------------------------
## Problem 6
## -----------------------------------------------------------
##

setwd("C:\\Documents and Settings\\xueli\\Desktop\\UCSD R Homework\\Assignment2")
load("datList.RData")

stackDataInList = function(alist){
    result = alist[[1]]
    if (length(alist) ==1) return(result)
    else{
        for (i in 2:length(alist)){
            result = rbind(result, alist[[i]])
        }
    }
    return(result)
}
stackDataInList(datList[1])
stackDataInList(datList[c(1,3,4)])
stackDataInList(datList)






