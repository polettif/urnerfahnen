tmp.geojson = tempfile(fileext = ".geojson")
writeLines(clipr::read_clip(), tmp.geojson)

geojson = tvio::read_geo(tmp.geojson)

tbl = geojson |>
    geowerkzeuge::sf_to_cols() |>
    dplyr::mutate(lon = sprintf("%.5f", lon), lat = sprintf("%.5f", lat)) |>
    write.table(row.names = FALSE, sep = ",", col.names = FALSE, quote = FALSE) |>
    capture.output()

tbl

clipr::write_clip(tbl)
