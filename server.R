library(shiny)
library(forecast)
# server.R

Cafe = read.csv("Cafe.csv",sep=";")
Cafe$Date = as.Date(Cafe$Date, format = "%d/%m/%Y")


shinyServer(function(input, output,session) {
  
  
  output$plot <- reactivePlot(function() {
    Plot_Data = switch(input$var, 
                       "Last 45 days" = Cafe[(nrow(Cafe) - 44):nrow(Cafe),],
                       "Last 90 days" = Cafe[(nrow(Cafe) - 89):nrow(Cafe),],
                       "Last 180 days" = Cafe[(nrow(Cafe) - 179):nrow(Cafe),],
                       "Last 360 days" = Cafe[(nrow(Cafe) - 359):nrow(Cafe),],
                       "All Data" = Cafe)
    
      input$action
     
      isolate({
      fit = auto.arima(Plot_Data$Qnt, max.D = 12,max.d = 12)
      p = forecast(fit,h = input$ndaysahead)
      plot(p, main = "Quantity of Sale of Coffee", ylab = "Daily Sale of Coffee in Quantity", 
           xlab = "Days")
      grid()
    })
      
    
  }, height=400)
  
  
}) 
