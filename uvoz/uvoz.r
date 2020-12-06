# 2. faza: Uvoz podatkov


# 1.tabela

uvoz_1 <- read_csv("podatki/1.tabela1.csv",
                   skip = 1,
                   col_names = "stolpec") %>% 
                   separate(stolpec, c("Leto1", "Spol", "Izobrazba", "Starost", "Enota", "Vrednost"), '","' ) %>%
                   separate("Leto1", c("Leto", "Drzava"), ",")  %>% 
                   select(-Starost, -Enota) %>%
                   mutate(Vrednost = as.character(gsub('"',"", Vrednost))) %>%
                   mutate(Drzava = as.character(gsub('"',"", Drzava)))
                            

                 
uvoz_1$Leto <- parse_integer(uvoz_1$Leto)
#as.numeric(as.factor(uvoz_1["Vrednost"]))
#sapply(uvoz_1, class)




# 2.tabela
 
uvoz_2 <- read_xlsx("podatki/2.tabela.xlsx",
                     col_names= c("Leto", "Regija", "Spol", "Brez_izobrazbe", "5",
                                  "Osnovnosolska", "7", "Nizja_ali_srednja_poklicna",
                                  "9", "Srednja_strokovna, splosna", "11", "Višjesolska_ali_visokosolska", "13"),
                     na= "N",
                     skip=4,
                     n_max=48) %>%
                     select(-5,-7,-9,-11,-13) %>% fill(1:2)
 
# 3.tabela

uvoz_3 <- read_xlsx("podatki/3.tabela1.xlsx",
                     col_names= c("Trajanje", "Spol", "Leto", "Vzhodna_Slovenija", "Zahodna_Slovenija"),
                    skip = 4,
                    na="N") %>% fill(1:2)
                     
                     









                                                 
    



