# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  dataInputAdjusted <- reactive({
    adjust(dataInput())
  })
  
  output$plot <- renderPlot({   
    
    if (input$adjust) data <- dataInputAdjusted()
    else data <- dataInput()
    
    chartSeries(data, theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })
})