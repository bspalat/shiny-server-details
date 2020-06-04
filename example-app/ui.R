#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h5("Session Token:"),
            textOutput("session_id"),
            hr(), br(),
            hr(), br(),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4("Plot"),
            plotOutput("distPlot", height = "200px"),
            h4("Global Data"),
            dataTableOutput("globalDT"),
            h4("Local Data"),
            dataTableOutput("localDT")
        )
    )
))
