# 4. faza: Analiza podatkov

theme_set(theme_bw())

#napoved Turcija

podatki <- uvoz_1 %>%
  filter(Drzava == "Turkey", Spol == "Males", 
         Izobrazba == "Upper secondary and post-secondary non-tertiary education (levels 3 and 4)") 

graf1 <- ggplot(podatki, aes(x=Leto, y= Vrednost)) + geom_point(color="black")
model <- lm(data = podatki, Vrednost ~ Leto)
graf2 = graf1 + geom_smooth(method = "lm", fullrange=TRUE, formula = y~x)
nova <- data.frame(Leto = 2008:2030)
napoved <- mutate(nova, Vrednost=predict(model, nova))


graf_napoved <- graf2 +  geom_point(data=napoved,aes(x=Leto,y= Vrednost), size = 1, color = "blue") +
  scale_x_continuous('Leto', breaks = seq(2008, 2030, 3)) +
  ylab("Stopnja brezposelnosti") +
  labs(title = "Napoved stopnje brezposelnosti v Turčiji za moške s srednjo izobrazbo do \n leta 2030")
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
