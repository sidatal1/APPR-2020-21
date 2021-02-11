# 3. faza: Vizualizacija podatkov

#GRAFI

#brezposelnost glede na drzavo in stopnjo izobrazbe
uvoz_1 %>%
  group_by(Leto, Drzava) %>%
  ggplot(aes(y=Drzava, x= Vrednost, col=Izobrazba)) + geom_point() +
  scale_color_discrete(name= "Stopnja izobrazbe", 
                       labels=c("Osnovnošolska", "Srednješolska", "Univerzitetna+")) +
  labs(title= "Brezposelnost po državah in stopnji izobrazbe") +
  ylab("Države") +
  xlab("Povprečna vrednost") + 
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=7), 
        text= element_text(size=10), plot.title = element_text(face = "bold"))


#povprecna vrednost po spolu
povprecna_vrednost <- uvoz_1 %>% 
  group_by(Spol,Drzava, Leto) %>% 
  summarize(VrednostMediane = round(median(Vrednost, na.rm=TRUE), digits = 1)) %>% 
  group_by(Spol, Drzava) %>%
  summarize(Povprecje= round(mean(VrednostMediane, na.rm=TRUE), digits = 1))


povprecna_vrednost %>% 
  ggplot(aes(x=Povprecje,y=Drzava, fill=Spol)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(title="Mediana brezposelnosti glede na spol") +
  scale_fill_discrete(labels=c("Ženske", "Moški")) +
  theme(panel.background = element_rect((fill="white")), axis.text= element_text(size=7), 
        text= element_text(size=12), plot.title = element_text(face = "bold")) +
  xlab("Vrednost") + ylab("Države")




#povprecna vrednost glede na izobrazbo in spol po regijah-slo
tabela2 <- uvoz_2 %>%
  group_by(Izobrazba, Spol, Regija, Leto) %>%
  summarize(povprecje= round(mean(Stopnja_brezposelnosti), digits = 1)) %>% arrange(Leto)

tabela2 %>%
  ggplot(aes(x=Regija,y=povprecje, shape=Spol, col=Spol)) +
  scale_shape_manual(values = c("\u2642", "\u2640")) +
  scale_color_manual(values = c("blue", "red")) +
  scale_x_discrete(labels=c("Vzhodna Slovenija" = "VS", "Zahodna Slovenija" = "ZS"))+
  geom_point(size=3) +
  facet_wrap(~Izobrazba, labeller = as_labeller(c('Nizja poklicna' = "Nižja poklicna",
                                      'OS' = "OŠ",
                                      'Srednja,splosna' = "Srednja, splošna",
                                      'Vss' = "VSŠ")), ncol=4) +
  labs(title="Povprečna st. brezposelnosti glede na izobrazbo po regijah") +
  ylab("Povprečna vrednost") + 
  theme(panel.background = element_rect((fill="lightyellow")), axis.text= element_text(size=7), 
        text= element_text(size=10), strip.background =element_rect(fill="white"), 
        plot.title = element_text(face = "bold"))
  



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

tabela2019 <- uvoz_4 %>%
  filter(Leto=="2019")

tabela2008 <- uvoz_4 %>%
  filter(Leto=="2008") 


z1 <- tm_shape(merge(zemljevid.slo, tabela4, by.x= "NAME_1", by.y="regija")) +
  tm_style(style="natural") +
  tm_polygons("povprecje", style="quantile", n=5, title="% povprečne brezposelnosti",
              palette=c('lightblue','khaki1', 'red3'),
              border.col='grey27', alpha=.7) +
  tm_legend(outside = TRUE, outside.position="right") +
  tm_text("NAME_1", size=0.6, col="black")
z1

z2 <- tm_shape(merge(zemljevid.slo, tabela2019, by.x="NAME_1", by.y="regija")) +
  tm_style(style = "col_blind") +
  tm_polygons("Stopnja_brezposelnosti", style="quantile", n=5, title="% brezposelnosti 2019",
              palette=c('lightblue','khaki1', 'red3'),
              border.col='grey27', alpha=.7) +
  tm_text("NAME_1", size=0.7, col="black") +
  tm_legend(outside=TRUE)
z2

z3 <- tm_shape(merge(zemljevid.slo, tabela2008, by.x="NAME_1", by.y="regija")) +
  tm_style(style = "col_blind") +
  tm_polygons("Stopnja_brezposelnosti", style="quantile", n=5, title="% brezposelnosti 2008",
              palette=c('lightblue','khaki1', 'red3'),
              border.col='grey27', alpha=.7) +
  tm_text("NAME_1", size=0.7, col="black") +
  tm_legend(outside=TRUE)
z3




  




