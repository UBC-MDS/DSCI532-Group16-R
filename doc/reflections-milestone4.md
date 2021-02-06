In this section, your group should document on what you have implemented in your dashboard so far and explain what is not yet implemented. It is important that you include what you know is not working in your dashboard, so that your TAs can distinguish between features in development and bugs. Since this is the last milestone, you really need to motivate well why you have not chosen to include some feature that you were planning on including previously.

This week it is suitable to include thoughts on the feedback you received from your peer and/or TA, e.g.

Has it been easy to use your app?
Are there reoccurring themes in your feedback on what is good and what can be improved?
Is there any feedback (or other insight) that you have found particularly valuable during your dashboard development?
This section should be around 300-500 words and the reflection-milestone4.md document should live in your GitHub.com repo in the doc folder.

---

# Reflection

For this milestone our group has successfully implemented our original proposed dashboard in R and added some minor improvements in response to suggestions.

### App Overview

We have a map visualization that displays the count of mental health conditions by each state in the US. This is an interactive map where you can click on a given state to further filter down the data in the other charts.

We have four other charts on two different tabs that bring to life two themes of questions that were asked in the survey. The two themes were:

- Employee perception
- Employee support

There are four different filtering options in the form of a drop down for state, a range slider for age, and two checkbox filters for gender and self-employed status. 

All four filters are used as callbacks for the two charts and one map. The age, gender and self-employed filters are also used as callbacks for the map.

### Experience Implementing in R

-   Some parts of implementing our app in R took getting used to, but once we figured it out it was pretty straightforward.

-   Some of the styling issues mentioned by Joel and peers were fixed automatically in R, these include:

        - Colour differentiation in map visualiztion for states with 0 or NA values.

        - Counts showing decimal points in the bar plots 
  
        - Lack of space between checkboxes and selection text 
  
        - Full screen alignment is now centered for the map and charts

-   Integration with Dash and R seemed more refined than that with Dash and Altair.

### App Strengths and Limitations

At this stage, we believe what our dashboard does well is the simplicity of the visualizations and the overall layout. At a glance users are able to understand what is being shown quite clearly.


If we had more time to futher develop this dashboard, we would aim to implement the following improvements:

-   There were some challenges with null errors when implementing multiple selection filters for State.  We tried it with many different approaches, but for some reason we would have sporadic null errors that would occur.  Some additional work would also be nice to allow the state filters in the map to update the state filters in the dropdown.

-   Fine tuning some alignment

-   Adding a html title to the dashboard. This was easy to do in Python / Dash, but we tried many different approaches and couldn't find how to set the HTML title of the page.


