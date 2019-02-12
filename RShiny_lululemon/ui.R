#https://github.com/NLMichaud/WeeklyCDCPlot/blob/master/ui.R

shinyUI(fluidPage(#theme = shinytheme("simplex"),
  shinythemes::themeSelector(),
  navbarPage(strong("When Life Gives You (lulu)lemons"),
             tabPanel("lululemon Overview/brand analysis",
                      sidebarLayout(
                        sidebarPanel(
                          dateRangeInput(inputId = "date_range",
                                         label = "Date Range",
                                         start = min(lululemon_reviews$Date),
                                         end = max(lululemon_reviews$Date)),
                          radioButtons(inputId = "radio_comparison",
                                       label = "",
                                       choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                       selected = 1,
                                       inline = TRUE)
                        ),
                        mainPanel(
                          textOutput("overview_subtitle"),
                          valueBoxOutput("overview_avg_rating", width = 6),
                          valueBoxOutput("overview_total_reviews", width = 6),
                          br(), br(), br(), br(), br(), br(),
                          plotlyOutput("overview_ratings_plot")
                          )
                        )
                      ),
             navbarMenu("Product Comparisons",
                        tabPanel("Rating breakdown",
                                 sidebarLayout(
                                   sidebarPanel(
                                     selectizeInput(inputId = "product_comparison1",
                                                    label = "Product 1",
                                                    choices = product_choices),
                                     selectizeInput(inputId = "product_comparison2",
                                                    label = "Product 2",
                                                    choices = product_choices),
                                     radioButtons(inputId = "radio_comparison",
                                                  label = "",
                                                  choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                                  selected = 1,
                                                  inline = TRUE)
                                   ),
                                   mainPanel(
                                     column(6, 
                                            textOutput("product_comparison1_subtitle"),
                                            valueBoxOutput("avg_rating_product_comparison1", width = 6),
                                            valueBoxOutput("total_reviews_product_comparison1", width = 6),
                                            br(), br(), br(), br(), br(), br(),
                                            plotlyOutput("product_comparison1_ratings_plot")),
                                     column(6, 
                                            textOutput("product_comparison2_subtitle"),
                                            valueBoxOutput("avg_rating_product_comparison2", width = 6),
                                            valueBoxOutput("total_reviews_product_comparison2", width = 6),
                                            br(), br(), br(), br(), br(), br(),
                                            plotlyOutput("product_comparison2_ratings_plot"))
                                   )
                                 )
                        )
             ),
             navbarMenu("Customer profile",
                      tabPanel("Athletic Type",
                        sidebarLayout(
                          sidebarPanel(
                            selectizeInput(inputId = "athletic_type1",
                                           label = "Athletic Type 1",
                                           choices = athletic_type_choices),
                            selectizeInput(inputId = "athletic_type2",
                                           label = "Athletic Type 2",
                                           choices = athletic_type_choices),
                            radioButtons(inputId = "athletic_type_comparison",
                                         label = "",
                                         choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                         selected = 1,
                                         inline = TRUE)
                            ),
                            mainPanel(
                              column(6, 
                                     textOutput("athletic_type1_subtitle"),
                                     valueBoxOutput("avg_rating_athletic_type1", width = 6),
                                     valueBoxOutput("total_reviews_athletic_type1", width = 6),
                                     br(), br(), br(), br(), br(), br(),
                                     plotlyOutput("athletic_type1_ratings_plot")),
                              column(6, 
                                     textOutput("athletic_type2_subtitle"),
                                     valueBoxOutput("avg_rating_athletic_type2", width = 6),
                                     valueBoxOutput("total_reviews_athletic_type2", width = 6),
                                     br(), br(), br(), br(), br(), br(),
                                     plotlyOutput("athletic_type2_ratings_plot"))
                            )
                          )
                        ),
                      tabPanel("Age Range",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectizeInput(inputId = "age_range1",
                                                  label = "Age Range 1",
                                                  choices = age_range_choices),
                                   selectizeInput(inputId = "age_range2",
                                                  label = "Age Range 2",
                                                  choices = age_range_choices),
                                   radioButtons(inputId = "radio_comparison",
                                                label = "",
                                                choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                                selected = 1,
                                                inline = TRUE)
                                 ),
                                 mainPanel(
                                   column(6, 
                                          textOutput("age_range1_subtitle"),
                                          valueBoxOutput("avg_rating_age_range1", width = 6),
                                          valueBoxOutput("total_reviews_age_range1", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("age_range1_ratings_plot")),
                                   column(6, 
                                          textOutput("age_range2_subtitle"),
                                          valueBoxOutput("avg_rating_age_range2", width = 6),
                                          valueBoxOutput("total_reviews_age_range2", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("age_range2_ratings_plot"))
                                 )
                               )
                      ),
                      tabPanel("Body Type",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectizeInput(inputId = "body_type1",
                                                  label = "Body Type 1",
                                                  choices = body_type_choices),
                                   selectizeInput(inputId = "body_type2",
                                                  label = "Body Type 2",
                                                  choices = body_type_choices),
                                   radioButtons(inputId = "radio_comparison",
                                                label = "",
                                                choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                                selected = 1,
                                                inline = TRUE)
                                 ),
                                 mainPanel(
                                   column(6, 
                                          textOutput("body_type1_subtitle"),
                                          valueBoxOutput("avg_rating_body_type1", width = 6),
                                          valueBoxOutput("total_reviews_body_type1", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("body_type1_ratings_plot")),
                                   column(6, 
                                          textOutput("body_type2_subtitle"),
                                          valueBoxOutput("avg_rating_body_type2", width = 6),
                                          valueBoxOutput("total_reviews_body_type2", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("body_type2_ratings_plot"))
                                   
                                 )
                               )
                      ),
                      tabPanel("Fit",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectizeInput(inputId = "fit1",
                                                  label = "Fit 1",
                                                  choices = fit_choices),
                                   selectizeInput(inputId = "fit2",
                                                  label = "Fit 2",
                                                  choices = fit_choices),
                                   radioButtons(inputId = "radio_comparison",
                                                label = "",
                                                choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                                selected = 1,
                                                inline = TRUE)
                                 ),
                                 mainPanel(
                                   column(6, 
                                          textOutput("fit1_subtitle"),
                                          valueBoxOutput("avg_rating_fit1", width = 6),
                                          valueBoxOutput("total_reviews_fit1", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("fit1_ratings_plot")),
                                   column(6, 
                                          textOutput("fit2_subtitle"),
                                          valueBoxOutput("avg_rating_fit2", width = 6),
                                          valueBoxOutput("total_reviews_fit2", width = 6),
                                          br(), br(), br(), br(), br(), br(),
                                          plotlyOutput("fit2_ratings_plot"))
                                   
                                 )
                               )
                      )
                      
                      ),
             tabPanel("Sentiment Analysis",
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput(inputId = "sa_product1",
                                         label = "Product 1",
                                         choices = product_choices),
                          selectizeInput(inputId = "sa_product2",
                                         label = "Product 2",
                                         choices = product_choices),
                          radioButtons(inputId = "radio_comparison",
                                       label = "",
                                       choices = list("Overview" = 1, "Yearly" = 2, "Monthly" = 3, "Daily" = 4),
                                       selected = 1,
                                       inline = TRUE)
                        ),
                        mainPanel(
                          column(6,
                                 textOutput("polarity_product1_subtitle"),
                                 #valueBoxOutput("avg_polarity_product1", width = 6),
                                 br(), br(), br(), br(), br(), br(),
                                 plotlyOutput("polarity_review_product1")),
                          column(6,
                                 textOutput("polarity_product2_subtitle"),
                                 #valueBoxOutput("avg_polarity_product2", width = 6),
                                 br(), br(), br(), br(), br(), br(),
                                 plotlyOutput("polarity_review_product2"))
                        )
                      )),
             tabPanel("Response Rate / Customer Service"),
             tabPanel("References"),
             tabPanel("About Me"),
             responsive = TRUE)
  
  
  
  
  # # Sidebar with a slider input for number of bins 
  # sidebarLayout(
  #   sidebarPanel(
  #      sliderInput("bins",
  #                  "Number of bins:",
  #                  min = 1,
  #                  max = 50,
  #                  value = 30)
  #   ),
  #   
  #   # Show a plot of the generated distribution
  #   mainPanel(
  #      plotOutput("distPlot")
  #   )
  # )
  
  
  
  
))
