library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(
  htmlDiv(
    list(
      htmlLabel('Slider'),
      dccSlider(
        min = 1,
        max = 10,
        marks = list(
          "1" = "1°C",
          "5" = "5°C",
          "10" = "10°C"
        ),
        value = 5
      )
      
    )
  )
)