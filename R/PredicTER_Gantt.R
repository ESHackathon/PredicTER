library(shiny)
library(tidyverse)

data<-PredicTER_times_output_1_

ui <- fluidPage(
  titlePanel("PredicTER_Gantt"),
  sidebarLayout(
    sidebarPanel(
      numericInput("totalInput", "Total days available", value = round(sum(data$time_days)), min = 0),
      sliderInput("administration", "Administration", min = 0, max = 100, value = data$time_days[1]),
      sliderInput("planning", "Planning time", min = 0, max = 100, value = data$time_days[2]),
      sliderInput("protocol", "Protocol development", min = 0, max = 100, value = data$time_days[3]),
      sliderInput("academicS", "Searching (academic)", min = 0, max = 100, value = data$time_days[4]),
      sliderInput("greyS", "Searching (grey)", min = 0, max = 100, value = data$time_days[5]),
      sliderInput("biblio", "Checking bibliographies", min = 0, max = 100, value = data$time_days[6]),
      sliderInput("duplicates","Removing duplicates", min=0, max=100, value=data$time_days[7]),
      sliderInput("title", "Title screening", min = 0, max=100, value=data$time_days[8]),
      sliderInput("abstract","Abstract screening", min=0, max=100, value=data$time_days[9]),
      sliderInput("full_ret", "Full text retrieval",min=0, max=100, value=data$time_days[10]),
      sliderInput("full", "Full text screening" , min=0, max=100, value=data$time_days[11]),
      sliderInput("meta", "Meta-data extraction" , min=0, max=100, value=data$time_days[12]),
      sliderInput("critical", "Critical appraisal", min=0, max=100, value=data$time_days[13]),
      sliderInput("data_ex","Data extraction", min=0, max=100, value=data$time_days[14]),
      sliderInput("data", "Data preparation", min=0, max=100, value=data$time_days[15]),
      sliderInput("synthesis", "Synthesis", min=0, max=100, value=data$time_days[16]),
      sliderInput("report", "Report writing", min=0, max=100, value=data$time_days[17]),
      sliderInput("comms", "Communication", min=0, max=100, value=data$time_days[18]),
      sliderInput("meet", "Meetings", min=0, max=100, value=data$time_days[19])),
    mainPanel(
      plotOutput("plot")
    ))
  )

server <- function(input, output, session) {
  observe({
    total_value <- sum(input$administration, input$planning, input$protocol, input$academicS, input$greyS, input$biblio,input$duplicates, input$title, input$abstract, input$full_ret, input$full, input$meta, input$critical,input$data_ex, input$data, input$synthesis, input$report,input$comms,input$meet)

    # Adjust other sliders if the total exceeds input value
    if (total_value != input$totalInput) {
      ratio <- input$totalInput / total_value
      updateSliderInput(session, "administration", value = input$administration * ratio)
      updateSliderInput(session, "planning", value = input$planning * ratio)
      updateSliderInput(session, "protocol", value= input$protocol*ratio)
      updateSliderInput(session, "academicS", value = input$academicS * ratio)
      updateSliderInput(session, "greyS", value = input$greyS * ratio)
      updateSliderInput(session, "biblio", value = input$biblio * ratio)
      updateSliderInput(session, "duplicates", value=
      input$duplicates*ratio)
      updateSliderInput(session, "title",value= input$title*ratio)
      updateSliderInput(session, "abstract", value= input$abstract*ratio)
      updateSliderInput(session, "full_ret", value= input$full_ret*ratio)
      updateSliderInput(session, "full", value=input$full*ratio)
      updateSliderInput(session, "meta", value=input$meta*ratio)
      updateSliderInput(session, "critical", value=input$critical*ratio)
      updateSliderInput(session, "data_ex", value=input$data*ratio)
      updateSliderInput(session, "data", value=input$data*ratio)
      updateSliderInput(session, "synthesis", value=input$synthesis*ratio)

      updateSliderInput(session, "report", value=input$report*ratio)
      updateSliderInput(session, "comms", value=input$comms*ratio)
      updateSliderInput(session, "meet", value=input$meet*ratio)
      }
  })

  output$plot <- renderPlot({
    # Create ggplot based on slider values
    values <- c(input$administration, input$planning,input$protocol, input$academicS, input$greyS, input$biblio,input$duplicates, input$title, input$abstract, input$full_ret, input$full, input$meta, input$critical,input$data_ex, input$data, input$synthesis, input$report,
                input$comms,input$meet)
    labels <- c("Administration", "Planning", "Protocol development", "Academic Searching", "Grey-lit searching", "Checking bibliographies","Removing duplicates","Title screening", "Abstract screening","Full text retrieval","Full text screening","Meta-data extraction","Critical appraisal", "Data extraction","Data preparation","Synthesis","Report writing","Communication","Meetings")
    data <- data.frame(values, labels)

    ggplot(data, aes(x = labels, y = values)) +
      geom_bar(stat = "identity") +
      labs(title = "", y = "Days", x = "Stage")+
      coord_flip()+
      ggthemes::theme_base()
  })
}

shinyApp(ui, server)
