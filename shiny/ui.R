library(shiny)
library(shinythemes)


shinyUI(navbarPage("Stopnja brezposelnosti po regijah", 
                   theme=shinytheme("united"),

        
          tabPanel("Graf",
                   sidebarPanel(
                     selectInput(inputId = "Leto",
                                 label = "Izberi leto",
                                 choices = unique(uvoz_4$Leto))
                   ),
                   mainPanel(plotOutput("graf"))
          ),
          tabPanel("Tabela povprečne stopnje brezposelnosti",
                   DT::dataTableOutput("brezposelnost"))
                   
        

  )
)

