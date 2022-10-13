
casecontrol <- bind_rows(
  fall_och_kontroller_1 %>% mutate(casetype = "withcontrols"),
  fall_och_kontroller_2 %>% mutate(casetype = "withcontrols"),
  fall_utan_kontroller_1 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_utan_kontroller_2 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_ej_i_register %>% mutate(casetype = "noreg") %>% rename(lopnr_fall = lopnr)
) %>%
  mutate(indexdtm = ymd(datum)) %>%
  select(lopnr_fall, lopnr_kontroll, fodelsear, indexdtm, casetype) %>%
  filter(indexdtm <= global_endcohort)

case <- casecontrol %>%
  filter(casetype != "noreg") %>%
  group_by(lopnr_fall, indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(-lopnr_kontroll)

case <- left_join(
  case,
  demo %>% select(lopnr, fodelseman, kon),
  by = c("lopnr_fall" = "lopnr")
) %>%
  mutate(
    tmpfoddtm = ymd(paste0(fodelseman, "15")),
    scb_age = floor(as.numeric(indexdtm - tmpfoddtm)),
    scb_sex = factor(kon, levels = 1:2, labels = c("Male", "Female"))
  ) %>%
  select(lopnr_fall, indexdtm, casetype, scb_age, scb_sex)


# cases (rs + sos)
rsdata <- full_join(
  rsdata %>% mutate(inrs = 1),
  case,
  by = c("lopnr" = "lopnr_fall", "shf_indexdtm" = "indexdtm")
) %>%
  mutate(
    scb_age = coalesce(shf_age, scb_age),
    scb_sex = coalesce(shf_sex, scb_sex)
  )

# kolla att sos cases är korrekt mot sos!!!!!

# select controls that have cases
control <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm, scb_sex, scb_age),
  casecontrol,
  by = c("lopnr" = "lopnr_fall", "shf_indexdtm" = "indexdtm")
) %>%
  mutate(
    lopnrcase = lopnr,
    lopnr = lopnr_kontroll
  )


rsdata <- bind_rows(
  rsdata %>%
    mutate(casecontrol = if_else(!is.na(inrs), 1, 2)),
  control %>%
    mutate(casecontrol = 3) %>%
    select(lopnrcase, lopnr, shf_indexdtm, scb_sex, scb_age, casecontrol)
) %>%
  mutate(
    shf_indexyear = if_else(is.na(shf_indexyear), year(shf_indexdtm), shf_indexyear),
    lopnrcase = if_else(is.na(lopnrcase), lopnr, lopnrcase),
    casecontrol = factor(casecontrol, levels = 1:3, labels = c("Case SwedeHF", "Case SoS", "Control"))
  ) %>%
  select(-inrs, -casetype)
