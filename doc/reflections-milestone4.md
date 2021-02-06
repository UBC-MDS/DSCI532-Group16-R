# Reflection

For this milestone our group has successfully implemented our original proposed dashboard in R and added some minor improvements in response to suggestions.

### App Overview

We have a map visualization that displays the count of surveys in the dataset by each state in the US. This is an interactive map where you can click on a state or multiple states to filter the data in the other charts.

We have four other charts on two different tabs that bring to life two themes of questions that were asked in the survey. The two themes were:

-   **Employee perception** of mental health support and awareness at the company
-   **Employer support** in terms of resources and benefits offeredby the company

There are four different filtering options in the form of a drop down for state, a range slider for age, and two checkbox filters for gender and self-employed status.

The age, gender and self-employed filters are used as callbacks for the map. All four filters and the map interaction are used as callbacks for the charts. In addition, there is a drop-down option which allows a different facetted view of the plots on our Employer support tab.

### Experience Implementing in R

Integration with Dash and R seemed more refined than that with Dash and Altair. We also found that the visualizations looked much better in the R implementation which is why we decided to proceed using R for our final version of the app rather than Python. 

### Thoughts on Feedback

Most of the feedback receieved from instructors and peers focused on the finer styling issues. Some of this was fixed earlier, as noted in our Milestone 3 reflection, automatically through implementation in R. Some feedback about the earlier versions of our app include:

  - Age slider values not evenly spaced out
  - Unclear legend titles
  - Second tab of the app being empty
        
Overall feedback on the app was positive as it was functional and easy to use. The feedback was very constructive and we addressed the issues in our app for this final milestone. 

### Milestone 4 App Updates

Some of the notable updates to our app in this milestone include:

   - Added visualizations and dropdown to the previously empty Employer support tab
   - Moved our map visualization outside of the tabs so that it can serve as a filter for both tabs
   - Fixed minor styling issues (legend names, slider value space etc.)

### App Strengths and Limitations

For this final milestone, our app is what we envisioned in Milestone 1. From the stylistic layout to the functions of the filters to the plots generated, the initial features we had planned have been implemented.

However, some small improvements could still be made. If we had more time to further develop this dashboard, we would aim to implement the following improvements:

-   State filter - There were some challenges with null errors when implementing multiple selection filters for State. We tried it with many different approaches, but for some reason we would have sporadic null errors that would occur. Some additional work would also be nice to allow the state filter to work in unison with the map clicks and to update the state in the dropdown filter.

-   Infographics - To improve the utility of the dashboard it would be good to create a few more charts to bring out more of the details in the dataset which could be useful for an HR department to identify shortcomings that also exist within their company.
