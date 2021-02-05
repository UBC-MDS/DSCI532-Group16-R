library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(tidyverse)
library(plotly)
library(ggthemes)


app <- Dash$new( external_stylesheets = 'https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css')


data = read_csv('data/processed/processed_survey.csv')
statedf <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv")

dropdown_states <- unique(data[c("state_fullname", "state")]) %>%
    arrange(state_fullname)

ls_state <- list(list(label='All',value='ALL'))
for (row in 1:nrow(dropdown_states)) {
   fn <- dropdown_states[row, 'state_fullname'] %>% pull(1)
   abbrev <- dropdown_states[row, 'state'] %>% pull(1)
   ls_state <- append(ls_state, list(list(label=fn, value=abbrev)))   
}
dropdown_state_ls <- ls_state

SIDEBAR_STYLE <- list(
    'position'="fixed",
    'top'=0,
    'left'=0,
    'bottom'=0,
    'width'="18rem",
    'padding'="2rem 1rem",
    'background-color'="#f8f9fa"
)

sidebar <- htmlDiv(list(
        htmlBr(),
        htmlH3("Filters", className="display-5"),
        htmlHr(),
        htmlH4(htmlLabel('State Selection')), 
        dccDropdown(
            id = 'state_selector',
            options=dropdown_state_ls, #{'label': state_full, 'value': state_abbrev} for state_full, state_abbrev in list(zip(df_states.state_fullname, df_states.state))],
            value='ALL', 
            multi=FALSE,
            clearable=FALSE,
            style=list('height'= '30px', 'width'= '250px')
            ),        
        htmlBr(),       
        
        #Age Filter
        htmlH4(htmlLabel('Age')),
        dccRangeSlider(
          id='age-range-slider',
          min=15,
          max=75,
          step=2,
          marks=list(
            "15" = "15",
            "25" = "25",
            "35" = "35",
            "45" = "45",
            "55" = "55",
            "65" = "65",
            "75" = "75"
          ),
          value=list(15, 75)),
          htmlBr(),
        
          # Gender Filter Checklist
          htmlH4(htmlLabel('Gender')),
          dccChecklist(
              id = 'gender_checklist',
              options = list(
                  list('label'=' Male', 'value' ='Male'),
                  list('label' = ' Female',  'value' = 'Female'),
                  list('label' = ' Other', 'value' = 'Other')),
              value = list('Male', 'Female', 'Other'),
              labelStyle = list('display'='block')
          ),
          htmlBr(),
        
          # Self-Employed Filter Checklist
          htmlH4(htmlLabel('Self-Employed')),
          dccChecklist(
              id = 'self_emp_checklist',
              options = list(
                  list('label' = ' Yes', 'value' = 'Yes'),
                  list('label' = ' No', 'value' = 'No')),
              value = list('Yes', 'No'),            
              labelStyle = list('display'='block')
              
          ),          
          
         
      htmlDiv(id='output-container-range-slider')
    ), 
    style=SIDEBAR_STYLE
  )

CONTENT_STYLE <- list(
    'margin-left'="18rem",
    'margin-right'="2rem",
    'padding'="2rem 1rem"    
)

content <- htmlDiv(list(
  htmlH2('Employee Mental Health Survey in the US'),
  htmlBr(),
  # Map figure
  dccGraph(id='map-plot'),  
  dbcTabs(id="tabs", children=list(
    dbcTab(label='Employee perception', children=list(
      
      # Options Bar Plot
      dccGraph(id = 'option_bar_plot', style=list('height'=250, 'width'= 900, 'margin' = 100)),

      # Discuss mental issues Bar Plot
      dccGraph(id = 'discuss_w_supervisor', style=list('height'=250, 'width'= 900, 'margin' = 100))
        )     
    ),
    dbcTab(label='Employer support', children=list(           
      htmlBr(),
      # Facet Dropdown button
      htmlH3('View survey results by:'),
      dccDropdown(
        id = 'facet_selector',
        options=list(
          list(label = 'Age', value = 'age_group'),
          list(label = 'Gender', value = 'Gender'),
          list(label = 'Self-Employed', value = 'self_employed')
        ),
        value='age_group', 
        multi=FALSE,
        clearable=FALSE,
        style=list('height'= '30px', 'width'= '250px')),
      
      #Facet Plots
      dccGraph(id = 'facet_barplot_1', style=list('height'=250, 'width'= 900, 'margin' = 100)),
      dccGraph(id = 'facet_barplot_2', style=list('height'=250, 'width'= 900, 'margin' = 100))
      
      )
    ))
  )),
  style=CONTENT_STYLE
)

