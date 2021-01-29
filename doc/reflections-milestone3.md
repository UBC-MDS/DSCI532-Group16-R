# Reflection

For this milestone our group has successfully implemented a working skeleton of our proposed dashboard in R and added some minor improvements in response to suggestoins.

### App Overview

We have a map visualization that displays the count of mental health conditions by each state in the US. 

We have two other charts at the moment that bring to life two questions that were asked in the survey. There are four different filtering options in the form of a drop down for state, a range slider for age, and two checkbox filters for gender and self-employed status. 

All four filters are used as callbacks for the two charts and one map. The age, gender and self-employed filters are also used as callbacks for the map.

### Experience Implementing in R

-   Some parts of implementing our app in R took getting used to, but once we figured it out it was pretty straightforward.

-    Some of the styling issues mentioned by Joel and peers were fixed automatically in R, these include:

        - Counts showing decimal points in our bar plots 
  
        - Lack of space between checkboxes and selection text 
  
        - Full screen alignment is now centered for the map

### App Strengths and Limitations

At this stage, we believe what our dashboard does well is the simplicity of the visualizations and the overall layout. At a glance users are able to understand what is being shown quite clearly.


For future milestones, we aim to implement the following improvements to the dashboard:

-   Aesthetic changes to make the dashboard more visually pleasing, including improved layout and themes for the charts and filters.

-   Add content to the second tab if we find more useful visualizations to bring to life more anlaysis from the data, these would likely be comparison plots.

-   Update the map drop down to be a multi-selection dropdown.

-   Two way integration between map and some charts, ie when states are selected from the map, the chart use those selections as a filter.

-   Continue to align the rest of the plots properly 

-   Age slider - discuss and experiment with the styling of the range as the range from 18 - 75 is not very natural at first. 
