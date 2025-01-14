# Dataset with repeated heart failure hospitalizations --------------------

svpatreg <- patreg %>%
  filter(sos_source == "sv") %>%
  filter(stringr::str_detect(HDIA, global_hficd))

rsdatatmp <- rsdatafull %>%
  select(lopnr, shf_indexdtm) %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(1) %>%
  ungroup()

hfhfull <- left_join(
  rsdatatmp,
  svpatreg %>%
    select(lopnr, INDATUM),
  by = "lopnr"
) %>%
  filter(INDATUM > shf_indexdtm & INDATUM <= global_endfollowup) %>%
  rename(sos_out_hfhdtm = INDATUM) %>%
  select(lopnr, sos_out_hfhdtm)

rsdatatmp <- rsdata %>%
  select(lopnr, shf_indexdtm, censdtm) %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(1) %>%
  ungroup()

hfh <- left_join(
  rsdatatmp,
  svpatreg %>%
    select(lopnr, INDATUM),
  by = "lopnr"
) %>%
  filter(INDATUM > shf_indexdtm & INDATUM <= global_endfollowup) %>%
  rename(sos_out_hfhdtm = INDATUM) %>%
  select(lopnr, sos_out_hfhdtm)
