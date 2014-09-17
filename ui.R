library(shiny)
states <- as.data.frame(levels(nraFinal$election_state))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        titlePanel("National Rifle Association donations (2000-2014)"),
        sidebarLayout(position = "right",
                sidebarPanel(
                        h3("Instructions", style = "color:skyblue"),
                        p("Choose any number of US states. The plot will automatically update. "),
                        checkboxGroupInput("usState",
                                           label = h4("US state", style = "color:skyblue"),
                                           choices = c(
                                                   "Alabama"="AL", "Alaska"= "AK", "Arizona"="AZ", "Arkansas"="AR", "California"="CA",
                                                   "Colorado"="CO", "Connecticut"="CT", "Delware"="DE", "DC"="DC",  "Florida"="FL", 
                                                   "Georgia"="GA", "Hawaii"="HI", "Idaho"="ID", "Illinois"="IL", "Indiana"="IN", 
                                                   "Iowa"="IA", "Kansas"="KS", "Kentucky"="KY", "Louisiana"="LA", "Massachusetts"="MA",
                                                   "Maryland"="MD", "Maine"="ME", "Michigan"="MI", "Minnesota"="MN", "Mississippi"="MS",
                                                   "Missouri"="MO", "Montana"="MT", "Nebraska"="NE", "Nevada"="NV", "New Hampshire"="NH",
                                                   "New Jersey"="NJ", "New Mexico"="NM", "New York"="NY", "North Carolina"="NC", "North Dakota"="ND",
                                                   "Ohio"="OH", "Oklahoma"="OK", "Oregon"="OR", "Pennsylvania"="PA", "Rhode Island"="RI",
                                                   "South Carolina"="SC", "South Dakota"="SD", "Tennessee"="TN", "Texas"="TX", "Utah"="UT",
                                                   "Vermont"="VT", "Virginia"="VA", "Washington"="WA", "West Virginia"="WV", "Wisconsin"="WI",
                                                   "Wyoming"="WY"),
                                           select = "CA"
                                           )
                        ),
                mainPanel(
                        h3("Introduction", style = "color:skyblue"),
                        p("The National Rifle Association (NRA) is an American nonprofit organization dedicated to protect the Constitution of the United States, in particular the right to keep and bear arms (the co-called Second Amendment)."),
                        p("It is opposed to any kind of gun regulation such as background checks - even though", 
                                a("the majority of US citizens supports greater gun control.",
                                  href = "http://www.gallup.com/poll/1645/guns.aspx")),
                        p("The NRA exerts its influence not only through ads, but also political campaign contributions."),
                        p("Below, the NRA's financial contributions in election years 2000 through 2014 is visualized by state. The data was compiled and published by",
                          a("National Institute on Money in State Politics",
                            href = "http://www.followthemoney.org/")),
                        p("Instructions on how to use the app can be found on the side panel, and more detailed documentation can be found ",
                          a("here.",
                            href = "DOESNOTWORKYET")),
                        br(),
                        h3("NRA contributions in millions US$ between 2000 and 2014", style = "color:skyblue"),
                        plotOutput("plot_states")
                )
        )
))