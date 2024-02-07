#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(maps)
library(BiocManager)
options(repos = BiocManager::repositories())
library(rphylopic)
library(deeptime)


# Define UI for application that draws a histogram
ui <- fluidPage(
  fluidRow(
    column(2,
           numericInput("lat1", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon1", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
         textInput("class1", "Class")
  ),
  column(2,
         textInput("period1", "Period")
  )),
  fluidRow(
    column(2,
           numericInput("lat2", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon2", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class2", "Class")
    ),
    column(2,
           textInput("period2", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat3", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon3", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class3", "Class")
    ),
    column(2,
           textInput("period3", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat4", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon4", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class4", "Class")
    ),
    column(2,
           textInput("period4", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat5", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon5", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class5", "Class")
    ),
    column(2,
           textInput("period5", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat6", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon6", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class6", "Class")
    ),
    column(2,
           textInput("period6", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat7", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon7", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class7", "Class")
    ),
    column(2,
           textInput("period7", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat8", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon8", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class8", "Class")
    ),
    column(2,
           textInput("period8", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat9", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon9", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class9", "Class")
    ),
    column(2,
           textInput("period9", "Period")
    )),
  fluidRow(
    column(2,
           numericInput("lat10", "Latitude (°)", value = 55, min=50, max=59, step=0.001)
    ),
    column(2,
           numericInput("lon10", "Longitude (°)", value = 0, min=-10, max=3, step=0.001)
    ),
    column(2,
           textInput("class10", "Class")
    ),
    column(2,
           textInput("period10", "Period")
    )),
  fluidRow(
    downloadLink("downloadPlot", "Download Plot")
  ),
  mainPanel(
    plotOutput(outputId = "plot1", width = "100%")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


    
    
  my_plot <- reactive ({ worldmap = map_data('world')
    
    y1 <- input$lat1
    x1 <- input$lon1

    y2 <- input$lat2
    x2 <- input$lon2
    
    y3 <- input$lat3
    x3 <- input$lon3
    
    y4 <- input$lat4
    x4 <- input$lon4
    
    y5 <- input$lat5
    x5 <- input$lon5
    
    y6 <- input$lat6
    x6 <- input$lon6
    
    y7 <- input$lat7
    x7 <- input$lon7
    
    y8 <- input$lat8
    x8 <- input$lon8
    
    y9 <- input$lat9
    x9 <- input$lon9
    
    y10 <- input$lat10
    x10 <- input$lon10
    
    class1 <- input$class1
    class2 <- input$class2
    class3 <- input$class3
    class4 <- input$class4
    class5 <- input$class5
    class6 <- input$class6
    class7 <- input$class7
    class8 <- input$class8
    class9 <- input$class9
    class10 <- input$class10
    
    if(class1 == ""){
    }else{
      uuid1 <- get_uuid(name = class1, n = 1)
    }
    period1 <- input$period1
    if(period1 == ""){
     }else{
     col1 <- deeptime::periods$color[deeptime::periods$name == period1]
     }
    
    if(class2 == ""){
    }else{
      uuid2 <- get_uuid(name = class2, n = 1)
    }
    period2 <- input$period2
    if(period2 == ""){
    }else{
      col2 <- deeptime::periods$color[deeptime::periods$name == period2]
    }
    
    if(class3 == ""){
    }else{
      uuid3 <- get_uuid(name = class3, n = 1)
    }
    period3 <- input$period3
    if(period3 == ""){
    }else{
      col3 <- deeptime::periods$color[deeptime::periods$name == period3]
    }

    if(class4 == ""){
    }else{
      uuid4 <- get_uuid(name = class4, n = 1)
    }
    period4 <- input$period4
    if(period4 == ""){
    }else{
      col4 <- deeptime::periods$color[deeptime::periods$name == period4]
    }
    
    if(class5 == ""){
    }else{
      uuid5 <- get_uuid(name = class5, n = 1)
    }
    period5 <- input$period5
    if(period5 == ""){
    }else{
      col5 <- deeptime::periods$color[deeptime::periods$name == period5]
    }
    
    if(class6 == ""){
    }else{
      uuid6 <- get_uuid(name = class6, n = 1)
    }
    period6 <- input$period6
    if(period6 == ""){
    }else{
      col6 <- deeptime::periods$color[deeptime::periods$name == period6]
    }
    
    if(class7 == ""){
    }else{
      uuid7 <- get_uuid(name = class7, n = 1)
    }
    period7 <- input$period7
    if(period7 == ""){
    }else{
      col7 <- deeptime::periods$color[deeptime::periods$name == period7]
    }
    
    if(class8 == ""){
    }else{
      uuid8 <- get_uuid(name = class8, n = 1)
    }
    period8 <- input$period8
    if(period8 == ""){
    }else{
      col8 <- deeptime::periods$color[deeptime::periods$name == period8]
    }
    
    if(class9 == ""){
    }else{
      uuid9 <- get_uuid(name = class9, n = 1)
    }
    period9 <- input$period9
    if(period9 == ""){
    }else{
      col9 <- deeptime::periods$color[deeptime::periods$name == period9]
    }
    
    if(class10 == ""){
    }else{
      uuid10 <- get_uuid(name = class10, n = 1)
    }
    period10 <- input$period10
    if(period10 == ""){
    }else{
      col10 <- deeptime::periods$color[deeptime::periods$name == period10]
    }
    
    
    map <- ggplot() +
      geom_polygon(
        data = worldmap,
        aes(x = long, y = lat,
            group = group),
        fill = 'gray90',
        color = 'black'
      ) +
      coord_fixed(ratio = 1.3,
                  xlim = c(-10, 3),
                  ylim = c(50, 59)) +
      theme_void()
    
    if(class1 == ""){
    }else{
      if(period1 == ""){
        map <- map + 
          add_phylopic(uuid = uuid1, x = x1, y = y1, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid1, x = x1, y = y1, ysize = 0.8, fill = paste(col1))
      }}
    
    if(class2 == ""){
    }else{
      if(period2 == ""){
        map <- map + 
          add_phylopic(uuid = uuid2, x = x2, y = y2, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid2, x = x2, y = y2, ysize = 0.8, fill = paste(col2))
      }}
    
    if(class3 == ""){
    }else{
      if(period3 == ""){
        map <- map + 
          add_phylopic(uuid = uuid3, x = x3, y = y3, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid3, x = x3, y = y3, ysize = 0.8, fill = paste(col3))
      }}
    
    if(class4 == ""){
    }else{
      if(period4 == ""){
        map <- map + 
          add_phylopic(uuid = uuid4, x = x4, y = y4, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid4, x = x4, y = y4, ysize = 0.8, fill = paste(col4))
      }}
    
    if(class5 == ""){
    }else{
      if(period5 == ""){
        map <- map + 
          add_phylopic(uuid = uuid5, x = x5, y = y5, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid5, x = x5, y = y5, ysize = 0.8, fill = paste(col5))
      }}
    
    if(class6 == ""){
    }else{
      if(period6 == ""){
        map <- map + 
          add_phylopic(uuid = uuid6, x = x6, y = y6, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid6, x = x6, y = y6, ysize = 0.8, fill = paste(col6))
      }}
    
    if(class7 == ""){
    }else{
      if(period7 == ""){
        map <- map + 
          add_phylopic(uuid = uuid7, x = x7, y = y7, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid7, x = x7, y = y7, ysize = 0.8, fill = paste(col7))
      }}
    
    if(class8 == ""){
    }else{
      if(period8 == ""){
        map <- map + 
          add_phylopic(uuid = uuid8, x = x8, y = y8, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid8, x = x8, y = y8, ysize = 0.8, fill = paste(col8))
      }}
    
    if(class9 == ""){
    }else{
      if(period9 == ""){
        map <- map + 
          add_phylopic(uuid = uuid9, x = x9, y = y9, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid9, x = x9, y = y9, ysize = 0.8, fill = paste(col9))
      }}
    
    if(class10 == ""){
    }else{
      if(period10 == ""){
        map <- map + 
          add_phylopic(uuid = uuid10, x = x10, y = y10, ysize = 0.8)
        #
      }else{
        map <- map +
          add_phylopic(uuid = uuid10, x = x10, y = y10, ysize = 0.8, fill = paste(col10))
      }}
    
       map
  })
    output$plot1 <- renderPlot({
      my_plot()
    }, width = 800, height = 600) #res = 96))
  
  output$downloadPlot <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(my_plot())
      dev.off()
    }
  )
  

}

# Run the application 
shinyApp(ui = ui, server = server)
