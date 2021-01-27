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
        dccSlider(
          min = 1,
          max = 10,
          marks = list(
            "1" = "1°C",
            "5" = "5°C",
            "10" = "10°C"
          ),
          value = 5)
            )
          )
        )
    ),
    dccTab(label='Tab two', children=list(
      )
    ))
  ))
))