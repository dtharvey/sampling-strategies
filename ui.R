# user interface for sampling shiny app

ui = navbarPage("AC 3.0: Sampling Strategies",
     theme = shinytheme("journal"),
     header = tags$head(
       tags$link(rel = "stylesheet",
                 type = "text/css",
                 href = "style.css") 
     ),
     
  # introduction   
     tabPanel("Introduction",
      fluidRow(
        withMathJax(),
          column(width = 6, 
          wellPanel(
            class = "scrollable-well",
            div(
              class = "html-fragment",
              includeHTML("text/introduction.html")
            ))),
        column(width = 6,
          align = "center",
          br(), br(),
          img(src = "eb_nacl.png", height = "250px"),
          br(), br(),
          img(src = "eb_closeup.png", height = "250px")
      ))),  
     
  # first activity
     tabPanel("Where to Sample",
      fluidRow(
        column(width = 6,
          wellPanel(
            class = "scrollable-well",
            div(
              class = "html-fragment",
              includeHTML("text/activity1.html")
            ))),
        column(width = 6,
          align = "center",
          splitLayout(
            cellWidths = c("300px","300px"),
            selectInput("grid_type","type of sample to collect",
                        choices = c("basic sampling grid",
                                    "random sampling",
                                    "proportional stratified sampling"),
                        selected = "basic sampling grid",
                        selectize = FALSE),
            sliderInput("sample_size", 
                        label = "number of sites to sample",
                        min = 1, max = 15, value = 1, step = 1, 
                        ticks = FALSE)
            ),
          plotOutput("act1_plot", height = "550px")
          ))),
     
  # second activity
     tabPanel("How Much to Collect",
        fluidRow(
          column(width = 6,
            wellPanel(
              class = "scrollable-well",
              div(
                class = "html-fragment",
                includeHTML("text/activity2.html")
              ))),
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
                ))),
  
  # third activity 
     tabPanel("How Many to Collect",
        fluidRow(
          column(width = 6,
            wellPanel(
              class = "scrollable-well",
              div(
                class = "html-fragment",
                includeHTML("text/activity3.html")
              ))),
            column(width = 6,
                  align = "center",
                  splitLayout(
                    radioButtons("act3_ci", "confidence interval",
                                choiceNames = c("80%", "90%","95%","99%"),
                                choiceValues = c(80, 90,95,99),
                                selected = 95, inline = FALSE),
                    sliderInput("act3_samplesize",
                                "maximum number of samples",
                                min = 1, max = 100, value = 20,
                                step = 1, ticks = FALSE)
                       ),
                       plotOutput("act3_plota", height = "125px"),
                ))),

  # fourth activity
     tabPanel("How Many Replicates",
      fluidRow(
        column(width = 6,
          wellPanel(
            class = "scrollable-well",
            div(
              class = "html-fragment",
              includeHTML("text/activity4.html")
            ))),
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
                       plotOutput("act4_plot", height = "500px")
                ))),
  
  # wrapping up
     tabPanel("Wrapping Up",
      fluidRow(
        column(width = 6,
          wellPanel(
            class = "scrollable-well",
            div(
              class = "html-fragment",
              includeHTML("text/wrapup.html")
            ))),
        column(width = 6,
          align = "center",
          plotOutput("wrapup_plot1", height = "300px"),
          plotOutput("wrapup_plot2", height = "300px")
          )))
  ) 
