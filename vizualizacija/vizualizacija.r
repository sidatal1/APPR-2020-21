# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
#                            pot.zemljevida="OB", encoding="Windows-1250")
# Če zemljevid nima nastavljene projekcije, jo ročno določimo
#proj4string(zemljevid) <- CRS("+proj=utm +zone=10+datum=WGS84")
#
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
#  summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))


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

tm_shape(zemljevid.slo) + geom_polygon("NAME_0") + theme(legend.position = "none")
