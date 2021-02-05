# 3. faza: Vizualizacija podatkov


#zemljevid Evrope
svet <- map_data("world")
svet %>%
  ggplot(aes(x=long, y=lat, group= group, fill = region))+
  geom_polygon()+
  coord_cartesian(xlim = c(-24, 50), ylim = c(30, 71))+
  labs(title="Svet")+
  theme(legend.position = "none")



#zemljevid Slovenije
zemljevid.slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip",
                                 "gadm36_SVN_0", encoding = "UTF-8")


#graf stopnje brezposelnosti glede na drzavo:

uvoz_1 %>%
  ggplot(aes(x= Vrednost, y= Drzava))+
  geom_point(colour= "blue") +
  labs(title= "Stopnja brezposelnosti po državah") +
  ylab("Države") +
  xlab("Stopnja brezposelnosti")

#graf stopnje brezposelnosti po drzavah glede na izobrazbo

uvoz_1 %>%
  ggplot(aes(x= Vrednost, y= Drzava))+
  geom_point() +
  facet_wrap(Izobrazba~.)


#graf stopnje brezposelnosti po drzavah glede na spol

uvoz_1 %>%
  ggplot(aes(x= Vrednost, y= Drzava))+
  geom_point(col= "red") +
  facet_grid(~Spol)


