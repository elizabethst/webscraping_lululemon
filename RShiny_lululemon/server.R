shinyServer(function(input, output) {
############# PRODUCT INFO ##################
  output$overview_subtitle = renderText({
    "Overview of reviews for lululemon tights"
  })
  output$overview_avg_rating = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(lululemon_reviews %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("fas fa-star"))
  })
  output$overview_total_reviews = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(round(lululemon_reviews %>% select(., `Rating`) %>% pull %>% length), big.mark = ","),
             icon = icon("dumbbell"))
  })
  output$overview_ratings_plot = renderPlotly({
    lulu_date = lululemon_reviews %>% filter(., Date >= input$date_range[1] & Date <= input$date_range[2])
    gg = ggplot(lulu_date, aes(x = `Rating`))
    if (input$radio_overview == 1) {
      ggplotly(gg +
                 xlab("Rating (out of 5)") + ylab("Number of reviews") +
                 geom_bar(aes(fill = factor(year(Date)))) + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    } else if (input$radio_overview == 2) {
      ggplotly(gg +
                 xlab("Rating (out of 5)") + ylab("Proportion of reviews") +
                 geom_bar(aes(fill = factor(year(Date))), position = "fill") + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    }
    
  })
  
  ### Product Comparisons
  ## Ratings
  ll_product1 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$product_comparison1)
  })
  ll_product2 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$product_comparison2)
  })

  output$product_comparison1_subtitle = renderText({
    print(paste("Ratings for ", input$product_comparison1))
  })
  output$avg_rating_product_comparison1 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_product1() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("fas fa-star"))
  })
  output$total_reviews_product_comparison1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_product1() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
             icon = icon("dumbbell"))
  })
  output$product_comparison1_ratings_plot = renderPlotly({
    gg = ggplot(ll_product1(), aes(x = `Rating`)) +
      xlab("Rating (out of 5)") + ylab("Number of reviews") + scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    if (input$radio_comparison == 1) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Rating`))))
    } else if (input$radio_comparison == 2) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Athletic Type`))))
    } else if (input$radio_comparison == 3) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Age Range`))))
    } else if (input$radio_comparison == 4) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Body Type`))))
    } else if (input$radio_comparison == 5) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Fit`))))
    }
  })
  
  output$product_comparison2_subtitle = renderText({
    print(paste("Ratings for ", input$product_comparison2))
  })
  output$avg_rating_product_comparison2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_product2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("fas fa-star"))
  })
  output$total_reviews_product_comparison2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_product2() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
             icon = icon("dumbbell"))
  })
  
  output$product_comparison2_ratings_plot = renderPlotly({
    gg = ggplot(ll_product2(), aes(x = `Rating`)) +
      xlab("Rating (out of 5)") + ylab("Number of reviews") + scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    if (input$radio_comparison == 1) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Rating`))))
    } else if (input$radio_comparison == 2) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Athletic Type`))))
    } else if (input$radio_comparison == 3) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Age Range`))))
    } else if (input$radio_comparison == 4) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Body Type`))))
    } else if (input$radio_comparison == 5) {
      ggplotly(gg + geom_bar(aes(fill = factor(`Fit`))))
    }
  })
  
  
  ## Sentiment Analysis
  ll_sa_product1 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$sa_product1)
  })
  ll_sa_product2 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$sa_product2)
  })
  output$sa_product1_subtitle = renderText({
    print(input$sa_product1)
  })
  output$avg_polarity_product1 = renderValueBox({
    valueBox(subtitle = "Average Polarity",
             value = round(ll_sa_product1() %>% select(., `Content Polarity`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  
  output$sa_review_product1 = renderPlotly({
    if (input$sa_radio == 1) {
      ggplotly(ggplot(ll_sa_product1(), aes(x= factor(`Rating`), y = `Content Polarity`)) + 
                 xlab("Rating (out of 5)") + ylab("Review Polarity") + 
                 geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    }
    else if (input$sa_radio == 2) {
      ggplotly(ggplot(ll_sa_product1(), aes(x= factor(`Rating`), y = `Content Subjectivity`)) + 
                 xlab("Rating (out of 5)") + ylab("Review Subjectivity") + 
                 geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    }
    
  })
  
  output$sa_product2_subtitle = renderText({
    print(input$sa_product2)
  })
  output$avg_polarity_product2 = renderValueBox({
    valueBox(subtitle = "Average Polarity",
             value = round(ll_sa_product2() %>% select(., `Content Polarity`) %>% pull %>% mean, digits = 2),
             icon = icon("dumbbell"))
  })
  output$sa_review_product2 = renderPlotly({
    if (input$sa_radio == 1) {
      ggplotly(ggplot(ll_sa_product2(), aes(x= factor(`Rating`), y = `Content Polarity`)) + 
                 xlab("Rating (out of 5)") + ylab("Review Polarity") + 
                 geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    }
    else if (input$sa_radio == 2) {
      ggplotly(ggplot(ll_sa_product2(), aes(x= factor(`Rating`), y = `Content Subjectivity`)) + 
                 xlab("Rating (out of 5)") + ylab("Review Subjectivity") + 
                 geom_boxplot(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
                 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                       panel.background = element_blank(), axis.line = element_line(colour = "black"),
                       legend.position = "none"))
    }
  })
  
  ## Word Cloud
  wordcloud_rep = repeatable(wordcloud)
  
  output$wordcloud_product1_subtitle = renderText({
    print(paste("Wordcloud for ",input$wc_product1))
  })
  output$wordcloud_product1 = renderPlot({
    wordcloud_rep(words = names(getTermMatrix(input$wc_product1)), freq = getTermMatrix(input$wc_product1), scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(5, "Dark2"))
  })
  output$wc_hist1 = renderPlotly({
    wc_hist = (data.frame("Word" = names(getTermMatrix(input$wc_product1)), "Frequency" = getTermMatrix(input$wc_product1)))[1:10,]
    wc_hist$Word = factor(wc_hist$Word, levels = wc_hist$Word[order(-wc_hist$Frequency)])
    ggplot(wc_hist, aes(x = Word, y = Frequency)) + geom_col(aes(fill = Word)) + 
      #scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  output$wordcloud_table1 = renderDataTable({
    DT::datatable(cbind("Word" = names(getTermMatrix(input$wc_product1)), "Frequency" = getTermMatrix(input$wc_product1)), rownames = F, options = list(pageLength = 5))
  })
  
  output$wordcloud_product2_subtitle = renderText({
    print(paste("Wordcloud for ",input$wc_product2))
  })
  output$wordcloud_product2 = renderPlot({
    wordcloud_rep(words = names(getTermMatrix(input$wc_product2)), freq = getTermMatrix(input$wc_product2), scale=c(4,0.5),
              min.freq = input$freq, max.words=input$max,
              colors=brewer.pal(5, "Dark2"))
  })
  output$wc_hist2 = renderPlotly({
    wc_hist = (data.frame("Word" = names(getTermMatrix(input$wc_product2)), "Frequency" = getTermMatrix(input$wc_product2)))[1:10,]
    wc_hist$Word = factor(wc_hist$Word, levels = wc_hist$Word[order(-wc_hist$Frequency)])
    ggplot(wc_hist, aes(x = Word, y = Frequency)) + geom_col(aes(fill = Word)) + 
      #scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  output$wordcloud_table2 = renderDataTable({
    DT::datatable(cbind("Word" = names(getTermMatrix(input$wc_product2)), "Frequency" = getTermMatrix(input$wc_product2)), rownames = F, options = list(pageLength = 5))
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_athletic_type1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_athletic_type1() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
             icon = icon("dumbbell"))
  })
  output$athletic_type1_ratings_plot = renderPlotly({
    ggplotly(ggplot(ll_athletic_type1(), aes(x = `Rating`)) +
               xlab("Rating (out of 5)") + ylab("Number of reviews") +
               geom_bar(aes(fill = factor(Rating))) + scale_fill_brewer(palette = "Reds") +
               theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                     panel.background = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none"))
  })
  
  output$athletic_type2_subtitle = renderText({
    print(input$athletic_type2)
  })
  output$avg_rating_athletic_type2 = renderValueBox({
    valueBox(subtitle = "Average Rating",
             value = round(ll_athletic_type2() %>% select(., `Rating`) %>% pull %>% mean, digits = 2),
             icon = icon("fas fa-star"))
  })
  output$total_reviews_athletic_type2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_athletic_type2() %>% select(., `Rating`) %>% pull %>% length, big.mark=","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_age_range1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_age_range1() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_age_range2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_age_range2() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_body_type1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_body_type1() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_body_type2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_body_type2() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_fit1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_fit1() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
             icon = icon("fas fa-star"))
  })
  output$total_reviews_fit2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_fit2() %>% select(., `Rating`) %>% pull %>% length, big.mark = ","),
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
  
  ## Response rate
  ll_response1 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$response1)
  })
  ll_response2 = reactive({
    lululemon_reviews %>% filter(., `Product Name` == input$response2)
  })
  
  output$response1_subtitle = renderText({
    print(paste("Responses for ", input$response1))
  })
  output$rr_total_reviews1 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_response1() %>% select(., "Content") %>% nrow, big.mark = ","),
             icon = icon("fas fa-star"))
  })
  output$number_responses1 = renderValueBox({
    valueBox(subtitle = "Number of responses",
             value = prettyNum(ll_response1() %>% filter(., `lululemon response` != "") %>% nrow, big.mark = ","),
             icon = icon("fas fa-star"))
  })
  output$response_rate1 = renderValueBox({
    valueBox(subtitle = "Response rate",
             value = paste0(round(((ll_response1() %>% filter(., `lululemon response` != "") %>% nrow)/(ll_response1() %>% select(., "Content") %>% nrow))*100, digits = 2), "%"),
             icon = icon("fas fa-star"))
  })
  output$avg_response_time1 = renderValueBox({
    dates1 = ll_response1() %>% filter(., `lululemon response` != "") %>% select(., `Date`, `lululemon response date`)
    valueBox(subtitle = "Average response time (days)",
             value = round(mean(dates1$`lululemon response date` - dates1$`Date`), digits = 2),
             icon = icon("fas fa-star"))
  })
  output$response_plot1 = renderPlotly({
    gg = ggplot(ll_response1(), aes(x = `Rating`)) + 
      xlab("Rating (out of 5)") + scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    if (input$radio_response == 1){
      ggplotly(gg + ylab("Number of reviews") + geom_bar(aes(fill = factor(Responded))))
    } else if (input$radio_response == 2){
      ggplotly(gg + ylab("Proportion of reviews") + geom_bar(aes(fill = factor(Responded)), position = "fill"))
    }
  })

  output$response2_subtitle = renderText({
    print(paste("Responses for ", input$response2))
  })
  output$rr_total_reviews2 = renderValueBox({
    valueBox(subtitle = "Total Number of Reviews",
             value = prettyNum(ll_response2() %>% select(., "Content") %>% nrow, big.mark = ","),
             icon = icon("fas fa-star"))
  })
  output$number_responses2 = renderValueBox({
    valueBox(subtitle = "Number of responses",
             value = prettyNum(ll_response2() %>% filter(., `lululemon response` != "") %>% nrow, big.mark = ","),
             icon = icon("fas fa-star"))
  })
  output$response_rate2 = renderValueBox({
    valueBox(subtitle = "Response rate",
             value = paste0(round(((ll_response2() %>% filter(., `lululemon response` != "") %>% nrow)/(ll_response2() %>% select(., "Content") %>% nrow))*100, digits = 2), "%"),
             icon = icon("fas fa-star"))
  })
  output$avg_response_time2 = renderValueBox({
    dates2 = ll_response2() %>% filter(., `lululemon response` != "") %>% select(., `Date`, `lululemon response date`)
    valueBox(subtitle = "Average response time (days)",
             value = round(mean(dates2$`lululemon response date` - dates2$`Date`), digits = 2),
             icon = icon("fas fa-star"))
  })
  output$response_plot2 = renderPlotly({
    gg = ggplot(ll_response2(), aes(x = `Rating`)) + 
      xlab("Rating (out of 5)") + scale_fill_brewer(palette = "Reds") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    if (input$radio_response == 1){
      ggplotly(gg + ylab("Number of reviews") + geom_bar(aes(fill = factor(Responded))))
    } else if (input$radio_response == 2){
      ggplotly(gg + ylab("Proportion of reviews") + geom_bar(aes(fill = factor(Responded)), position = "fill"))
    }
  })
  
  output$references = renderUI({
    HTML(paste("Founded in Vancouver, Canada in 1998, <a href='https://shop.lululemon.com/'>lululemon athletica</a> \
                is a technical athletic apparel company for yoga, running, training and most other sweaty pursuits. <br><br> \
               The webpage scraped can be found <a href='https://shop.lululemon.com/c/women-pants/_/N-1z109yvZ7yh'>here</a>."))
  })
  
  output$contact = renderUI({
    HTML(paste("Stella Kim is a data scientist with a passion for data analytics, visualization,\
               machine learning, statistical methodology, and programming. Primarily interested \
               in helping businesses make data-driven, customer-centric decisions. <br><br>\
               
               <b>Contact Information</b>:<br>
               Phone: (516) 510-3002<br>
               Email: <a href = 'mailto:stellahkim93@gmail.com'>stellahkim93@gmail.com</a><br>
               <a href = 'https://github.com/stellahkim93'>GitHub</a><br>
               <a href = 'www.linkedin.com/in/stellahkim93'>LinkedIn</a><br>"))
  })
  
})
