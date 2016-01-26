#include the libraries necessary for the application and the graph 

library(shiny)
library(ggplot2)

#load the data set to construct graph and perform tasks
crime <- read.csv ("crimefinal.csv", header = T, sep=",")


#server to control the input values
shinyServer(function(input, output, session){
  
  count <- reactiveValues()
  count <- 0
  #observe the input to get college name and update the branch name
  observe({
    colName <- input$collegeName 
    selectedInput <-  crime[grep(colName, crime$Name),]
    bName <- as.character(unique(selectedInput$Branch))
    updateSelectInput(session, inputId = "branchName",choices = bName )
  })
  
  observe({
    state <- input$state
    selectedInput <-  crime[grep(state, crime$State),]
    colname <- as.character(unique(selectedInput$Name))
    updateSelectInput(session, inputId = "collegeName",choices = colname )
  })
  
  observe({
    bName <- input$branchName
    selectedInput <-  crime[grep(bName, crime$Branch),]
    cType <- as.character(unique(selectedInput$Crime_Type))
    updateSelectInput(session, inputId = "crimeType",choices = cType )
  })
  
  
  
  #plot the values according to the input values in the main Panel   
  
  output$mainPlot <- renderPlot({
    
    #check the plot according to plot Button input
    input$plotButton
    
    #stop the graph plotting when plot button is not clicked
    g <- isolate(graphplot())
    g
  })
  
  #check the reactive input values of the college name and branch name to select the input values
  graphplot <- reactive({
    college <- input$collegeName
    branch <- input$branchName
    state <- input$state
    crimetype <- input$crimeType
    branchgraph(state,college,branch,crimetype)
    
  })
  
  # function to plot the graph according to input values
  branchgraph <- function(state,college, branch,crimetype)
  {
    statecrime <- crime[grep(state, crime$State),]
    collegecrime <- statecrime[grep(college, statecrime$Name),]
    branchcrime <- collegecrime[grep(branch, collegecrime$Branch),]
    finaldata <- branchcrime[grep(crimetype, branchcrime$Crime_Type),]
    p <- ggplot(data = finaldata, aes(x = Year, y = Count)) + geom_point() + geom_smooth() 
    p +  ggtitle(paste(college,"-",branch,"-",crimetype, sep = "")) 
    
  }
  
})