# An application to simulate the trajectory of a thrown projectile, neglecting the resistance of the air
library(shiny)

shinyServer(function(input, output) {
  # Reactive variables to be used in multiple functions (teta is the launching angle)
  g    <- reactive({9.8}) # Gravity acceleration
  tmax <- reactive({max(as.numeric(polyroot(c(input$y0, input$v0*sin(input$teta*pi/180), -0.5*g()))))}) # Time of landing of the projectile
  hmax <- reactive({input$y0 + input$v0^2*sin(input$teta*pi/180)^2/(2*g())}) # Maximum height reached
  th   <- reactive({input$v0*sin(input$teta*pi/180)/g()}) # Time at maximum height
  t    <- reactive({seq(0,tmax(),0.001)}) # Time array
  x    <- reactive({input$x0 + input$v0*t()*cos(input$teta*pi/180)}) # Horizontal position array
  y    <- reactive({input$y0 + input$v0*t()*sin(input$teta*pi/180) - 0.5*g()*t()^2}) # Vertical position array
          
  output$trajectoryPlot <- renderPlot({
    # Draw the trajectory plot
    plot(x(), y(), type = "l", main = "Trajectory plot", xlab="Distance traveled (m)", ylab="Heigth (m)", xlim=c(-3.1, 16), ylim=c(-3.1, 8.5), col = 'darkgray')
    points(c(x()[1], input$x0 + input$v0*th()*cos(input$teta*pi/180), tail(x(),1)), c(y()[1], hmax(), tail(y(),1)))
    lines(c(-4,17),y=c(0,0))
    lines(c(0,0),y=c(-4,10))

  })
  # Display some parameters about he projectile movement
  output$hmax <- renderText(round(hmax(),2))
  output$tmax <- renderText(round(tmax(),2))
  output$dmax <- renderText(round(sum(sqrt(diff(x())^2+diff(y())^2)),2))
  output$xmax <- renderText(round(sqrt(tail(x(),1)^2+input$y0^2),2))
  output$th   <- renderText(round(th(),2))
  output$optimalteta <- renderText(round(atan(input$v0/(sqrt(input$v0^2+2*g()*input$y0)))*180/pi,1))
  
  
  
})
