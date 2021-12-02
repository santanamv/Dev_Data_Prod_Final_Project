#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
peloton <- read.csv("https://raw.githubusercontent.com/santanamv/Dev_Data_Prod_Final_Project/main/cycling%20peloton%20dataset%202020.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(

        # Application title
        titlePanel("Some Analysis of My Cycling Data"),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
                sidebarPanel(fluid = FALSE,
                             selectInput("Variable1","Variable 1:",
                                         c("TotalOutput", "AvgWatts",  "AvgCadence", "AvgSpeed")
                             ),
                             selectInput("Variable2","Variable 2:",
                                         c("TotalOutput", "AvgWatts",  "AvgCadence", "AvgSpeed")
                             ),
                             out = h5("Use the input selector for visual data analysis")
                ),

                # Show a plot of the generated distribution
                mainPanel(
                        plotOutput("cyclingPlot")

                )
        )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

        output$cyclingPlot <- renderPlot({
                # generate bins based on input$bins from ui.R
               graph <- peloton %>% ggplot(aes(x = get(input$Variable1) , y = get(input$Variable2), color = peloton$Class)) +geom_point()

               print(graph + labs(y=input$Variable1, x = input$Variable2, color = "Class Type"))


        })
}

# Run the application
shinyApp(ui = ui, server = server)
