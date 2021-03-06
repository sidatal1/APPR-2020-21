library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(tmap)
library(shiny)
library(dplyr)
library(readxl)
library(openxlsx)
library(readr)
library(tidyr)
library(tibble)
library(gsubfn)
library(tidyverse)
library(stringr)
library(ggplot2)
library(dplyr)
library(maps)
library(ggmap)
library(mapproj)
library(scales)
library(rgdal)
library(RColorBrewer)
library(maptools)
library(rgeos)



options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