#Main Layout
app$layout(
    
    htmlDiv(
    
      list(
      #side bar div
      sidebar,
      #content div
      content
      ) 
  ))


#Map callback
app$callback(
  output('map-plot', 'figure'),
  list(input('age-range-slider', 'value'),
       input('gender_checklist', 'value'),
       input('self_emp_checklist', 'value'),
       input('state_selector', 'value')),
  function(age_chosen, gender_chosen, self_emp_chosen, state_chosen) {
    
    # Filter data
    filtered_data <- data %>% filter(Age >= age_chosen[1] & Age <= age_chosen[2] & 
                                       Gender %in% gender_chosen &
                                       self_employed %in% self_emp_chosen &
                                       (  state_chosen == 'ALL' | state %in% state_chosen))
    
    # Create frequencydf
    colnames(filtered_data)[6] <- "code"
    grouped_data <- filtered_data %>%
      group_by(code) %>%
      summarize(mental_health_condition = n())
    frequencydf <- left_join(statedf, grouped_data, by = 'code')

    # Plot map
    p <- plot_ly(frequencydf, type = 'choropleth', locationmode = 'USA-states', 
                 z = ~mental_health_condition, locations = ~code, color = ~mental_health_condition, colors = 'PuBu') %>%                 
                layout( geo = list(scope = 'usa', projection = list(type = 'albers usa')),                                   
                  title = paste(str(state_chosen),'Survey Participation by State'), 
                clickmode = 'event+select')
    p <- p %>% colorbar(title = "Survey Count")  
      
    
        
    ggplotly(p)
  }
)

#Options Barplot Callback
app$callback(
  output('option_bar_plot', 'figure'),
  list(input('age-range-slider', 'value'),       
       input('gender_checklist', 'value'),
       input('self_emp_checklist', 'value'),
       input('state_selector', 'value'),
       input('map-plot', 'selectedData')),
  function(age_chosen, gender_chosen, self_emp_chosen, state_chosen, selected_data) {
    
    map_clicks <- selected_data[[1]] %>% purrr:::map_chr('location')
    
    p <- ggplot(data %>% filter(Age >= age_chosen[1] & Age <= age_chosen[2] & 
                                  Gender %in% gender_chosen &
                                  self_employed %in% self_emp_chosen &
                                  ((state_chosen == 'ALL' | state %in% state_chosen) & 
                                     ( length(map_clicks) == 0 | state %in% map_clicks)))) +
      aes(y = benefits) +
      geom_bar(fill = '#3E60A4AA') +
      labs(x = 'Count of Records', y = '', title = 'Do you know the options for mental healthcare your employer provides?')
    ggplotly(p, tooltip = 'count')
  }
)

