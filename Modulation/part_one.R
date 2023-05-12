myModuleUI <- function(id, label = "Input text: ") {
  
  ns <- NS(id)
  
  tagList(
    
    textInput(ns("txt"), label),
    
    textOutput(ns("result"))
    
  )
  
}



myModule <- function(input, output, session, prefix = "My first output module") {
  
  output$result <- renderText({
    
    paste0(
      prefix,
      ": ",
      toupper(input$txt),
      tolower(input$txt)
    )
    
  })
  
}




ui <- fluidPage(
  
  myModuleUI("myModule1"),
  
  myModuleUI("myModule2")
  
  
)

server <- function(input, output, session) {
  
  callModule(myModule, "myModule1", prefix = "Converted to uppercase") #
  
  callModule(myModule, "myModule2", prefix = "My mondule 3") #
  
}

shinyApp(ui, server)