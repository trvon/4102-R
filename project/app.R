source("data.R")

server <- function(input, output) {
	datasetInput <- reactive({
		switch(input$dataset,
			"Publisher" = publisherData(input$genre),
			"Genre" = yearRange(input$year, input$range, input$region),
			# Selects table passed on table returned from function
			"Rating" = ratingType(input$ratingsMethod, input$regionSales))
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

	output$plot <- renderPlot({
		data <- datasetInput()
		switch(input$dataset,
			"Publisher" = { plot(data$Publisher)},
			"Genre" = { plot(data$Genre) }, # , data[input$regionSales]) },
			"Rating" = { plot(data$Sales, data$Score)} # , data[input$ratingsMethod]) }
		)
	})
}

ui <- pageWithSidebar(
	headerPanel("Video Games"),
	sidebarPanel(
		# Data selection
		selectInput("dataset", "Filter by:",
			choices = c("Publisher", "Genre", "Rating")),
		# The amount of data shown
		numericInput("obs", "Number of Games:", 10),
		# Checks if Rating has been selected
		conditionalPanel(
			condition = "input.dataset == 'Rating'",
			selectInput("ratingsMethod", "Scores", list("Critic", "User"),),
			selectInput("regionSales", "Region Sales", list("NA", "EU", "JP", "Other"))
		),
		# Checks if Genre has been selected
		conditionalPanel(
			condition = "input.dataset == 'Genre'",
			sliderInput("year", "Year of Release:",
				min = 1980, max = 2017, value = 1980),
			sliderInput("range", "Year range:",
				min = 1, max = 10, value = 5),
			selectInput("region", "Region Sales", list("NA", "EU", "JP", "Other"))
		),
		# Check if publisher has been selected
		conditionalPanel(
			condition = "input.dataset == 'Publisher'",
			selectInput("genre", "Select Genre", list("Sports", "Platform", "Racing", "Role-Playing", "Puzzle", "Shooter", "Action", "Adventure", "Simulation"))
		)
	),

	mainPanel(
		# verbatimTextOutput("summary"),
		plotOutput("plot"),
		tableOutput("view")
	)
)

# Creates Shiny APP object and starts server
app <- shinyApp(ui = ui, server = server)
runApp(app)
