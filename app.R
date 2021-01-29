library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(tidyverse)
app <- Dash$new(external_stylesheets = 'https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css')


data = read_csv('data/processed/processed_survey.csv')

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
            options=list(), #{'label': state_full, 'value': state_abbrev} for state_full, state_abbrev in list(zip(df_states.state_fullname, df_states.state))],
            value='AL', 
            multi=FALSE,
            style=list('height'= '30px', 'width'= '250px')
            ),        
        htmlBr(),       
        htmlH4(htmlLabel('Age')),
        dccRangeSlider(
          id='age-range-slider',
          min=18,
          max=75,
          step=2,
          marks=list(
            "18" = "18",
            "20" = "20",
            "30" = "30",
            "40" = "40",
            "50" = "50",
            "60" = "60",
            "70" = "70",
            "75" = "75"
          ),
          value=list(18, 75)),
          htmlBr(),
          # Gender Filter Checklist
          htmlH4(htmlLabel('Gender')),
          dccChecklist(
              id = 'gender_checklist',
              options = list(
                  list('label'='Male', 'value' ='Male'),
                  list('label' = 'Female  ',  'value' = 'Female'),
                  list('label' = 'Other  ', 'value' = 'Other')),
              value = list('Male', 'Female', 'Other'),
              labelStyle = list('display'='block')
          ),
          htmlBr(),
          # Self-Employed Filter Checklist
          htmlH4(htmlLabel('Self-Employed')),
          dccChecklist(
              id = 'self_emp_checklist',
              options = list(
                  list('label' = 'Yes  ', 'value' = 'Yes'),
                  list('label' = 'No  ', 'value' = 'No'),
                  list('label' = 'N/A  ', 'value' = 'N/A')),
              value = list('Yes', 'No', 'N/A'),            
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
  dccTabs(id="tabs", children=list(
    dccTab(label='Tab one', children=list(

      htmlLabel('hello')

        )
    ),
    dccTab(label='Tab two', children=list(
      )
    ))
  )),
  style=CONTENT_STYLE
)

#Main Layout
app$layout(htmlDiv(
    
    list(
    #side bar div
    sidebar,
    #content div
    content
    )
 
))


app$run_server(debug = T, host='0.0.0.0')
