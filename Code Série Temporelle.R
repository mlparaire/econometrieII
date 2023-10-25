library(tidyverse)
library(lubridate)
library(rvest)


tt <- read.csv("C:/Users/marti/Downloads/com.csv")
tt <- data.frame(Date = ymd_hms(tt$Datetime),Electric = tt$COMED_MW)
tt %>% arrange(Date) %>% plot(tt$Electric,type='l')

tt %>% arrange()
dates <- seq(as.POSIXct("2011-01-01"), as.POSIXct("2018-08-03"), by = "day")

ggplot(tt,aes(x=Date,y=Electric))+geom_line()+scale_x_datetime(name = "Date",date_breaks = "1 year", date_labels = "%Y")

setwd("C:/économétre II")
tt <- read.csv("solar.csv")
tt$date <- ymd_hms(tt$date)

tt %>% filter() %>% ggplot(aes(x=date,y=kWh,col=name))+geom_line()+facet_wrap(~name)+theme(legend.position = "none")

coal <- read.csv("coal-prices.csv")
Commodity <- read.csv("commodity_prices.csv")
Commodity <- Commodity %>% select(Year,Crude.Oil,Coal,Natural.Gas,Logs,Sawnwood)
commodity <- Commodity %>% pivot_longer(!Year,names_to = "Staples",values_to = "Prices")
commodity %>% ggplot(aes(x=Year,y=Prices))+facet_wrap(~Staples,scales = "free")+geom_line()+labs(caption = "Source :https://www.kaggle.com/datasets/elmoallistair/commodity-prices-19602021/data")

###
url <- "https://www.eia.gov/electricity/monthly/epm_table_grapher.php?t=table_1_01"
url %>% read_html()%>%html_nodes(xpath = "//*/tbody/")%>% html_table()
