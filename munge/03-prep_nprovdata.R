ov <- ov %>%
  rename(
    HDIA = hdia,
    lopnr = LopNr
  ) %>%
  select(-INDATUMA)

ov <- prep_sosdata(ov, utdatum = FALSE, opvar = "op")
