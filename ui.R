library(shiny)
shinyUI(navbarPage("National Rifle Association Financial Contributions in Election Years \n(2000-2014)",
        tabPanel("Introduction",
                        sidebarPanel(
                                img(src = "everytown.jpeg")
                                ),
                        mainPanel(
                                p("The National Rifle Association (NRA) is an American nonprofit organization dedicated to protect the so-called Second Amendment - the right to keep and bear arms."),
                                p("It is opposed to any kind of gun regulation such as background checks - even though", 
                                  a("the majority of US citizens supports greater gun control.",
                                    href = "http://www.gallup.com/poll/1645/guns.aspx")),
                                p("The NRA exerts its influence not only through ads such as the most recent campaign against former New York mayor Michael Bloomberg, a billionaire and outspoken lobbyist for more gun control who invests millions of his personal fortune into gun control efforts."),
                                p("The NRA also contributes money to political campaign contributions."),
                                p("This app visualizes the NRA's financial contributions in election years 2000 through 2014. Some of the plots are interactive, allowing you to explore NRA spending by US state. Use the tabs to navigate."),
                                p("The data was compiled and published by",
                                  a("National Institute on Money in State Politics.",
                                    href = "http://www.followthemoney.org/")),
                                p(strong("To learn more about gun safety, go to", 
                                       a("everytown.org.", 
                                        href = "http://everytown.org/"))
                                ))
                 ),
        tabPanel("Overview",
                 sidebarLayout(
                         sidebarPanel(
                                 h3("The Basics", style = "color:skyblue"),
                                 p("Since 2000, the NRA has contributed $28,935,882,156 to political campaigns."), 
                                 p("The upper plot shows the organization's number of individual contributions across all US states between 2000 and 2014."), 
                                 p("The lower plot shows the organization's total contribution in millions US$ across all US states between 2000 and 2014.")
                                 ),
                         mainPanel(
                                 h3("Number of NRA contributions", style = "color:skyblue"),
                                 plotOutput("plot_total"),
                                 h3("Total NRA contributons in millions US$", style = "color:skyblue"),
                                 plotOutput("plot_total2")
                                 )
                         )
                 ),
        tabPanel("US$ by state",
                 sidebarLayout(
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
                                 h3("NRA contributions in millions US$", style = "color:skyblue"),
                                 plotOutput("plot_states")
                                 )
                         )
                 ),
        tabPanel("Contributions by state",
                 sidebarLayout(
                         sidebarPanel(
                                 h3("Instructions", style = "color:skyblue"),
                                 p("Choose any number of US states. The plot will automatically update. "),
                                 checkboxGroupInput("usState2",
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
                                 h3("Number of individual NRA contributions by state", style = "color:skyblue"),
                                 plotOutput("plot_contrib")
                                 )
                         )
                 ),
        tabPanel("Who gets the most?", 
                 sidebarLayout(
                         sidebarPanel(
                                 h3("Summary", style = "color:skyblue"),
                                 p("The upper plot shows the total number of individual contributions by state for the years 2000 through 2014."),
                                 p("Top 5: Florida, Texas, and Michigan."),
                                 br(),
                                 p("The lower plot shows the total contribution in millions US$ by state for the years 2000 through 2014."),
                                 p("Top 3 US: California, Florida, and Texas.")
                                 ),
                         mainPanel(
                                 h3("Total number of contributions by state", style = "color:skyblue"),
                                 plotOutput("plot_state1"),
                                 h3("Total contributions in US$ by state", style = "color:skyblue"),
                                 plotOutput("plot_state2")
                                 )
                         )
                 ),
        tabPanel("Code",
                 fluidRow(
                         column(12,
                                p("Get the code",
                                  a("here! :)",
                                    href = "https://github.com/B00H/DataProducts"))
                 )))
))