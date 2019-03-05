shinyUI(fluidPage(theme = shinytheme("journal"),
#  shinythemes::themeSelector(),
  navbarPage("When Life Gives You (lulu)lemons",
             tabPanel("Overview",
                      sidebarLayout(
                        sidebarPanel(
                          dateRangeInput(inputId = "date_range",
                                         label = "Date Range",
                                         start = min(lululemon_reviews$Date),
                                         end = max(lululemon_reviews$Date)),
                          radioButtons(inputId = "radio_overview",
                                       label = "",
                                       choices = list("Absolute" = 1, "Relative" = 2),
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
                                                    choices = product_choices,
                                                    selected = "Fast & Free 7/8 Tight II Nulux 25\""),
                                     radioButtons(inputId = "radio_comparison",
                                                  label = "",
                                                  choices = list("Overview" = 1, "Athletic Type" = 2, "Age Range" = 3, "Body Type" = 4, "Fit" = 5),
                                                  selected = 1)
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
                        ),
                        tabPanel("Sentiment Analysis",
                                 sidebarLayout(
                                   sidebarPanel(
                                     selectizeInput(inputId = "sa_product1",
                                                    label = "Product 1",
                                                    choices = product_choices),
                                     selectizeInput(inputId = "sa_product2",
                                                    label = "Product 2",
                                                    choices = product_choices,
                                                    selected = "Fast & Free 7/8 Tight II Nulux 25\""),
                                     radioButtons(inputId="sa_radio", label = "",
                                                  choices = list("Polarity" = 1, "Subjectivity" = 2),
                                                  selected = 1,
                                                  inline = TRUE)
                                   ),
                                   mainPanel(
                                     column(6,
                                            textOutput("sa_product1_subtitle"),
                                            #valueBoxOutput("avg_polarity_product1", width = 6),
                                            br(), br(),
                                            plotlyOutput("sa_review_product1")),
                                     column(6,
                                            textOutput("sa_product2_subtitle"),
                                            #valueBoxOutput("avg_polarity_product2", width = 6),
                                            br(), br(),
                                            plotlyOutput("sa_review_product2"))
                                   )
                                 )),
                        tabPanel("Word Cloud",
                                 sidebarLayout(
                                   sidebarPanel(
                                     selectizeInput(inputId = "wc_product1",
                                                    label = "Product 1",
                                                    choices = product_choices),
                                     selectizeInput(inputId = "wc_product2",
                                                    label = "Product 2",
                                                    choices = product_choices,
                                                    selected = "Fast & Free 7/8 Tight II Nulux 25\""),
                                     br(),
                                     sliderInput("freq",
                                                 "Minimum Frequency:",
                                                 min = 1,  max = 500, value = 150),
                                     sliderInput("max",
                                                 "Maximum Number of Words:",
                                                 min = 1,  max = 300,  value = 100)
                                     
                                   ),
                                   mainPanel(
                                     column(6,
                                            textOutput("wordcloud_product1_subtitle"),
                                            plotOutput("wordcloud_product1"),
                                            plotlyOutput("wc_hist1"),
                                            dataTableOutput("wordcloud_table1")),
                                     column(6,
                                            textOutput("wordcloud_product2_subtitle"),
                                            plotOutput("wordcloud_product2"),
                                            plotlyOutput("wc_hist2"),
                                            dataTableOutput("wordcloud_table2"))
                                   )
                                 ))
             ),
             navbarMenu("Customer Profile",
                      tabPanel("Athletic Type",
                        sidebarLayout(
                          sidebarPanel(
                            selectizeInput(inputId = "athletic_type1",
                                           label = "Athletic Type 1",
                                           choices = athletic_type_choices),
                            selectizeInput(inputId = "athletic_type2",
                                           label = "Athletic Type 2",
                                           choices = athletic_type_choices,
                                           selected = "N/A")
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
                                                  choices = age_range_choices,
                                                  selected = "N/A")
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
                                                  choices = body_type_choices,
                                                  selected = "N/A")
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
                                                  choices = fit_choices,
                                                  selected = "N/A")
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
             tabPanel("Response Rate",
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput(inputId = "response1",
                                         label = "Product 1",
                                         choices = product_choices),
                          selectizeInput(inputId = "response2",
                                         label = "Product 2",
                                         choices = product_choices,
                                         selected = "Fast & Free 7/8 Tight II Nulux 25\""),
                          radioButtons(inputId = "radio_response",
                                       label = "",
                                       choices = list("Absolute" = 1, "Relative" = 2),
                                       selected = 1,
                                       inline = TRUE)
                        ),
                        mainPanel(
                          column(6,
                                 valueBoxOutput("rr_total_reviews1", width = 6),
                                 valueBoxOutput("number_responses1", width = 6),
                                 valueBoxOutput("response_rate1", width = 6),
                                 valueBoxOutput("avg_response_time1", width = 6),
                                 br(), br(), br(), br(), br(), br(),
                                 br(), br(), br(), br(), br(), br(),
                                 plotlyOutput("response_plot1")),
                          column(6,
                                 valueBoxOutput("rr_total_reviews2", width = 6),
                                 valueBoxOutput("number_responses2", width = 6),
                                 valueBoxOutput("response_rate2", width = 6),
                                 valueBoxOutput("avg_response_time2", width = 6),
                                 br(), br(), br(), br(), br(), br(),
                                 br(), br(), br(), br(), br(), br(),
                                 plotlyOutput("response_plot2"))
                        )
                      )),
             tabPanel("References",
                      htmlOutput("references")
                      ),
             tabPanel("About Me",
                      htmlOutput("contact")
                      ),
             responsive = TRUE)
  
))
