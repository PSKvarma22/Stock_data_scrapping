#Activity5&6: Building a NSE Stock dataset 
#Name: P S K Varma
#Reg No: 19BDS0093
#Date: 10-11-2021
#last edited: 16-11-2021
library(base)
library(rvest)
library(dplyr)
lsl<-read_html("https://www.moneycontrol.com/india/stockpricequote/pharmaceuticals/lauruslabs/LL05")
lsl
stk_data <- lsl %>% html_elements(css="#nsecp") %>% html_text()
lmn <- lsl %>% html_elements(css="#stk_overview") %>% html_table()
lmn<-as.data.frame(lmn)
lmn<-t(lmn)
lmn<-data.frame(lmn)
lmn<-select(lmn,1:8)
#removing column names
names(lmn)<-NULL
#making first row as the column names
colnames(lmn)<-lmn[1,]
#declaring Price 
Price<-stk_data
#appending Price as the first column of the data set
lmn <-cbind(Price,lmn)
Time1<- as.POSIXct(Sys.time(), "%H:%M:%S")
mins <- 30*60
hrs<-5*60*60
Date_Time<-Time1+mins+hrs
lmn <-cbind(Date_Time,lmn)
Stock_Name<-"Laurus Labs"
lmn <-cbind(Stock_Name,lmn)
#Removing first row
lmn<-lmn[-1,]
#lmn
write.table(lmn,paste0('data/19BDS0093.csv'), sep = "," , append=TRUE, row.names = FALSE,col.names = ifelse(lmn$Date=="11-11-2021", TRUE, FALSE))