#Discuss w supervisor Callback
app$callback(
  output('discuss_w_supervisor', 'figure'),
  list(input('age-range-slider', 'value'),       
       input('gender_checklist', 'value'),
       input('self_emp_checklist', 'value'),
       input('state_selector', 'value'),
       input('map-plot', 'selectedData')),
  function(age_chosen, gender_chosen, self_emp_chosen, state_chosen, selected_data) {
    
    map_clicks <- selected_data[[1]] %>% purrr:::map_chr('location')
    
    p <- ggplot(data %>% filter(Age >= age_chosen[1] & Age <= age_chosen[2] &
                             Gender %in% gender_chosen &
                             self_employed %in% self_emp_chosen  &
                               ((state_chosen == 'ALL' | state %in% state_chosen) & 
                                  ( length(map_clicks) == 0 | state %in% map_clicks)))) +
      aes(x = supervisor, y = Age) +
      geom_boxplot(color = '#2166AC', fill = '#3E60A4AA') +
      coord_flip() +
      labs(x = "", title = "Would employee be willing to discuss mental health issues with supervisor?") 
    
    ggplotly(p)
  }
)

##### Second Tab Callbacks
# Facetted Barplot 1
app$callback(
  output('facet_barplot_1', 'figure'),
  list(input('age-range-slider', 'value'),       
       input('gender_checklist', 'value'),
       input('self_emp_checklist', 'value'),
       input('state_selector', 'value'),
       input('facet_selector', 'value'),
       input('map-plot', 'selectedData')
       ),
  function(age_chosen, gender_chosen, self_emp_chosen, state_chosen, facet_chosen, selected_data) {
    
    map_clicks <- selected_data[[1]] %>% purrr:::map_chr('location')
    
    p <- ggplot(data %>% filter(Age >= age_chosen[1] & Age <= age_chosen[2] & 
                                  Gender %in% gender_chosen &
                                  self_employed %in% self_emp_chosen &
                                  ((state_chosen == 'ALL' | state %in% state_chosen) & 
                                     ( length(map_clicks) == 0 | state %in% map_clicks)))) +
      aes_string(y = 'wellness_program', fill = facet_chosen) + 
      geom_bar() + 
      facet_wrap(as.formula(paste('~', facet_chosen)), ncol = 4) + 
      labs(x = 'Count of Records', y = '', title = 'Has your employer ever discussed mental health as part of an employee wellness program?') + 
      theme(legend.position = 'none') +
      scale_fill_brewer(palette = "Accent")
    
    #Resolve the x axis overlapping facet tick issue - Remove if Count of Records is not necessary in this plot
    gp <- ggplotly(p, tooltip = 'count')
    gp[['x']][['layout']][['annotations']][[1]][['y']] <- -0.15
    gp
  }
)

#Facetted Barplot 2
app$callback(
  output('facet_barplot_2', 'figure'),
  list(input('age-range-slider', 'value'),       
       input('gender_checklist', 'value'),
       input('self_emp_checklist', 'value'),
       input('state_selector', 'value'),
       input('facet_selector', 'value'),
       input('map-plot', 'selectedData')
  ),
  function(age_chosen, gender_chosen, self_emp_chosen, state_chosen, facet_chosen, selected_data) {
    
    map_clicks <- selected_data[[1]] %>% purrr:::map_chr('location')
    
    p <- ggplot(data %>% filter(Age >= age_chosen[1] & Age <= age_chosen[2] & 
                                  Gender %in% gender_chosen &
                                  self_employed %in% self_emp_chosen &
                                  ((state_chosen == 'ALL' | state %in% state_chosen) 
                                   & ( length(map_clicks) == 0 | state %in% map_clicks)))) +
      aes_string(y = 'seek_help', fill = facet_chosen) + 
      geom_bar() + 
      facet_wrap(as.formula(paste('~', facet_chosen)), ncol = 4) + 
      labs(x = 'Count of Records', y = '', title = 'Does employer provide resources to learn about mental health issues & how to seek help?') + 
      theme(legend.position = 'none') +
      scale_fill_brewer(palette = "Accent") 
    
    #Resolve the x axis overlapping facet tick issue
    gp <- ggplotly(p, tooltip = 'count')
    gp[['x']][['layout']][['annotations']][[1]][['y']] <- -0.15
    gp
  }
)

app$run_server(debug = T, host='0.0.0.0')
