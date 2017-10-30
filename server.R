#
# This is the server logic for application to plot the stock market prices

# Load the Libraries

library(shiny)
library(quantmod)
library(plotly)

# This function takes as input the stock market symbol, the from date and to Date
# and plot the stock price of the stock between the from and to dates
plot_sym<-function(sym,fromDate,toDate){
  fin_data<-getSymbols(sym,src="google",env=NULL,from=fromDate,to=toDate)
  fin_data1<-as.data.frame(fin_data)
  fin_data1[,6]<-time(fin_data)
  x = list(title = 'Year',
           zeroline = TRUE)
  y = list(title = 'Opening Stock Price (in $)',
           zeroline = TRUE)
  p<-final_plot<-plot_ly(x=fin_data1[,6],y=fin_data1[,1],type="scatter",mode="lines") %>%
    layout(title="Stock Price",xaxis=x,yaxis=y)
}

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlotly({
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    print("In Server")
    symbol_out <- unlist(strsplit(as.character(input$symbols),","))[1]
    
    plot_sym(symbol_out,as.Date(input$date1),as.Date(input$date2))
  })
})
