library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(ggplot2)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

app$layout(htmlDiv(list(
  dccTabs(id="tabs", children=list(
    dccTab(label='Tab one', children=list(
      htmlDiv(list(
        htmlLabel('Slider'),
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
          value=list(18, 75)
        ),
        htmlDiv(id='output-container-range-slider')
            )
          )
        )
    ),
    dccTab(label='Tab two', children=list(
      )
    ))
  ))
))

app$run_server(debug = T)