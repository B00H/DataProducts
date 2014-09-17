library(shiny)
library(reshape)
library(tidyr)
library(dplyr)
library(ggplot2)
shinyServer(
        function(input, output) {
                output$plot_states <- renderPlot({
                        ## National Rifle Association donations between 2000 and 2014 by state. 
                        nra_raw <- read.delim("./FollowTheMoneyDownload20140911(030911).txt", 
                                              stringsAsFactors=FALSE, colClasses = c("character"))
                        
                        ## Remove duplicate columns. 
                        nra_less <- nra_raw[, -c(1,2, 3, 5, 6)]
                        
                        ## Rename variables.
                        names(nra_less) <- c("election_state", "election_year", "contributions", "USD")
                        
                        ## Factorize, make numeric. 
                        nra_less$election_state <- as.factor(nra_less$election_state)
                        nra_less$election_year <- as.factor(as.numeric(nra_less$election_year))
                        nra_less$USD <- as.numeric(nra_less$USD)
                        nra_less$contributions <- as.numeric(nra_less$contributions)
                        
                        ## Order by year. 
                        nraFinal <- nra_less[order(nra_less$election_year), ]
                        
                        ## Remove 2015 entries, as zero. 
                        nraFinal <- nraFinal[-c(753:756),]
                        
                        ## Transform to long table. 
                        nraLong <- melt(nraFinal, id.vars = c("election_state", "election_year"))
                        
                        ## Subset by variable.
                        nraUSD <- subset(nraLong, variable == "USD")
                        
                        ## Transform USD for better readability of y axis.
                        nraUSD$value <- nraUSD$value/1000000
                        
                        ## Main plot: NRA contributions in USD by year and state
                        ## Subset
                        usState <- input$usState
                        data_to_plot1 <- nraUSD[nraUSD$election_state %in% usState, ]
                        ggplot(data_to_plot1, aes(x=election_year, y= value, group = election_state, color = election_state)) + 
                                geom_point() + 
                                geom_path() + 
                                guides(col=guide_legend(ncol=2)) +
                                xlab("Election Year") +
                                ylab("NRA donations in millions USD") +
                                theme(axis.title.x = element_text(size=15),
                                      axis.title.y = element_text(size=15),
                                      axis.text.x = element_text(size=12),
                                      axis.text.y = element_text(size=12),
                                      legend.text = element_text(size = 12),
                                      legend.title = element_text(size = 15)) +
                                guides(col = guide_legend(title="US state"))
                })
        }
)
