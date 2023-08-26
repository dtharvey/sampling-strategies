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
     
     tabPanel("Random Sampling",
      fluidRow(
        column(width = 6,
          wellPanel(
            includeHTML("text/activity1.html")
      )),
        column(width = 6,
          align = "center",
          splitLayout(
            sliderInput("act1_size", label = "number of sample sites",
                        min = 3, max = 30, value = 9, step = 1, 
                        ticks = FALSE, width = "150px"),
            sliderInput("act1_reps", 
                         label = "number of replicates per site",
                         min = 1, max = 5, value = 1, step = 1, 
                        ticks = FALSE),
            radioButtons("act1_display",
                         label = "display results of sampling",
                         choices = c("yes", "no"), selected = "no",
                         inline = TRUE)
          ),
          plotOutput("act1_plot", height = "700px")
          )
      )),
     
     tabPanel("Stratified Sampling",
              fluidRow(
                column(width = 6,
                       wellPanel(
                         includeHTML("text/activity2.html")
                       )),
                column(width = 6,
                       align = "center",
                       splitLayout(
                         sliderInput("act2_size", 
                                     label = "number of sample sites for stratum 1",
                                     min = 3, max = 10, value = 3, step = 1, 
                                     ticks = FALSE),
                         sliderInput("act2_reps", 
                                     label = "number of replicates per site",
                                     min = 1, max = 5, value = 1, step = 1, 
                                     ticks = FALSE)
                       ),
                       plotOutput("act2_plot", height = "700px")
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
