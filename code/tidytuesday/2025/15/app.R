library(shiny)
library(bslib)
library(tidyverse)

penguins = read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-15/penguins.csv')

plot1 = ggplot(penguins, mapping = aes(fill = species, x = species,y = body_mass, colour = species, shape = species)) + geom_bar(position = "dodge", stat ="identity") + facet_wrap(~island)

page1 <- 
  layout_column_wrap(
    width = 1/2,
    height = 280,
    card(
      height = 280,
      card_header("Visualization"),
      card_body(plotOutput("plot1"))
    ),
    card(height = 280,
         card_header("Table"),
         card_body(DT::DTOutput("dataTable1"))
    )
  )

page2 <- card(
  height = 300,
  card_header("Body mass for each species, split by gender"),
  card_body(
    plotOutput("plot2")
  )
)

ui <- 
  page_navbar(
    
    
    theme = bs_theme(bootswatch = "minty"),
    
    title = "TidyTuesday Week 15",
    id = "nav",
    nav_panel("Home", 
       layout_sidebar(
        sidebar = sidebar(
          selectInput(inputId = "y1", label = "Y-axis:",
                      choices = c("body_mass",
                                  "bill_len" ,
                                  "bill_dep",
                                  "flipper_len" ),
                      selected = "body_mass")
        ),
        
        page1
      )
    ),
    nav_panel("Body Mass", page2),
    nav_panel("About",
      markdown("
        # About
        
        ### Data source
        [The R Datasets Package](https://www.r-project.org/)
        
        ### Data
        [Base R Penguins](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-04-15/readme.md)
      ")
    )
  )


# Define server logic required to draw a histogram
server <- function(input, output) {
  observe({
    sidebar_toggle(
      id = "sidebar",
      open = input$nav != "Home"
    )
  })
    output$plot1 <- renderPlot({
      y1_name <- switch (input$y1,
                        "body_mass" = "Body Mass (g)",
                        "bill_len" = "Bill Length (mm)",
                        "bill_dep" = "Bill Depth (mm)",
                        "flipper_len" = "Flipper length (mm)"
      )
      title_part <- switch (input$y1,
                            "body_mass" = "Body Mass",
                            "bill_len" = "Bill Length",
                            "bill_dep" = "Bill Depth",
                            "flipper_len" = "Flipper length"
      )
      ggplot(penguins, mapping = aes(fill = species, x = species,y = !!sym(input$y1), colour = species, shape = species)) + geom_bar(position = "dodge", stat ="identity") + facet_wrap(~island) + labs(title = paste0(title_part," and Penguin Species"),subtitle = "Categorized by Islands", x = "Species", y = y1_name)
    })
    
    output$plot2 <- renderPlot({
      ggplot(penguins, mapping = aes(x = body_mass, fill = species)) + geom_density(alpha = 0.5) + facet_wrap(~sex, dir="v") +
      labs(x = "Body mass (g)", y = "Density")
    })
    
    output$dataTable1 <- renderDataTable(
      penguins, options = list(pageLength = 5)
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
