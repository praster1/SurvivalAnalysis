
source("colorPalette.R")


##### unif2 Distribution
### parameter
alpha = c(-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1)
beta = c(0.25, 0.5, 0.75, 1, 2, 4, 8)

### input varialbe
x = seq(-10, 10, length.out = 1000)


### 수명 분포
dunif2 = function(x, alpha = 0, beta = 1)
{
    fx = rep(1/beta, length(x))
    return(fx)
}


### 누적분포함수
punif2 = function(x, alpha = 0, beta = 1)
{
    fx = (x - alpha)/beta
    return(fx)
}


### 생존함수
sunif2 = function (x, alpha = 0, beta = 1) 
{
    fx = 1 - (x - alpha)/beta
    return(fx)
}


### 위험함수
hunif2 = function (x, alpha = 0, beta = 1)
{
    fx = dunif2(x, alpha, beta) / sunif2(x, alpha, beta)
    return(fx)
}





##### Plot
plot.unif2_seq = function(x, alpha = 0, beta = 1, xlim=c(0, 10), ylim=c(0, 5), func="dunif2")
{
    color=colorPalette(300)

    len_alpha = length(alpha)       # alpha 파라메터의 길이
    len_beta = length(beta)          # beta 파라메터의 길이
    
    color_counter = 1
    for (i in 1:len_alpha)  ### 파라메터: alpha
    {
        color_counter_init = color_counter
        legend_name = NULL;
        
        if (func=="dunif2")     # 수명분포
        {
            plot(x, dunif2(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Life Distribution Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, dunif2(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "punif2")  # 누적분포함수
        {
            plot(x, punif2(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Cumulative Distribution Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, punif2(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "sunif2")  # 생존함수
        {
            plot(x, sunif2(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Survival Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, sunif2(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "hunif2")  # 위험함수
        {
            plot(x, hunif2(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Hazard Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, hunif2(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        legend('right', bty = 'n', lwd=2, col=color[color_counter_init:(color_counter - 1)], legend = legend_name)
    }
}

par(mfrow = c(3, 3))
plot.unif2_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 5), func="dunif2")

par(mfrow = c(3, 3))
plot.unif2_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 2), func="punif2")

par(mfrow = c(3, 3))
plot.unif2_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(-1, 1), func="sunif2")

par(mfrow = c(3, 3))
plot.unif2_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(-1, 1), func="hunif2")

