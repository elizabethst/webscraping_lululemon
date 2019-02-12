shinyServer(function(input, output) {
############# PRODUCT INFO ##################
  output$overview_subtitle = renderText({
    "Overview of reviews for lululemon tights"
  })
  output$overview_avg_rating = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(lululemon_reviews %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$overview_total_reviews = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(lululemon_reviews %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$overview_ratings_plot = renderPlotly({
    ggplotly(ggplot(lululemon_reviews, aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  
  
  ll_product1 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$product_comparison1)
  })
  ll_product2 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$product_comparison2)
  })

  output$product_comparison1_subtitle = renderText({
    print(input$product_comparison1)
  })
  output$avg_rating_product_comparison1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_product1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_product_comparison1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_product1() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$product_comparison1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_product1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  output$product_comparison2_subtitle = renderText({
    print(input$product_comparison2)
  })
  output$avg_rating_product_comparison2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_product2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_product_comparison2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_product2() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  
  output$product_comparison2_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_product2(), aes(x = `Rating`)) + 
               xlab("Rating (out of 5)") + ylab("Number of reviews") + 
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })  
  
  
  
  
  
  
  
  
  
  
  
  
  
############ CUSTOMER PROFILE ##################
  ## Athletic Type
  ll_athletic_type1 = reactive({
    lululemon_reviews %>% filter(., `Athletic Type` == input$athletic_type1)
  })
  ll_athletic_type2 = reactive({
    lululemon_reviews %>% filter(., `Athletic Type` == input$athletic_type2)
  })
  output$athletic_type1_subtitle = renderText({
    print(input$athletic_type1)
  })
  output$avg_rating_athletic_type1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_athletic_type1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_athletic_type1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_athletic_type1() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$athletic_type1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_athletic_type1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
    #scale_colour_brewer(palette = "Reds")
    
    #scale_fill_brewer(palette = "Reds")
  })
  
  output$athletic_type2_subtitle = renderText({
    print(input$athletic_type2)
  })
  output$avg_rating_athletic_type2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_athletic_type2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_athletic_type2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_athletic_type2() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  
  output$athletic_type2_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_athletic_type2(), aes(x = `Rating`)) + 
               xlab("Rating (out of 5)") + ylab("Number of reviews") + 
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })

  
  ## Age Range
  ll_age_range1 = reactive({
    lululemon_reviews %>% filter(., `Age Range` == input$age_range1)
  })
  ll_age_range2 = reactive({
    lululemon_reviews %>% filter(., `Age Range` == input$age_range2)
  })
  
  output$age_range1_subtitle = renderText({
    print(input$age_range1)
  })
  output$avg_rating_age_range1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_age_range1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_age_range1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_age_range1() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$age_range1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_age_range1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  output$age_range2_subtitle = renderText({
    print(input$age_range2)
  })
  output$avg_rating_age_range2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_age_range2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_age_range2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_age_range2() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  
  output$age_range2_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_age_range2(), aes(x = `Rating`)) + 
               xlab("Rating (out of 5)") + ylab("Number of reviews") + 
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  ## Body Type
  ll_body_type1 = reactive({
    lululemon_reviews %>% filter(., `Body Type` == input$body_type1)
  })
  ll_body_type2 = reactive({
    lululemon_reviews %>% filter(., `Body Type` == input$body_type2)
  })
  
  
  output$body_type1_subtitle = renderText({
    print(input$body_type1)
  })
  output$avg_rating_body_type1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_body_type1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_body_type1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_body_type1() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$body_type1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_body_type1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  output$body_type2_subtitle = renderText({
    print(input$body_type2)
  })
  output$avg_rating_body_type2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_body_type2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_body_type2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_body_type2() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  
  output$body_type2_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_body_type2(), aes(x = `Rating`)) + 
               xlab("Rating (out of 5)") + ylab("Number of reviews") + 
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  
  
  
  ## Fit Type
  ll_fit1 = reactive({
    lululemon_reviews %>% filter(., `Fit` == input$fit1)
  })
  ll_fit2 = reactive({
    lululemon_reviews %>% filter(., `Fit` == input$fit2)
  })
  
  output$fit1_subtitle = renderText({
    print(input$fit1)
  })
  output$avg_rating_fit1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_fit1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_fit1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_fit1() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  output$fit1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_fit1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  output$fit2_subtitle = renderText({
    print(input$fit2)
  })
  output$avg_rating_fit2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_fit2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$total_reviews_fit2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = round(ll_fit2() %>% select(., `Rating`) %>% pull %>% length),
             icon = icon("dumbbell"))
  })
  
  output$fit2_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_fit2(), aes(x = `Rating`)) + 
               xlab("Rating (out of 5)") + ylab("Number of reviews") + 
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })

  
  
  
  
  ll_sa_product1 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$sa_product1)
  })
  ll_sa_product2 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$sa_product2)
  })
  output$polarity_product1_subtitle = renderText({
    print(input$sa_product1)
  })
  output$avg_polarity_product1 = renderValueBox({
    valueBox(subtitle = "Average Polarity",
             value = round(ll_sa_product1() %>% select(., `Content Polarity`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$polarity_review_product1 = renderPlotly({
    ggplotly(ggplot(ll_sa_product1(), aes(x= factor(`Rating`), y = `Content Polarity`)) + 
               xlab("Rating (out of 5)") + ylab("Review Polarity") + 
               geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })

  
  output$polarity_product2_subtitle = renderText({
    print(input$sa_product2)
  })
  output$avg_polarity_product2 = renderValueBox({
    valueBox(subtitle = "Average Polarity",
             value = round(ll_sa_product2() %>% select(., `Content Polarity`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$polarity_review_product2 = renderPlotly({
    ggplotly(ggplot(ll_sa_product2(), aes(x= factor(`Rating`), y = `Content Polarity`)) + 
               xlab("Rating (out of 5)") + ylab("Review Polarity") + 
               geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  
})
