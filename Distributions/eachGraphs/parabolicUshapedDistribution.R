
source("colorPalette.R")


##### parabolicUshaped Distribution
### parameter
alpha = c(-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1)
beta = c(0.25, 0.5, 0.75, 1, 2, 4, 8)

### input varialbe
x = seq(-10, 10, length.out = 1000)


### 수명 분포
dparabolicUshaped = function(x, alpha = 0, beta = 1)
{
    fx = (3/(2*beta)) * ((x - alpha)/beta)^2
    return(fx)
}


### 난수 함수
rparabolicUshaped = function (n, min=-10, max=10, alpha = 1, beta = 1) 
{
    normalization = function(x)	{	(x-min(x))/(max(x)-min(x));	}

	xseq = seq(min, max, length=1000000)
	res = sample(xseq, size=n, prob=normalization(dparabolicUshaped(xseq, alpha = alpha, beta = beta)), replace=TRUE)
	return(res)
}


### 누적분포함수
pparabolicUshaped = function(x, alpha = 0, beta = 1)
{
    fx = -(sparabolicUshaped(x, alpha = alpha, beta = beta) - 1)
    return(fx)
}


### 생존함수
sparabolicUshaped = function (x, alpha = 0, beta = 1) 
{
    fx = (1/2) * (1 - ((x-alpha)/beta)^3)
    return(fx)
}


### 위험함수
hparabolicUshaped = function (x, alpha = 0, beta = 1)
{
    fx = dparabolicUshaped(x, alpha, beta) / sparabolicUshaped(x, alpha, beta)
    return(fx)
}





##### Plot
plot.parabolicUshaped_seq = function(x, alpha = 0, beta = 1, xlim=c(0, 10), ylim=c(0, 5), func="dparabolicUshaped")
{
    color=colorPalette(300)

    len_alpha = length(alpha)       # alpha 파라메터의 길이
    len_beta = length(beta)          # beta 파라메터의 길이
    
    color_counter = 1
    for (i in 1:len_alpha)  ### 파라메터: alpha
    {
        color_counter_init = color_counter
        legend_name = NULL;
        
        if (func=="dparabolicUshaped")     # 수명분포
        {
            plot(x, dparabolicUshaped(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Life Distribution Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, dparabolicUshaped(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "pparabolicUshaped")  # 누적분포함수
        {
            plot(x, pparabolicUshaped(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Cumulative Distribution Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, pparabolicUshaped(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "sparabolicUshaped")  # 생존함수
        {
            plot(x, sparabolicUshaped(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Survival Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, sparabolicUshaped(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        else if (func == "hparabolicUshaped")  # 위험함수
        {
            plot(x, hparabolicUshaped(x, alpha=alpha[1], beta=beta[1]), xlim=xlim, ylim=ylim, col=color[1], lwd=2, type = 'n', main="Hazard Function")
            for (j in 1:len_beta)   ### 파라메터: beta
            {
                lines(x, hparabolicUshaped(x, alpha=alpha[i], beta=beta[j]), col=color[color_counter], lwd=2);
                color_counter = color_counter + 1;
                legend_name = c(legend_name, paste("alpha = ", alpha[i], " / beta = ", beta[j], sep=""))
            }
        }
        legend('right', bty = 'n', lwd=2, col=color[color_counter_init:(color_counter - 1)], legend = legend_name)
    }
}

par(mfrow = c(3, 3))
plot.parabolicUshaped_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 5), func="dparabolicUshaped")

par(mfrow = c(3, 3))
plot.parabolicUshaped_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 1), func="pparabolicUshaped")

par(mfrow = c(3, 3))
plot.parabolicUshaped_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 1), func="sparabolicUshaped")

par(mfrow = c(3, 3))
plot.parabolicUshaped_seq(x, alpha, beta, xlim=c(min(x), max(x)), ylim=c(0, 10), func="hparabolicUshaped")
