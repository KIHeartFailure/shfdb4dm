
# Merge sos data ----------------------------------------------------------

patreg <- bind_rows(
  svlink %>% mutate(sos_source = "sv"),
  ov %>% mutate(sos_source = "ov") %>% select(-sosdtm)
)

hfpop <- bind_rows(
  svhf %>% mutate(sos_source = "sv"),
  ovhf %>% mutate(sos_source = "ov")
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