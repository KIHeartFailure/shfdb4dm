# Merge sos data ----------------------------------------------------------

patreg <- bind_rows(
  svlink %>% mutate(sos_source = "sv"),
  ov %>% mutate(sos_source = "ov") %>% select(-sosdtm)
)

rm(list = ls()[grepl("sv|ov", ls())]) # delete to save workspace

patreg <- left_join(
  patreg,
  dors %>% select(lopnr, sos_deathdtm),
  by = "lopnr"
) %>%
  mutate(sos_source = if_else(
    !is.na(UTDATUM) &
      INDATUM == UTDATUM &
      (is.na(sos_deathdtm) |
        INDATUM != sos_deathdtm), "ov", sos_source
  )) %>%
  select(-sos_deathdtm)

hfpop <- patreg %>%
  mutate(tmp_hfsos = stringr::str_detect(DIA_all, global_hficd)) %>%
  filter(tmp_hfsos) %>%
  select(lopnr, HDIA, DIA_all, INDATUM, UTDATUM)
