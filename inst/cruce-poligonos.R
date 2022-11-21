path_to_file <- "inst/extdata/locs.rds"
df_locs <- readRDS(path_to_file)

library(sf)

path_to_shape <- "~/Projects/segdist/data/Barrios/Barrios.shp"
tt <- read_sf(path_to_shape)

df_distritos <- readr::read_csv2("https://geoportal.madrid.es/fsdescargas/IDEAM_WBGEOPORTAL/LIMITES_ADMINISTRATIVOS/Barrios/Barrios.csv")


# pnts <- data.frame(
#   "x" = c(-73.97817,-74.00668,0,500),
#   "y" = c(40.75798, 40.73178,0,400))

pnts_sf <- sf::st_as_sf(df_locs, coords = c("lon", "lat"),
                        crs = 4326)

pnts_trans <- st_transform(pnts_sf, 2163)
tt_trans <- st_transform(tt, 2163)

res <- sf::st_join(pnts_trans, tt_trans)

res$geometry


intersects <- st_intersects( pnts_trans,tt_trans)
intersects

pnts_sf$geometry

tt_trans$geometry

df_locs$cosa <- as.integer(intersects)




library(dplyr)

df_locs %>%
  left_join(df_distritos %>%
              select(cosa = COD_BAR, NOMDIS))

df_distritos %>%
  filter(COD_BAR == 49)
