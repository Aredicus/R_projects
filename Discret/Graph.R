library(shiny)
library(igraph)
library(Matrix)
library(shinyMatrix)

ui <- fluidPage(
  sidebarLayout(
      sidebarPanel(
        numericInput(
          inputId = "my_num",
          label = "Number of points",
          min = 2,
          max = 50,
          value = 2
        ),
        matrixInput(inputId = "matrix",
                    value = matrix(0:0, 2, 2),
                    inputClass = "",
                    rows = list(),
                    cols = list(),
                    class = "numeric",
                    pagination = FALSE,
                    lazy = FALSE
        ),
        actionButton("buttom_update","Update matrix size"),
        actionButton("graph_update","Update graph")
        
    ),
    mainPanel(
      h3("User Output"),
      
      plotOutput("graph")
    )
  )
)

server <- function(input, output) {
  
  output$graph <- renderPlot({
    input$graph_update
    
    gd <- graph_from_adjacency_matrix(input$matrix, weighted = TRUE,
                                      mode = "directed", diag = FALSE)
    plot(gd)
  })
  
  reactive_vals <- reactiveValues(
    num = 1
  )
  
  observeEvent(input$buttom_update,{
     reactive_vals$num <- input$my_num
    
    updateMatrixInput(session = getDefaultReactiveDomain(), "matrix", matrix(0:0, reactive_vals$num, reactive_vals$num))
  })
  
}

shinyApp(ui = ui, server = server)