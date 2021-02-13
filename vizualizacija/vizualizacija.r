# 3. faza: Vizualizacija podatkov

#GRAFI

#brezposelnost glede na drzavo in stopnjo izobrazbe
viz1 <- uvoz_1 %>%
  group_by(Leto, Drzava) %>%
  ggplot(aes(y=Drzava, x= Vrednost, col=Izobrazba)) + geom_point() +
  scale_color_discrete(name= "Stopnja izobrazbe", 
                       labels=c("Osnovnošolska", "Srednješolska", "Univerzitetna+")) +
  labs(title= "Brezposelnost po državah in stopnji izobrazbe") +
  ylab("Države") +
  xlab("Povprečna vrednost") + 
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=7), 
        text= element_text(size=10), plot.title = element_text(face = "bold"))
viz1

#povprecna vrednost po spolu
povprecna_vrednost <- uvoz_1 %>% 
  group_by(Spol,Drzava, Leto) %>% 
  summarize(VrednostMediane = round(median(Vrednost, na.rm=TRUE), digits = 1)) %>% 
  group_by(Spol, Drzava) %>%
  summarize(Povprecje= round(mean(VrednostMediane, na.rm=TRUE), digits = 1))


viz2 <- povprecna_vrednost %>% 
  ggplot(aes(x=Povprecje,y=Drzava, fill=Spol)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(title="Povprečna brezposelnost glede na spol") +
  scale_fill_discrete(labels=c("Ženske", "Moški")) +
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=7), 
        text= element_text(size=12), plot.title = element_text(face = "bold")) +
  xlab("Vrednost") + ylab("Države")



#povprecna vrednost glede na izobrazbo in spol po regijah-slo
tabela2 <- uvoz_2 %>%
  group_by(Izobrazba, Spol, Regija, Leto) %>%
  summarize(povprecje= round(mean(Stopnja_brezposelnosti), digits = 1)) %>% arrange(Leto)

viz3 <- tabela2 %>%
  ggplot(aes(x=Regija,y=povprecje, shape=Spol, col=Spol)) +
  scale_shape_manual(values = c("\u2642", "\u2640")) +
  scale_color_manual(values = c("blue", "red")) +
  scale_x_discrete(labels=c("Vzhodna Slovenija" = "VS", "Zahodna Slovenija" = "ZS"))+
  geom_point(size=3) +
  facet_grid(~factor(Izobrazba, levels= c("OS", "Nizja poklicna", "Srednja,splosna", "Vss"),
                     labels = c("OŠ", "Nižja poklicna", "Srednja, splošna", "VSŠ"), ordered = TRUE)) +
  labs(title="Povprečna stopnja brezposelnosti glede na izobrazbo po regijah") +
  ylab("Povprečna vrednost") + 
  theme(panel.background = element_rect((fill="lightyellow")), axis.text= element_text(size=7), 
        text= element_text(size=10), strip.background =element_rect(fill="white"), 
        plot.title = element_text(face = "bold"))
  
viz3


#graf stopnje brezposelnosti glede na drzavo:
uvoz_1 %>%
  ggplot(aes(x= Vrednost, y= Drzava, col="Spol"))+
  geom_point(colour= "green") +
  labs(title= "Povprečna stopnja brezposelnosti po državah") +
  ylab("Države") +
  xlab("Stopnja brezposelnosti") +
  theme(panel.background = element_rect((fill="white")),text = element_text(size=9)) +
  theme(plot.title = element_text(face = "bold"))


  
#ZEMLJEVIDI

zemljevid.slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip",
                                 "gadm36_SVN_1", encoding = "UTF-8")

tabela4 <- uvoz_4 %>%
  group_by(regija) %>%
  summarize(povprecje = round(mean(Stopnja_brezposelnosti), digits=2))


zemljevid1 <- tm_shape(merge(zemljevid.slo, tabela4, by.x= "NAME_1", by.y="regija")) +
  tm_style(style="natural") +
  tm_polygons("povprecje", style="quantile", n=5, title="Povprečna stopnja brezposelnosti",
              palette=c('lightblue','khaki1', 'red3')) +
  tm_legend(outside = TRUE, outside.position="right") +
  tm_text("NAME_1", size=0.6, col="black") +
  tm_layout(legend.frame = FALSE, legend.bg.color = NA)
zemljevid1






  




