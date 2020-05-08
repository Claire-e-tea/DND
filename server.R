function(input, output, session){
        ## Define inputs as variables to be used in the function.
        characters <- reactive({as.numeric(input$characters)})
        level <- reactive({as.numeric(input$level)})
        diff <- reactive({as.numeric(input$diff)})
        environ <- reactive({input$envirvon})
        
        ## Read datafiles of monster database and exp thresholds database.
        mf <- read.csv("mf.csv")
        expthreshdf <- read.csv("expthreshdf.csv")
        
        ## Starting output for main panel.
        output$Encounter <- renderText({'Click "Attack!" to generate an encounter!'})
        
## Encounter function to be run when the button is clicked.        
encounter <- observeEvent(input$go, {
        
        ## Determine the exp threshold to be met based off of the number of characters and their level.
        expthresh1 <- expthreshdf[level(), diff()]
        expthreshfinal <- expthresh1 * characters()
        
        ## Set the challenge rating of the encounter to Inf so the while loop makes at least one pass.
        finalcr <- Inf
        
        ## Subset the monster databasae for just the selected environment.
        f <- mf[mf$Environment == environ(), ]
        
        ## Generate encounters until the encounter is below the exp threshold, but not too far below.
        while(finalcr > expthreshfinal || finalcr < 0.75 * expthreshfinal){
                
                ## Gather a random creature. Define objects for its name and exp given.
                crow <- sample(1:nrow(f), 1)
                expgiven <- f[crow, 3]
                cname <- f[crow, 2]
                
                ## Randomly select 
                n <- sample(1:15, 1)
                
                ## Next step in calculating the CR of the encounter.
                totalcr <- n * expgiven
                
                ## Select the modifier to the CR based on number of monsters as per DMG rules.
                if (n == 1){
                        finalcr <- totalcr
                } else if (n == 2){
                        finalcr <- totalcr * 1.5
                } else if (n >= 3 && n <= 6){
                        finalcr <- totalcr * 2
                } else if (n >= 7 && n <= 10){
                        finalcr <- totalcr * 2.5
                } else if (n >= 11 && n <= 14){
                        finalcr <- totalcr * 3
                } else {
                        finalcr <- totalcr * 4
                }
        }
        ## End of generation while loop.
        
        ## Print the final outputs as a string!
        output$Encounter <- renderText({paste(n, " ", cname, "(s) attack you!", sep = "")})
})
}