pageWithSidebar(
        headerPanel("D&D Encounter Generator"),
        
        sidebarPanel(
                selectInput("envirvon",
                            "Environment",
                            choices = c("Arctic", "Coastal")
                ),
                sliderInput("characters",
                            "Number of Party Members",
                            min = 1,
                            max = 10,
                            value = 1,
                            step = 1
                ),
                sliderInput("level",
                            "Level of Party",
                            min = 1,
                            max = 20,
                            value = 1,
                            step = 1
                ),
                sliderInput("diff",
                            "Difficulty of Encounter",
                            min = 1,
                            max = 4,
                            value = 1,
                            step = 1
                ),
                actionButton("go",
                        "Attack!"     
                )
        ),
        mainPanel(
                textOutput("Encounter")
        )
)

