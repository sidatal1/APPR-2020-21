# 2. faza: Uvoz podatkov


# 1.tabela

uvoz_1 <- read_csv("podatki/1.tabela1.csv",
                   locale = locale(encoding = "UTF-8"),
                   skip = 1,
                   col_names = "stolpec") %>% 
                   separate(stolpec, c("Leto1", "Spol", "Izobrazba", "Starost", "Enota", "Vrednost"), '","' ) %>%
                   separate("Leto1", c("Leto", "Drzava"), ",")  %>% 
                   select(-Starost, -Enota) %>%
                   mutate("Vrednost" = as.factor(gsub('"',"", Vrednost)),
                          "Vrednost" = gsub(",", ".", Vrednost),
                           Drzava = as.character(gsub('"',"", Drzava)),
                           Leto = as.integer(Leto))  
                          
                            
uvoz_1$Vrednost <- as.numeric(uvoz_1$Vrednost)
#malo lepša imena držav
uvoz_1$Drzava[uvoz_1$Drzava == "Germany (until 1990 former territory of the FRG)"] <- "Germany"
uvoz_1$Drzava[uvoz_1$Drzava == "France (metropolitan)"] <- "France"
uvoz_1$Drzava[uvoz_1$Drzava == "North Macedonia"] <- "Macedonia"



# 2.tabela
 
uvoz_2 <- read_xlsx("podatki/2.tabela.xlsx",
                    col_names = c("Leto", "Regija", "Spol", "4", "5",
                                  "OS", "7", "Nizja poklicna",
                                  "9", "Srednja,splosna", "11",
                                  "Vss", "13"),
                    na = "N",
                    skip = 4,
                    n_max = 48) %>%
                    select(-4, -5, -7, -9, -11, -13) %>%
                    fill(1:2) %>%
                    pivot_longer(cols = c("OS", "Nizja poklicna",
                                          "Srednja,splosna", "Vss"),
                                 names_to = "Izobrazba",
                                 values_to = "Stopnja_brezposelnosti" ) %>%
                    mutate(Leto = as.integer(Leto),)


 
# 3.tabela

uvoz_3 <- read_xlsx("podatki/3.tabela1.xlsx", 
                    col_names= c("Trajanje", "Spol", "Leto", "Vzhodna_Slovenija", "Zahodna_Slovenija"),
                    skip = 4,
                    na= "N")  %>%
                    fill(1:2) %>%
                    mutate("Trajanje" = as.character(gsub('\\.*',"", Trajanje)),
                           "Leto" = as.integer(Leto)) %>%
                    pivot_longer(cols= c("Zahodna_Slovenija", "Vzhodna_Slovenija"),
                                 names_to = "Kohezijska_regija",
                                 values_to = "Stopnja_brezposelnosti" )
                   




uvoz_4 <- read_xlsx("podatki/TABELA4.xlsx",
                    skip = 1,
                    n_max=13) %>%
                    select(-2, -3, -4) %>%
                    pivot_longer(cols = c("Pomurska", "Podravska",
                       "Koroška", "Savinjska", "Zasavska", "Posavska", "Jugovzhodna Slovenija",
                       "Osrednjeslovenska", "Gorenjska",
                       "Primorsko-notranjska", "Goriška", "Obalno-kraška"),
                    names_to = "regija",
                    values_to = "Stopnja_brezposelnosti" )
                    
names(uvoz_4)[1] <- "Leto"
uvoz_4$regija[uvoz_4$regija == "Posavska"] <- "Spodnjeposavska"
uvoz_4$regija[uvoz_4$regija == "Primorsko-notranjska"] <- "Notranjsko-kraška"


