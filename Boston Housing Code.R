require("mosaic")

# setting the directory
setwd("~/Google Drive/3rd Year/STAC67")
# reading the data and saving it in full_dataset
full_dataset <- read.csv("~/Google Drive/3rd Year/STAC67/housing.proper.csv")
# naming the columns for convenience
colnames(full_dataset) <- c("CR", "RLZ", "NRBA", "CHR", "NOC", "ANR", "BPR", "DEC", "ATH", "PTxR", "PTR", "AA", "LSP", "MVH")

### Model Selection ###

# makes it random
set.seed(12345) 

# natural logarithm for the response data.
full_dataset$MVH <- log(full_dataset$MVH)

# indexes of random sample 
train_id = sample(nrow(full_dataset), nrow(full_dataset)*0.7)
# indexed value of the sample for building set
model_building = full_dataset[train_id,]
# non-indexed value for the validating set
model_validating = full_dataset[-train_id,]

# correlation between the variables
cor(full_dataset)

#### A summary of the model ####

# MODEL SELECTED
model <-  lm(MVH ~ CR + CHR + NOC + ANR + DEC + ATH + PTxR + PTR + AA + LSP, data=model_building )
# summary 
summary(model) 
# analysis of variance for the model
aov(model)

# MSPE Code

# to check if model any good
newx <- model_validating[,c(1, 4, 5, 6, 8, 9, 10, 11, 12, 13)]
colnames(newx) <- c("CR", "CHR", "NOC", "ANR", "DEC", "ATH", "PTxR", "PTR", "AA", "LSP")
Y_pred <- predict(model, newx)
Y_obs <- model_validating[,14] 
n_star <- nrow(newx)
MSPE <- sum( (Y_obs-Y_pred)^2/n_star )
MS_res <- (summary(model)$sigma)^2


#### Model Diagnostics ####

# Residuals vs Fitted values plot
plot(residuals(model) ~ model_building$MVH, xlab = "Fitted Values", ylab="Residuals", col = "black", pch =1, main = "Residuals VS Fitted Values")
abline(h = 0, col = "red", lwd = 1)

# Normal QQ plot 
# to check if errors follow normal distributiom
qqnorm (residuals(model), main = "Normal Q-Q Plot", ylab = "Standardized Residuals", xlab = "Theoretical Quantiles", col=" red ", pch=1)
qqline(residuals(model), col = "dodgerblue", lwd = 1)

#### Outliers ####

# y outliers
outlierTest(model)

# studentized deleted residuals
t <- rstudent(model)
# significance level
alpha <- 0.05
# total number of observations
n <- 506
# total number of variables in the model
p_prime = length(coef(model)) 

# studentized critical point
t_crit <- qt(1-alpha/(2*n),n-p_prime-1)
round(t,2)
t_crit

# find studentized residuals greater than the critical point
which(abs(t) > t_crit)

# x leverage
Pii <- hatvalues(model)
round(Pii, 2)
which(Pii > 2*p_prime/n)
which(Pii > 0.5)

#### Influence ####

require("mvinfluence")

# Influence plot code
influencePlot(model, main="Influence Plot", sub="Circle size is proportial to Cook's Distance" )

# calculating DFFITS where DFFITS value > 1 is significant, since our validating data set is relatively small
DFFITS <- dffits(model)
which(DFFITS > 1)

# calculating Cook's distance 
D <- cooks.distance(model)

# F(q, p', n-p') to compare Cook's distance with the 10th percentile
p_prime = length(coef(model)) 
n <- length(model_building$MVH)
qf(0.1, p_prime, n-p_prime)
which(D > qf(0.1, p_prime, n-p_prime))

# calculating DFBETAS where DFBETAS value > 1 is significant since our validating data set is relatively small.
DFBETAS <- dfbetas(model)
which(DFBETAS > 1)
