library(shiny)
library(forecast)

Cafe = read.csv("Cafe.csv",sep=";")
Cafe$Date = as.Date(Cafe$Date, format = "%d/%m/%Y")
Plot_Data = Cafe

shinyUI(fluidPage(titlePanel("Forecast Demand"),
        
  
  sidebarLayout(
    sidebarPanel(
      helpText("This app allow the user use historic information 
               about quantity of sale of coffee in a supermarket in Brazil. 
               The main goal is to predict how many unit of this cafe should 
               be send to this store"),
      hr(),
      
      helpText("You have to choose how many you want to predict and press 
               Forecast button to see in graphic."),
       
      selectInput("var", 
                  label = "Choose how many days of historical data will be used",
                  choices = list("Last 45 days", "Last 90 days",
                              "Last 180 days", "Last 360 days", "All Data"),
                  selected = "Last 360 days"),
      
      sliderInput("ndaysahead", 
                  label = "Range of days to predict:",
                  min = 1, max = 45, value = c(1)),
      hr(),
      actionButton("action", label = "Forecast Demand"),
      fluidRow()
    ),
    
    mainPanel(
      plotOutput('plot')
    )
  )
))