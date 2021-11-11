# Kyle Irvin - PPP Portfolio Project 10/24/2021
# Using PPP loan data, previously consolidated and slimmed by JupyterNotebook Script
# Process and create visualization of Average Loan Size by Business Age
# Visual 1/2
library(readr)
library(scales)
library("ggplot2")

#read in data
ppp_slim_data <- read_csv("C:/Users/kylec/Desktop/PPP portfolio project October 2021/raw data/processed data/ppp_slim_data.csv")
#review data
ppp_slim_data

#Drop low count labels
ppp_slim_data<-ppp_slim_data[!(ppp_slim_data$BusinessAgeDescription=="Change of Ownership" | ppp_slim_data$BusinessAgeDescription=="Startup, Loan Funds will Open Business"),]

#aggregate by BusinessAge -summing Loan Amount
agg_df3<-aggregate(CurrentApprovalAmount ~ BusinessAgeDescription, data = ppp_slim_data, FUN = sum, na.rm = TRUE)


#Aggregating most relevant Business types to be included in the graph
aggdf3<-subset(agg_df3, BusinessAgeDescription=="Existing or more than 2 years old" 
               | BusinessAgeDescription=="New Business or 2 years or less" | BusinessAgeDescription=="Unanswered"
               | BusinessAgeDescription=="Change of Ownership"| BusinessAgeDescription=="Startup, Loan Funds will Open Business" )

#Dividing the Loan by 1 Billion to fit numerical figure in graph
aggdf3$ LoanValue<- aggdf3$CurrentApprovalAmount/1000000000

#Create Plot
ggplot(aggdf3, aes(fill=BusinessAgeDescription, y=LoanValue, x=BusinessAgeDescription )) + ggtitle("Total Value Loaned in Billions USD") + geom_bar(position="dodge", stat="identity")
