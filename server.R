library(shiny)
library(reshape)
library(tidyr)
library(dplyr)
library(ggplot2)
shinyServer(
        function(input, output, session) {
                output$plot_total <- renderPlot({
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
                        
                        ## Aggregate.
                        Contrib_Year <- aggregate(nraFinal$contributions, by = list(nraFinal$election_year), FUN = sum)
                        
                        ## Rename.
                        names(Contrib_Year) <- c("year", "contributions")
                        
                        ## Transform for better readability of y axis.
                        Contrib_Year$contributions <- Contrib_Year$contributions/1000
                        
                        ## Plot. 
                        ggplot(Contrib_Year, aes(x=year, y=contributions)) + 
                                geom_bar(stat="identity") +
                                xlab("Election Year") +
                                ylab("Individual NRA donations (in thousands)") +
                                theme(axis.text.x = element_text(color = "black", size = 15, angle = 35),
                                      axis.text.y = element_text(color = "black", size = 15),
                                      axis.title.x = element_text(color = "black", size = 18),
                                      axis.title.y = element_text(color = "black", size = 18, vjust = 1.5),
                                      panel.grid.minor.x = element_blank(), panel.grid.major.x=element_blank())
                })
                output$plot_total2 <- renderPlot({
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
                        
                        ## Plot USD by year across all states.
                        ## Aggregate.
                        USD_Year <- aggregate(nraFinal$USD, by = list(nraFinal$election_year), FUN = sum)
                        
                        ## Rename.
                        names(USD_Year) <- c("year", "USD")
                        
                        ## Transform USD for better readability of y axis. 
                        USD_Year$USD <- USD_Year$USD/1000000
                        ## Plot.
                        ggplot(USD_Year, aes(x=year, y=USD)) + 
                        geom_bar(stat="identity") +
                        xlab("Election Year") +
                        ylab("NRA donations in millions US$") +
                        theme(axis.text.x = element_text(color = "black", size = 15),
                              axis.text.y = element_text(color = "black", size = 15),
                              axis.title.x = element_text(color = "black", size = 18),
                              axis.title.y = element_text(color = "black", size = 18, vjust = 1.5),
                              panel.grid.minor.x = element_blank(), panel.grid.major.x=element_blank())
                })
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
                output$plot_contrib <- renderPlot({
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
                        nraContrib <- subset(nraLong, variable == "contributions")
                        
                        ## Convert numeric variable for better readability of y axis.
                        nraContrib$value <- nraContrib$value/1000
                        
                        ## Main plot: NRA number if individual contributions by state
                        ## Subset
                        usState2 <- input$usState2
                        data_to_plot2 <- nraContrib[nraContrib$election_state %in% usState2, ]
                        ggplot(data_to_plot2, aes(x=election_year, y= value, group = election_state, color = election_state)) + 
                                geom_point() + 
                                geom_path() + 
                                guides(col=guide_legend(ncol=2)) +
                                xlab("Election Year") +
                                ylab("Number of contributions by NRA (in thousands") +
                                theme(axis.title.x = element_text(size=15),
                                      axis.title.y = element_text(size=15),
                                      axis.text.x = element_text(size=12),
                                      axis.text.y = element_text(size=12),
                                      legend.text = element_text(size = 12),
                                      legend.title = element_text(size = 15)) +
                                guides(col = guide_legend(title="US state"))
                })
                output$plot_state1 <- renderPlot({
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
                        
                        ## Plot individual contributions by state.
                        ## Aggregate.
                        Contrib_State <- aggregate(nraFinal$contributions, by = list(nraFinal$election_state), FUN = sum)
                        
                        ## Rename.
                        names(Contrib_State) <- c("state", "contributions")
                        
                        ## Reorder factor levels by contributions.
                        Contrib_State$state <- reorder(Contrib_State$state, Contrib_State$contributions)
                        
                        ## Transform for better readability of y axis.
                        Contrib_State$contributions <- Contrib_State$contributions/1000
                        
                        ## Plot.
                        ggplot(Contrib_State, aes(x=state, y=contributions)) + 
                                geom_bar(stat="identity") +
                                xlab("US State") +
                                ylab("Individual NRA donations (in thousands)") +
                                theme(axis.text.x = element_text(color = "black", size = 12, angle = 45),
                                      axis.text.y = element_text(color = "black", size = 15),
                                      axis.title.x = element_text(color = "black", size = 18),
                                      axis.title.y = element_text(color = "black", size = 18, vjust = 1.5),
                                      panel.grid.minor.x = element_blank(), panel.grid.major.x=element_blank())
                        
                })
                output$plot_state2 <- renderPlot({
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
                        
                        ## Plot USD total by state. 
                        ## Aggregate.
                        USD_State <- aggregate(nraFinal$USD, by = list(nraFinal$election_state), FUN = sum)
                        
                        ## Rename variables.
                        names(USD_State) <- c("state", "USD")
                        
                        ## Reorder levels. 
                        USD_State$state <- reorder(USD_State$state, USD_State$USD)
                        
                        ## Transform USD for better readability of y axis. 
                        USD_State$USD <- USD_State$USD/1000000
                        
                        ## Plot.
                        ggplot(USD_State, aes(x=state, y=USD)) + 
                                geom_bar(stat="identity") +
                                xlab("US State") +
                                ylab("NRA donations in millions US$") +
                                theme(axis.text.x = element_text(color = "black", size = 12, angle = 45),
                                      axis.text.y = element_text(color = "black", size = 15),
                                      axis.title.x = element_text(color = "black", size = 18),
                                      axis.title.y = element_text(color = "black", size = 18, vjust = 1.5),
                                      panel.grid.minor.x = element_blank(), panel.grid.major.x=element_blank())
                })
})
