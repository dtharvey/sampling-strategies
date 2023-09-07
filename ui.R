# user interface for sampling shiny app

library(shiny)
library(shinythemes)


ui = navbarPage("AC 3.0: Sampling Strategies",
     theme = shinytheme("journal"),
     header = tags$head(
       tags$link(rel = "stylesheet",
                 type = "text/css",
                 href = "style.css") 
     ),
     
     tabPanel("Introduction",
      fluidRow(
        column(width = 6, 
          wellPanel(
            includeHTML("text/introduction.html") # link to introduction
      )),
        column(width = 6,
          align = "center",
          br(),
          br(),
          img(src = "eb_nacl.png", height = "300px"),
          br(),
          br(),
          img(src = "eb_closeup.png", height = "300px")
          )
      )),  
     
     tabPanel("Where to Collect Samples",
      fluidRow(
        column(width = 6,
          wellPanel(
            includeHTML("text/activity1.html")
      )),
        column(width = 6,
          align = "center",
          splitLayout(
            selectInput("grid_type","sampling grid",
                        choices = c("basic sampling grid","random sampling",
                                    "stratified sampling"),
                        selected = "basic sampling grid",
                        selectize = FALSE),
            sliderInput("sample_size", label = "number of random samples",
                        min = 1, max = 30, value = 1, step = 1, 
                        ticks = FALSE, width = "300px"),
            ),
          plotOutput("act1_plot", height = "700px")
          )
      )),
     
     tabPanel("How Much Sample to Collect",
              fluidRow(
                column(width = 6,
                       wellPanel(
                         includeHTML("text/activity2.html")
                       )),
                column(width = 6,
                       align = "center",
                       splitLayout(
                         sliderInput("act2_n","sample size (n)",
                                     min = 10, max = 1000, value = 10,
                                     step = 10, ticks = FALSE),
                         sliderInput("act2_p", "fraction of particles w/analyte (p)",
                                     min = 0.01, max = 0.99, value = 0.50,
                                     step = 0.01, ticks = FALSE)
                       ),
                       plotOutput("act2_plot", height = "500px")
                )
              )),
     
     tabPanel("How Many Samples to Collect",
              fluidRow(
                column(width = 6,
                       wellPanel(
                         includeHTML("text/activity3.html")
                       )),
                column(width = 6,
                       align = "center",
                       splitLayout(
                         radioButtons("act3_ci", "confidence interval",
                                     choiceNames = c("80%", "90%","95%","99%"),
                                     choiceValues = c(80, 90,95,99),
                                     selected = 95, inline = FALSE),
                         sliderInput("act3_samplesize","maximum samples",
                                     min = 1, max = 100, value = 20,
                                     step = 1, ticks = FALSE)
                       ),
                       plotOutput("act3_plota", height = "125px"),
                )
              )),
     
     tabPanel("How Many Replicates to Run",
              fluidRow(
                column(width = 6,
                       wellPanel(
                         includeHTML("text/activity4.html")
                       )),
                column(width = 6,
                       align = "center",
                       splitLayout(
                         radioButtons("act4_ci", "confidence interval",
                                      choiceNames = c("80%", "90%","95%","99%"),
                                      choiceValues = c(80, 90,95,99),
                                      selected = 95, inline = FALSE),
                         sliderInput("act4_ssamp", "st dev for sampling",
                                     min = 0.1, max = 2, value = 1, 
                                     step = 0.1, ticks = FALSE, width = "150px"),
                         sliderInput("act4_smeth", "st dev for method",
                                     min = 0.1, max = 2, value = 1,
                                     step = 0.1, ticks = FALSE, width = "150px"),
                         sliderInput("act4_maxerr", "maximum error",
                                     min = 0.1, max = 2, value = 1,
                                     step = 0.1, ticks = FALSE, width = "150px")
                       ),
                       plotOutput("act4_plot", height = "600px")
                )
              )),
     
     tabPanel("Wrapping Up",
      fluidRow(
        column(width = 6,
               wellPanel(id = "wrapuppanel",
                  style = "overflow-y:scroll; max-height: 750px",
                  includeHTML("text/wrapup.html"))),
        column(width = 6,
          align = "center",
          plotOutput("wrapup_plot1", height = "380px"),
          plotOutput("wrapup_plot2", height = "380px")
          )
          
      )) 
     
     ) 
