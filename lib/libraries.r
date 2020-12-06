library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(tmap)
library(shiny)
library(dplyr)
library(readxl)
library(openxlsx)
require(readr)
require(tidyr)
require(tibble)
require(httr)
library(gsubfn)
library(tidyverse)
library(stringr)


options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
