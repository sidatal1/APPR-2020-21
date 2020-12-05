# 2. faza: Uvoz podatkov

library("dplyr")
library("readxl")
library("openxlsx")
require("readr")
require("tidyr")
require("tibble")
require("httr")
library("gsubfn")
require("rvest")
library("tidyverse")
require("stringr")


# 1.tabela

uvoz_1 <- read.csv2("podatki/1.tabela1.csv",
                   col.names = "stolpec") %>% 
                   separate(stolpec, c("leto", "Spol", "Izobrazba","starost", "enota", "Vrednost"), '","' ) %>%
                   separate("leto", c("Leto", "Država"), ",")  %>% 
                   select(-starost, -enota) 

                 
uvoz_1$Leto <- parse_integer(uvoz_1$Leto)





# 2.tabela
 
uvoz_2 <- read_xlsx("podatki/2.tabela.xlsx",
                     col_names= c("Leto", "Regija", "Spol", "Brez izobrazbe", "5",
                                  "Osnovnošolska", "7", "Nižja ali srednja poklicna",
                                  "9", "Srednja strokovna, splošna", "11", "Višješolska, visokošolska", "13"),
                     na= "N",
                     skip=4,
                     n_max=48) %>%
                     select(-5,-7,-9,-11,-13) %>% fill(1:2)
 
# 3.tabela

uvoz_3 <- read_xlsx("podatki/3.tabela.xlsx",
                     col_names= c("Trajanje", "Leto", "Moški-VS", "4", "Moški-ZS",
                                  "6", "Ženske-VS", "8", "Ženske-ZS", "10"),
                     skip=5,
                     n_max=49) %>%
                     select(-4,-6,-8,-10) %>% fill(1)
                     









                                                 
    



