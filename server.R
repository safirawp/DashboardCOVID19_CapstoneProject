shinyServer(function(input, output) {
  
  ## ---- PLOT 1
  output$plot1 <- renderEcharts4r({
    covid19_world |> 
      e_charts(date) |> # initialise and set x
      e_line(total_cases, name = "Total Cases") |>  # add a line
      e_line(total_deaths, name = "Total Deaths") |>  # add a line
      e_x_axis(name = "Date") |>  # add x axis name
      e_title("COVID-19 Growth", "Cases and Death") |>  # Add title & subtitle
      e_theme("vintage") |>  # theme
      e_tooltip(trigger = "axis")  |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---- PLOT 2
  output$plot2 <- renderEcharts4r({
    
    covid19_country_plot <- covid19_country %>% 
      filter(location == input$input_country)
    
    covid19_country_plot |> 
      e_charts(date) |> # initialise and set x
      e_line(total_cases, name = "Total Cases") |>  # add a line
      e_line(total_deaths, name = "Total Deaths") |>  # add a line
      e_x_axis(name = "Date") |>  # add x axis name
      e_title("COVID-19 Growth", "Cases and Death") |>  # Add title & subtitle
      e_theme("vintage") |>  # theme
      e_tooltip(trigger = "axis")  |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---- PLOT 3
  output$plot3 <- renderEcharts4r({
    
    covid19_country_plot <- covid19_country %>% 
      filter(location == input$input_country)
    
    covid19_country_plot |> 
      e_charts(date) |> # initialise and set x
      e_area(people_vaccinated, name = "At least one dose", smooth = TRUE) |>  # add a area
      e_area(people_fully_vaccinated, name = "Fully Vaccinated", smooth = TRUE) |>  # add a area
      e_area(total_boosters, name = "Booster Given", smooth = TRUE) |>  # add a area
      e_x_axis(name = "Date") |>  # add x axis name
      e_title("Vaccination Status") |>  # Add title & subtitle
      e_theme("vintage") |>  # theme
      e_tooltip(trigger = "axis") |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  ## ---- PLOT 4
  output$plot4 <- renderEcharts4r({
    
    
    country_cases_plot <- country_cases %>%
      top_n(input$input_slider) %>% 
      arrange(switch(input$input_button,
                     asc = -total_cases,
                     desc = total_cases,
      ))
    
    country_cases_plot |> 
      e_charts(location) |> 
      e_bar(total_cases, name = "Total Cases") |>
      e_y_axis(name = "Total Cases") |> 
      e_flip_coords() |>
      e_title("Cases of COVID-19", "Top Country") |>
      e_grid(containLabel = T) |>
      e_theme("vintage") |>
      e_tooltip(trigger = "axis")  |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---- PLOT 5
  output$plot5 <- renderEcharts4r({
    
    country_deaths_plot <- country_deaths %>% 
      top_n(input$input_slider) %>% 
      arrange(switch(input$input_button,
                     asc = -total_deaths,
                     desc = total_deaths,
      ))
    
    country_deaths_plot |> 
      e_charts(location) |> 
      e_bar(total_deaths, name = "Total Deaths") |>
      e_y_axis(name = "Total Deaths") |> 
      e_flip_coords() |>
      e_title("Deaths from COVID-19", "Top Country") |>
      e_grid(containLabel = T) |>
      e_theme("vintage") |>
      e_tooltip(trigger = "axis")  |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---- PLOT 6
  output$plot6 <- renderEcharts4r({
    
    country_casespop_plot <- country_casespop %>% 
      top_n(input$input_slider) %>% 
      arrange(switch(input$input_button,
                     asc = -covid_per_population,
                     desc = covid_per_population,
      ))
    
    country_casespop_plot |> 
      e_charts(location) |> 
      e_bar(covid_per_population, name = "Covid-19 Cases Per Population") |>
      e_y_axis(name = "%") |> 
      e_flip_coords() |>
      e_title("Covid-19 Cases Per Population", "Top Country") |>
      e_grid(containLabel = T) |>
      e_theme("vintage") |>
      e_tooltip(trigger = "axis")  |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---- PLOT 7
  output$plot7 <- renderEcharts4r({
    covid19_world |> 
      e_charts(date) |> # initialise and set x
      e_area(people_vaccinated, name = "At least one dose", smooth = TRUE) |>  # add a area
      e_area(people_fully_vaccinated, name = "Fully Vaccinated", smooth = TRUE) |>  # add a area
      e_area(total_boosters, name = "Booster Given", smooth = TRUE) |>  # add a area
      e_x_axis(name = "Date") |>  # add x axis name
      e_title("Vaccination Status") |>  # Add title & subtitle
      e_theme("vintage") |>  # theme
      e_tooltip(trigger = "axis") |>
      e_toolbox_feature(
        feature = "saveAsImage",
        title = "Save as image"
      )
  })
  
  
  ## ---DATASET
  output$dataset_table <- DT::renderDataTable(covid19,
                                              options = list(scrollX=T,
                                                             scrollY=T))
  
})
