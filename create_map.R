library(leaflet)
library(mapview)

coords.csv = read.csv("urnerfahnen-standorte.csv")
coords = sf::st_as_sf(coords.csv, coords = c("lon", "lat"), crs = 4326)

nrow(unique(round(coords.csv, 4))) == nrow(coords.csv)

map = leaflet() |>
	addProviderTiles(providers$CartoDB.Positron) %>%
	addCircleMarkers(data = coords,
					fillColor = "#F8D755", color = "#121212", weight = 2,
					opacity = 1, fillOpacity = 1)

mapview::mapshot(map, url = "docs/index.html")
unlink("docs/index_files", recursive = T)
sf::st_write(coords, "docs/urnerfahnen-standorte.geojson", delete_dsn = TRUE)
