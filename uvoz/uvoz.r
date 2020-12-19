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
uvoz_1$Drzava <- as.factor(uvoz_1$Drzava) 
uvoz_1$Spol <- as.factor(uvoz_1$Spol) 
uvoz_1$Izobrazba <- as.factor(uvoz_1$Izobrazba)


#popravki v zadnjem stolpcu
uvoz_1$Vrednost <- gsub(",", ".", uvoz_1$Vrednost)
uvoz_1$Vrednost <- gsub(":", NA, uvoz_1$Vrednost)
uvoz_1$Vrednost <- as.numeric(uvoz_1$Vrednost)





# 2.tabela
 
uvoz_2 <- read_xlsx("podatki/2.tabela.xlsx",
                    col_names = c("Leto", "Regija", "Spol", "Brez_izobrazbe", "5",
                                  "Osnovnosolska", "7", "Nizja_ali_srednja_poklicna",
                                  "9", "Srednja_strokovna, splosna", "11",
                                  "Višjesolska_ali_visokosolska", "13"),
                    na = "N",
                    skip = 4,
                    n_max = 48) %>%
                    select(-5,-7,-9,-11,-13) %>%
                    fill(1:2)



uvoz_2$Leto <- as.integer(uvoz_2$Leto)
uvoz_2$Regija <- as.factor(uvoz_2$Regija)
uvoz_2$Spol <- as.factor(uvoz_2$Spol)
uvoz_2$Brez_izobrazbe <- as.numeric(uvoz_2$Brez_izobrazbe)
uvoz_2$Osnovnosolska <- as.numeric(uvoz_2$Osnovnosolska)
uvoz_2$Nizja_ali_srednja_poklicna <- as.numeric(uvoz_2$Nizja_ali_srednja_poklicna)
uvoz_2$`Srednja_strokovna, splosna` <- as.numeric(uvoz_2$`Srednja_strokovna, splosna`)
uvoz_2$Višjesolska_ali_visokosolska <- as.numeric(uvoz_2$Višjesolska_ali_visokosolska)




 
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





                                                 
    



