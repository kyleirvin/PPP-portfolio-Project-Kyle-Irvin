# Kyle Irvin - PPP Portfolio Project 10/24/2021
# Using PPP loan data, previously consolidated and slimmed by JupyterNotebook Script
# Process and create visualization of Total Amount Loaned by Business Type
# Visual 2/2

#Import Libraries

library(readr)
library("ggplot2")

ppp_slim_data <- read_csv("C:/Users/kylec/Desktop/PPP portfolio project October 2021/raw data/processed data/ppp_slim_data.csv")

agg_df<-aggregate(CurrentApprovalAmount ~ BusinessType + RuralUrbanIndicator, data = ppp_slim_data, FUN = sum, na.rm = TRUE)


#Aggregating most relevant Business types to be included in the graph
aggdf2<-subset(agg_df, BusinessType=="Corporation" | BusinessType=="Limited Liability Company(LLC)" | BusinessType=="Sole Proprietorship"
               | BusinessType=="Subchapter S Corporation" | BusinessType=="Non-Profit Organization" | BusinessType=="Partnership" | BusinessType=="Partnership" )
# | BusinessType=="Self-Employed Individuals"  | BusinessType=="Independent Contractors" 
#Dividing the Loan by 1 Billion to fit numerical figure in graph
aggdf2$ NewLoanValue<- aggdf2$CurrentApprovalAmount/1000000000

#update the "R" and "U" to "Rural" and "Urban" 
aggdf2[aggdf2$RuralUrbanIndicator == "R", "RuralUrbanIndicator"] <- "Rural"
aggdf2[aggdf2$RuralUrbanIndicator == "U", "RuralUrbanIndicator"] <- "Urban"

# Grouped Rural/Urban, Loan Amount, and Business Type together into Bar Graph
ggplot(aggdf2, aes(fill=RuralUrbanIndicator, y=NewLoanValue, x=BusinessType))+
  ggtitle("Loan Amount based on Business Type and Geographical Location In Billions of Dollars")+
  labs(fill = "Business Location") + xlab("Business Type") + ylab("Loan Amount In Billions of Dollars") + geom_bar(position="dodge", stat="identity")




     