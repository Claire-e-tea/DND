encounter <- function(characters, level, diff = 2, environ){
        mf <- read.csv("mf.csv")
        expthreshdf <- read.csv("expthreshdf.csv")
        expthresh1 <- expthreshdf[level, diff]
        expthreshfinal <- expthresh1 * characters
        finalcr <- Inf
        f <- mf[mf$Environment == environ, ]
        
        while(finalcr > expthreshfinal || finalcr < 0.75 * expthreshfinal){
                
                crow <- sample(1:nrow(f), 1)
                expgiven <- f[crow, 3]
                cname <- f[crow, 2]
                
                n <- sample(1:15, 1)
                
                
                totalcr <- n * expgiven
                if (n == 1){
                        finalcr <- totalcr
                } else if (n == 2){
                        finalcr <- totalcr * 1.5
                } else if (n >= 3 && n <= 6){
                        finalcr <- totalcr * 2
                } else if (n >= 7 && n <= 10){
                        finalcr <- totalcr * 2.5
                } else if (n >= 11 && n <= 14){
                        finalcr <- totalcr * 3
                } else {
                        finalcr <- totalcr * 4
                }
                
                
        }
        paste(n, " ", cname, "(s) attack you!", sep = "") 
}
