
dashboardPage(
  
  skin = "red",
  
  # --------- HEADER
  dashboardHeader(
    
    title = "COVID-19 Dashboard"
    
  ),
  
  
  # --------- SIDEBAR
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("Global", tabName = "global", icon = icon("globe")),
      menuItem("Country", tabName = "country", icon = icon("compass")),
      menuItem("Ranking", tabName = "ranking", icon = icon("bar-chart")),
      menuItem("Dataset", tabName = "data", icon = icon("server"))
    )
    
  ),
  
  # --------- BODY
  dashboardBody(
    
    tabItems(
      
      # -----PAGE 1: GLOBAL
      tabItem(tabName = "global",
              ## --- ROW 1
              fluidRow(
                infoBox(width = 3,
                        color = "red",
                        title = "Total Cases",
                        icon = icon("virus"),
                        value = comma(total_cases_updated[1,1])),
                infoBox(width = 3,
                        color = "red",
                        title = "New Cases",
                        icon = icon("angle-double-up"),
                        value = comma(new_cases_updated[1,1])),
                infoBox(width = 3,
                        color = "black",
                        title = "Total Deaths",
                        icon = icon("users"),
                        value = comma(total_deaths_update[1,1])),
                infoBox(width = 3,
                        color = "black",
                        title = "New Deaths",
                        icon = icon("angle-double-up"),
                        value = comma(new_deaths_update[1,1]))),
              
              ## --- ROW 2
              fluidRow(
                box(width = 12,
                    height = 425,
                    echarts4rOutput("plot1"))
              ),
              
              ## --- ROW 3
              fluidRow(
                box(width = 12,
                    height = 425,
                    echarts4rOutput("plot7"))
              )
              
      ),
      
      # -----PAGE 2: COUNTRY
      tabItem(tabName = "country",
              
              ## --- ROW 1: input
              fluidRow(
                box(width = 12,
                    selectInput(
                      inputId = "input_country",
                      label = "Choose Country",
                      choices = unique(covid19_country$location),
                      selected = "Indonesia"
                    ))),
              
              ## --- ROW 2: Plot
              fluidRow(
                # --- PLOT 2
                box(width = 12,
                    height = 425,
                    echarts4rOutput("plot2")),
              ),
              
              ## --- ROW 3: Plot
              fluidRow(
                # --- PLOT 3
                box(width = 12,
                    height = 425,
                    echarts4rOutput("plot3")),
              )
      ),
      
      # -----PAGE 3: Ranking
      tabItem(tabName = "ranking",
              
              ## --- ROW 1: input
              fluidRow(
                box(width = 6,
                    height = 125,
                    sliderInput(
                      inputId = "input_slider",
                      label = "Choose Top Number",
                      min = 1,
                      max = 20,
                      value = 10,
                    )),
                box(width = 6,
                    height = 125,
                    radioButtons(
                      inputId = "input_button",
                      label = "Choose Sorting",
                      choices = c(
                        "Ascending" = "asc",
                        "Descending" = "desc"
                      ),
                      selected = "desc"
                    )),
              ),
              
              ## --- ROW 2: Panel Tab, Plot 
              fluidRow(
                tabBox(width = 12,
                       title = tags$b("Country Comparison"),
                       id = "tabset1",
                       side = "left",
                       tabPanel(tags$b("Cases"), 
                                echarts4rOutput("plot4")
                       ),
                       tabPanel(tags$b("Deaths"), 
                                echarts4rOutput("plot5")
                       ),
                       tabPanel(tags$b("Cases Per Population"), 
                                echarts4rOutput("plot6")
                       )
                )
                
              )
      ),
      
      
      # -----PAGE 4: DATASET
      tabItem(tabName = "data",
              fluidRow(
                box(
                  width = 12,
                  title = "COVID-19 Dataset",
                  DT::dataTableOutput(outputId = "dataset_table")
                )
              ),
              fluidRow(
                box(width = 12,
                    h3("Data Source"),
                    div(style = "text-align:justify",
                        p("COVID-19 dataset is a collection of the COVID-19 data maintained by", 
                          a(href = "https://ourworldindata.org/coronavirus",
                            "Our World in Data"),
                          br(),
                          "In this dashboard, data are available from January 2020 to April 2022.",
                          
                        )
                    )
                )
                
              )
              
      )
      
    )
    
  )
  
)
