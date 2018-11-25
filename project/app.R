library(shiny)
source("data.R")

server <- function(input, output) {
	datasetInput <- reactive({
		switch(input$dataset,
			"Publisher" = Publisher,
			"Name" = Name,
			"Platform" = Platform,
			"Rating" = CMdata)
	})
	
	# Generate a summary of the dataset
	output$summary <- renderPrint({
		dataset <- datasetInput()
		summary(dataset)
	})
	
	# Show the first "n" Observations
	output$view <- renderTable({
		head(datasetInput(), n = input$obs)
	})
}

ui <- shinyUI(pageWithSidebar(
	headerPanel("Video Games"),
	sidebarPanel(
		selectInput("dataset", "Filter by:",
			choices = c("Publisher", "Name", "Platform", "Rating")),
		numericInput("obs", "Number of Games:", 10)
	),
	mainPanel(
		verbatimTextOutput("summary"),
		tableOutput("view")
	)
))

app <- shinyApp(ui = ui, server = server)
runApp(app)
