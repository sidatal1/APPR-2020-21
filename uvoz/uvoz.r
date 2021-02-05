# 2. faza: Uvoz podatkov


# 1.tabela

uvoz_1 <- read_csv("podatki/1.tabela1.csv",
                   locale = locale(encoding = "UTF-8"),
                   skip = 1,
                   col_names = "stolpec") %>% 
                   separate(stolpec, c("Leto1", "Spol", "Izobrazba", "Starost", "Enota", "Vrednost"), '","' ) %>%
                   separate("Leto1", c("Leto", "Drzava"), ",")  %>% 
                   select(-Starost, -Enota) %>%
                   mutate(Vrednost = as.factor(gsub('"',"", Vrednost))) %>%
                   mutate(Drzava = as.character(gsub('"',"", Drzava))) 
                            

                 
uvoz_1$Leto <- as.integer(uvoz_1$Leto) 
uvoz_1$Drzava <- as.character(uvoz_1$Drzava) 
uvoz_1$Spol <- as.factor(uvoz_1$Spol) 
uvoz_1$Izobrazba <- as.factor(uvoz_1$Izobrazba)

#malo lepša imena držav
uvoz_1$Drzava[uvoz_1$Drzava == "Germany (until 1990 former territory of the FRG)"] <- "Germany"
uvoz_1$Drzava[uvoz_1$Drzava == "France (metropolitan)"] <- "France"
uvoz_1$Drzava[uvoz_1$Drzava == "North Macedonia"] <- "Macedonia"

#popravki v zadnjem stolpcu
uvoz_1$Vrednost <- gsub(",", ".", uvoz_1$Vrednost)
uvoz_1$Vrednost <- gsub(":", NA, uvoz_1$Vrednost)
uvoz_1$Vrednost <- as.numeric(uvoz_1$Vrednost)



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
  geom_point(col= "blue") +
  facet_grid(~Spol)



 # 2.tabela
 
uvoz_2 <- read_xlsx("podatki/2.tabela.xlsx",
                    col_names = c("Leto", "Regija", "Spol", "4", "5",
                                  "Osnovnosolska", "7", "Nizja_ali_srednja_poklicna",
                                  "9", "Srednja_strokovna, splosna", "11",
                                  "Visjesolska_ali_visokosolska", "13"),
                    na = "N",
                    skip = 4,
                    n_max = 48) %>%
                    select(-4,-5,-7,-9,-11,-13) %>%
                    fill(1:2) %>%
                    pivot_longer(cols = c("Osnovnosolska", "Nizja_ali_srednja_poklicna",
                                          "Srednja_strokovna, splosna", "Visjesolska_ali_visokosolska"),
                                 names_to = "Izobrazba",
                                 values_to = "StopnjaBrezposelnosti" )



uvoz_2$Leto <- as.integer(uvoz_2$Leto)
uvoz_2$Regija <- as.factor(uvoz_2$Regija)
uvoz_2$Spol <- as.factor(uvoz_2$Spol)
uvoz_2$Brez_izobrazbe <- as.numeric(uvoz_2$Brez_izobrazbe)
uvoz_2$Osnovnosolska <- as.numeric(uvoz_2$Osnovnosolska)
uvoz_2$Nizja_ali_srednja_poklicna <- as.numeric(uvoz_2$Nizja_ali_srednja_poklicna)
uvoz_2$`Srednja_strokovna, splosna` <- as.numeric(uvoz_2$`Srednja_strokovna, splosna`)
uvoz_2$Visjesolska_ali_visokosolska <- as.numeric(uvoz_2$Visjesolska_ali_visokosolska)


#brezposelnost_2008 <- filter(uvoz_2, Leto == 2008)
#brezposelnost_2019 <- filter(uvoz_2, Leto == 2019)

#graf brezposelnosti z osnovnosolsko izobrazbo glede na spol po regijah
uvoz_2 %>% 
  ggplot(aes(x=Spol, y=Osnovnosolska, col= Regija))+
  geom_point()
 
# 3.tabela

uvoz_3 <- read_xlsx("podatki/3.tabela1.xlsx", 
                    col_names= c("Trajanje", "Spol", "Leto", "Vzhodna_Slovenija", "Zahodna_Slovenija"),
                    skip = 4,
                    na="N")  %>%
                    fill(1:2)
                    
                     
uvoz_3$Trajanje <- as.factor(uvoz_3$Trajanje)
uvoz_3$Leto <- as.integer(uvoz_3$Leto)
uvoz_3$Spol <- as.factor(uvoz_3$Spol)
uvoz_3$Vzhodna_Slovenija <- as.numeric(uvoz_3$Vzhodna_Slovenija)
uvoz_3$Zahodna_Slovenija <- as.numeric(uvoz_3$Zahodna_Slovenija)


#urejanje 1. stolpca
uvoz_3$Trajanje <- gsub("[[:punct:]]", "", uvoz_3$Trajanje)




#RAČUNANJE

uvoz_1 %>% arrange(Spol, desc(Vrednost)) %>% View

#tabela stopnje brezposelnosti glede na spol

brezposelnost.moski <- filter(uvoz_1, Spol == "Males")
brezposelnost.zenske <- filter(uvoz_1, Spol == "Females")   
 
#1.
#povprecna vrednost po spolu in drzavi 

povprecna_vrednost <- uvoz_1 %>% 
  group_by(Spol,Drzava, Leto) %>% 
  summarize(VrednostMediane=median(Vrednost, na.rm=TRUE)) %>% 
  group_by(Spol, Drzava) %>%
  summarize(Povprecje= mean(VrednostMediane, na.rm=TRUE))  %>% arrange(Drzava) %>%
  pivot_wider(names_from = Spol, values_from= Povprecje) %>%  View


#max vrednost glede na izobrazbo po drzavah v letih 2008 in 2019

maksimalna_vrednost2008 <- uvoz_1 %>%
  filter(Leto== "2008") %>%
  group_by(Izobrazba, Spol) %>%
  summarize(maks2008=max(Vrednost, na.rm=TRUE)) %>% 
  pivot_wider(names_from = Spol, values_from= maks2008) %>% View
  
maksimalna_vrednost2019 <- uvoz_1 %>%
  filter(Leto== "2019") %>%
  group_by(Izobrazba, Spol) %>%
  summarize(maks2019=max(Vrednost, na.rm=TRUE)) %>% 
  pivot_wider(names_from = Spol, values_from= maks2019) %>% View

#2.

#povprecna vrednost glede na izobrazbo in spol po regijah-slo


neki <- uvoz_2 %>%
  group_by(Izobrazba, Regija, Spol) %>%
  summarize(povprecje= mean(StopnjaBrezposelnosti)) %>% View



  


