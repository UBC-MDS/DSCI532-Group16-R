# Reflection

For this milestone our group has successfully implemented our original proposed dashboard in R and added some minor improvements in response to suggestions.

### App Overview

We have a map visualization that displays the count of surveys in the dataset by each state in the US. This is an interactive map where you can click on a state or multiple states to filter the data in the other charts.

We have four other charts on two different tabs that bring to life two themes of questions that were asked in the survey. The two themes were:

-   **Employee perception** of mental health support and awareness at the company
-   **Employer support** in terms of resources and benefits offeredby the company

There are four different filtering options in the form of a drop down for state, a range slider for age, and two checkbox filters for gender and self-employed status.

The age, gender and self-employed filters are used as callbacks for the map. All four filters and the map interaction are used as callbacks for the charts.

### Experience Implementing in R

-   Some parts of implementing our app in R took getting used to, but once we figured it out it was pretty straightforward.

-   Some of the styling issues mentioned by Joel and peers were fixed automatically in R, these include:

        - Colour differentiation in map visualiztion for states with 0 or NA values.

        - Counts showing decimal points in the bar plots 

        - Lack of space between checkboxes and selection text 

        - Full screen alignment is now centered for the map and charts

-   Integration with Dash and R seemed more refined than that with Dash and Altair. We also found that the visualizations looked much better in the R implementation.

### App Strengths and Limitations

At this stage, we believe what our dashboard does well is the simplicity of the visualizations and the overall layout. At a glance users are able to understand what is being shown quite clearly.

If we had more time to further develop this dashboard, we would aim to implement the following improvements:

-   State filter - There were some challenges with null errors when implementing multiple selection filters for State. We tried it with many different approaches, but for some reason we would have sporadic null errors that would occur. Some additional work would also be nice to allow the state filter to work in unison with the map clicks and to update the state in the dropdown filter.

-   Infographics - To improve the utility of the dashboard it would be good to create a few more charts to bring out more of the details in the dataset which could be useful for an HR department to identify shortcomings that also exist within their company.
