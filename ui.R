#include shiny package for loading the UI application
library(shiny)

#load the data set that can be used to list the data in the drop down list
crime <- read.csv ("crimefinal.csv", header = T, sep=",")

#design a flow layout with sidebar for the users to allow selection of college name and branch name
shinyUI(fluidPage(
  headerPanel("Crime Analysis",windowTitle = "Crime App"),

#design the sidebar layout with the options in the left of the page    
  sidebarLayout(position = "left",
                sidebarPanel(width=3,
                  selectizeInput(inputId = "state", label = "State", choices = levels(crime$State)),
                  selectizeInput(inputId = "collegeName", label = "College Name", choices = "--Selected College--"),
                  selectInput(inputId = "branchName", label = "Branch Name", choices = "--Selected Branches--"),
                  selectInput(inputId = "crimeType", label = "Crime Type", choices = "--Selected Crime Type--"),
                  actionButton(inputId = "plotButton", label = "plot", width = "100%")
                ),
                
#main Panel to plot the desired graph according to the selected inputs
                mainPanel(
                  plotOutput("mainPlot",height="600px",width="100%")
                  
                )
                )
  
    ))