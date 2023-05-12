myModuleUI <- function(id, label = "Input text: ") {
  
  ns <- NS(id)
  
  tagList(
    
    textInput(ns("txt"), label),
    
    textOutput(ns("result")),
    
    sliderInput(ns("slide"), "numbers", 10, 100, 50),
    
    numericInput(ns("mean"), "Mean", min = 1, max = 100, value = 70),
    
    numericInput(ns("sd"), "STD", min = 1, max = 100, value = 70),
    
    highchartOutput(ns("myfirst_highchart"))
  )
  
}



myModule <- function(input, output, session, prefix = "My first output module") {
  
  output$result <- renderText({
    
    paste0(
      "Ты ввел: ",
      input$txt,
      ", а на слайдаре: ",
      input$slide
    )
    
  })
  
  output$myfirst_highchart <- renderHighchart({
    df <-  data.frame(
      x = rnorm(
        input$slide,
        input$mean,
        input$sd
      ),
      y = rnorm(input$slide,5,30)
    )
    hchart(
      df,
      "point",
      hcaes(
        x = x,
        y = y
      )
    )
    
    
  })
  
}




ui <- fluidPage(
  
  myModuleUI("myModule1"),
  
  myModuleUI("myModule2")
  
  
)

server <- function(input, output, session) {
  
  callModule(myModule, "myModule1", prefix = "First slider") #
  
  callModule(myModule, "myModule2", prefix = "Second slider") #
  
}

shinyApp(ui, server)