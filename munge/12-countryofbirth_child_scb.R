# anyDuplicated(demo$lopnr)

demo <- demo %>%
  mutate(
    scb_countryofbirth = factor(case_when(
      fodelseland_EU28 %in% c(
        "Afrika",
        "Asien",
        "Nordamerika",
        "Oceanien",
        "Sovjetunionen",
        "Sydamerika",
        "Statslos"
      ) ~ 3,
      fodelseland_EU28 %in% c(
        "EU28 utom Norden",
        "Europa utom EU28 och Norden",
        "Norden utom Sverige"
      ) ~ 2,
      fodelseland_EU28 == "Sverige" ~ 1
    ), levels = 1:3, labels = c("Sweden", "Europe", "Other"))
  )

rsdata <- left_join(
  rsdata,
  demo %>% select(scb_countryofbirth, LopNr),
  by = c("lopnr" = "LopNr")
)

child <- bind_rows(barnadop, barnbio)

child2 <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm, shf_indexyear),
  child,
  by = c("lopnr" = "LopNr")
)

child2 <- child2 %>%
  filter(fodelsearbarn < shf_indexyear) %>%
  group_by(lopnr, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  mutate(scb_child = 1) %>%
  select(lopnr, shf_indexdtm, scb_child)

rsdata <- left_join(
  rsdata,
  child2,
  by = c("lopnr", "shf_indexdtm")
) %>%
  mutate(scb_child = factor(replace_na(scb_child, 0),
    levels = 0:1,
    labels = c("No", "Yes")
  ))
