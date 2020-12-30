## Data Analysis of Boston Housing prices
Housing values are one of the standard metrics used by many shareholders in the economy. The median values help homebuyers and insurance companies to make more efficient choices. There are many aspects that cause fluctuation of housing values. To detect what factors contribute to the housing values, we attempt to create a model with elements chosen through extensive data analysis. We use R for statistical analysis to find a relationship between the median housing values and the considered factors in the model.

## Prerequisites/Installments:
Install RStudio: https://rstudio.com/products/rstudio/download/
OR 
Use RStudioCloud on browser for free: https://rstudio.com/
Install “Mosaic” and “MVInfluence” packages on your Rstudio to make sure your code runs smoothly. 

Requires understanding of statistical data analysis, linear regression, data modelling/validating techniques and programming language R. 

## Getting Started
Save the data set housing.proper.csv in your local directory. 
If you do not have R installed on your computer, you can use RCloud (https://rstudio.com/) for free. 
Save all the necessary files in the same directory and run R.

## Tests:

Set.seed for randomization

Use half of the data points for building the desired model and the other half to validate the model to check if the built model is any good to answer the questions we have. 

### MSPE Code
If Mean Square of Residuals is approximately the Mean Squared Prediction Error or the two mentioned values are quite near to each other, we conclude that the model is valid.

### Residuals vs. Fitted 
To check if there are any patterns. 

### Q-Q Plot
To check if the assumption of Normality for the data set holds. 

### Outlying Y Observations
To check if any suspicious/outlier observation. 
To check if the outliers are influential. 

## Authors
Shamsun Nila 
Ying Xie
Mayuri Kakkar
Li Monique 
Chengli Yang 	

This project was made under STAC67H3: Regression Analysis under supervision of Dr. Caren Hasler in University of Toronto Scarborough, in 2019. 
