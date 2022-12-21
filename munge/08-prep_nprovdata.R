
ov <- ov %>%
  rename(
    HDIA = hdia,
    lopnr = LopNr
  ) %>%
  select(-INDATUMA)

ovhf <- ov %>%
  filter(HDIA != "") %>%
  mutate(HDIA = paste0(" ", HDIA),
         tmp_hfsos = stringr::str_detect(HDIA, global_hficd)) %>%
  filter(tmp_hfsos) %>%
  select(lopnr, HDIA, INDATUM)

ov <- prep_sosdata(ov, utdatum = FALSE, opvar = "op")