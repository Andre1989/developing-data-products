
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Parabolic trajectory"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("x0",
                  "Initial X position (m):",
                  0,
                  min = -3,
                  max = 3,
                  step = 0.1),
      numericInput("y0",
                   "Initial Y position (m):",
                   0,
                   min = -3,
                   max = 3,
                   step = 0.1),
      numericInput("teta",
                   "Launching angle (degrees):",
                   0,
                   min = 0,
                   max = 90),
      numericInput("v0",
                   "Initial speed (m/s):",
                   0,
                   min = 0,
                   max = 10,
                   step = 0.1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("trajectoryPlot"),
      h4("Maximum height (m):"),
      verbatimTextOutput("hmax"),
      h4("Time to reach maximum height (s):"),
      verbatimTextOutput("th"),
      h4("Maximum displacement (m):"),
      verbatimTextOutput("xmax"),
      h4("Total distance run (m):"),
      verbatimTextOutput("dmax"),
      h4("Time of flight (s):"),
      verbatimTextOutput("tmax"),
      h4("Optimal launching angle (degrees):"),
      verbatimTextOutput("optimalteta")
    )
  )
))
