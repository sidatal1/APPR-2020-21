# 4. faza: Analiza podatkov

theme_set(theme_bw())

#napoved Turcija
podatki <- uvoz_1 %>%
  filter(Drzava== "Turkey") %>%
  group_by(Leto, Spol) %>%
  summarize(vrednost = round(mean(Vrednost), digits=2)) 

model <- loess(data=podatki, vrednost ~ Leto, control = loess.control(surface = "direct"))
leto <- data.frame(Leto=seq(2008,2030,1))
napoved <- mutate(leto, vrednost = predict(model, leto))

graf_napoved <- napoved %>%
  ggplot(aes(x=Leto, y=vrednost)) +
  geom_smooth(method="loess", fullrange=TRUE, color="red", formula=y ~ x) +
  geom_point(size=1, color="blue") +
  scale_x_continuous('Leto', breaks = seq(2008, 2030, 3)) +
  ylab("Stopnja brezposelnosti") +
  labs(title = "Napoved stopnje brezposelnosti za Turčijo do leta 2030")
graf_napoved


#analiza Slovenija

analiza1 <- ggplot(uvoz_4, aes(x=Leto, y=Stopnja_brezposelnosti)) +
  geom_point(size=1, col="blue") +
  geom_smooth(method="loess", formula= y~x, color="deeppink", size=0.2) +
  facet_wrap(~regija) +
  scale_x_continuous("Leto",  breaks = seq(2008, 2019, 5)) +
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=6), 
        text= element_text(size=10), strip.background =element_rect(fill="white"), 
        strip.text.x = element_text(size = 9)) +
  labs("Analiza stopnje brezposelnosti po regijah") +
  ylab("Stopnja brezposelnosti")
analiza1



analiza2 <- ggplot(uvoz_4, aes(x=Leto, y=Stopnja_brezposelnosti)) +
  geom_point(size=1, col="blue") +
  geom_smooth(method="loess", formula= y~x, color="deeppink", size=0.2) +
  scale_x_continuous("Leto",  breaks = seq(2008, 2019, 3)) +
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=6), 
        text= element_text(size=10)) +
  labs("Analiza brezposelnosti po regijah") +
  ylab("Stopnja brezposelnosti")
analiza2
