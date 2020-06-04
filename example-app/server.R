#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

cached_data <- read.csv('data/example-data.csv')

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    output$session_id <- renderText({
        session$token
    })

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

    output$globalDT <- renderDataTable({
        cached_data
    })

    output$localDT <- renderDataTable({
        read.csv('data/example-data.csv')
    })

})
