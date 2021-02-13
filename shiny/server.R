library(shiny)

shinyServer(function(input, output){
  output$brezposelnost <- DT::renderDataTable({
    uvoz_4 %>% group_by(regija) %>% 
      summarize(PovprecnaVrednost = round(mean(Stopnja_brezposelnosti), digits = 1)) %>%
      rename("Regija" = regija) %>% rename("Povprečna stopnja brezposelnosti" = PovprecnaVrednost)
  })
output$graf <- renderPlot({
    uvoz_4 %>% filter(Leto == input$Leto ) %>%
      ggplot(aes(y = Stopnja_brezposelnosti, x = regija)) + geom_point(col="deeppink", size=5) +
      theme_classic() + 
      ggtitle(paste("Stopnja brezposelnosti v letu", input$Leto)) +
      ylab("Vrednost") + 
      xlab("Regija") +
      theme(axis.text.y = element_text(size=9), axis.text.x = element_text(angle = 90),
            plot.title = element_text(face = "bold", hjust= 0.5)) +
      scale_y_continuous(breaks = seq(1, 12, 0.5))
    })
})