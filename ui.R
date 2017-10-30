#
# This is the shiny web application creates an Application which
# helps users view stock market trends of any NASDAQ listed Copany
#

# Load the required libraries
library(shiny)
library(quantmod)
library(plotly)

# Get the Stock Symobls from NASDAQ. This will be given as input choice
# to the user
stockSym <- stockSymbols(exchange="NASDAQ")
stock_sym_list <- as.character(paste(stockSym$Symbol
                                     ,stockSym$Name,sep=","))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  # Application title
  titlePanel("NASDAQ historical stock prices"),
  
  # Sidebar with a  input for 3 values
  # symbols : Takes as input the stock to be ploted
  # date1 : Takes as input the from date from which stock price is to be plotted
  # date2: Takes as input the to date to which stock prices is to be plotted
  sidebarLayout(
    sidebarPanel(
      selectInput('symbols', 'Enter the Name of the Stock', stock_sym_list,multiple=FALSE, selectize=TRUE),
      dateInput("date1", "From Date:", value = "2012-01-01"),
      dateInput("date2", "To Date:", value = "2017-10-01"),
      submitButton("submit")
    ),
    
    # Show a Tabbed Panel with the Plot and a help page
    mainPanel(
      tabsetPanel(type="tabs",
        tabPanel("Plot",plotlyOutput("distPlot")),
        tabPanel("Help",includeMarkdown("help.md"))
      )
      
    )
  )
))
