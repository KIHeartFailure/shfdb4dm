casecontrol <- bind_rows(
  fall_och_kontroller_1 %>% mutate(casetype = "withcontrols"),
  fall_och_kontroller_2 %>% mutate(casetype = "withcontrols"),
  fall_utan_kontroller_1 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_utan_kontroller_2 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_ej_i_register %>% mutate(casetype = "noreg") %>% rename(lopnr_fall = lopnr)
) %>%
  mutate(indexdtm = ymd(datum)) %>%
  select(lopnr_fall, lopnr_kontroll, fodelsear, indexdtm, casetype)


# Prepare NPR cases -------------------------------------------------------

case <- casecontrol %>%
  group_by(lopnr_fall, indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(-lopnr_kontroll)

# Check and fix SOS HF pop ----------------------------------------------------

hfpopcase <- hfpop %>%
  mutate(
    sosindexdtm = coalesce(UTDATUM, INDATUM),
    hf = str_detect(HDIA, global_hficd)
  ) %>%
  filter(hf) %>%
  group_by(lopnr) %>%
  arrange(sosindexdtm) %>%
  slice(1) %>%
  ungroup()

hfpopcase <- right_join(
  case,
  hfpopcase,
  by = c("lopnr_fall" = "lopnr")
) %>%
  mutate(
    diff = sosindexdtm - indexdtm,
    keepcontrols = ifelse(!is.na(diff) & abs(diff) < 365, 1, 0)
  ) %>%
  group_by(lopnr_fall) %>%
  arrange(sosindexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr_fall, indexdtm, sosindexdtm, diff, keepcontrols)

hfpopcase <- left_join(
  hfpopcase,
  demo %>% select(LopNr, fodelsear, kon),
  by = c("lopnr_fall" = "LopNr")
) %>%
  mutate(
    shf_age = year(sosindexdtm) - as.numeric(fodelsear),
    shf_sex = factor(kon, levels = 1:2, labels = c("Male", "Female")),
    lopnr = as.numeric(lopnr_fall),
    casecontrol = 2
  ) %>%
  select(lopnr, indexdtm, shf_age, shf_sex, sosindexdtm, diff, keepcontrols, casecontrol) %>%
  rename(shf_indexdtm = sosindexdtm) # set the index date to sos date and not SCB/SOS case/control date


# select controls that have cases
# rs
control_rs <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm, shf_sex, shf_age),
  casecontrol %>% filter(!is.na(lopnr_kontroll)),
  by = c("lopnr" = "lopnr_fall", "shf_indexdtm" = "indexdtm")
) %>%
  mutate(
    lopnrcase = lopnr,
    lopnr = lopnr_kontroll,
    casecontrol = 3
  ) %>%
  group_by(lopnr, lopnrcase, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, lopnrcase, shf_indexdtm, casecontrol, shf_sex, shf_age)

# sos
control_sos <- inner_join(
  hfpopcase,
  casecontrol %>% filter(!is.na(lopnr_kontroll)),
  by = c("lopnr" = "lopnr_fall", "indexdtm")
) %>%
  filter(keepcontrols == 1) %>%
  mutate(
    casecontrol = 4
  ) %>%
  rename(
    lopnrcase = lopnr,
    lopnr = lopnr_kontroll
  ) %>%
  group_by(lopnr, lopnrcase, indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, lopnrcase, casecontrol, shf_indexdtm, shf_sex, shf_age)

# cases (rs + sos) + controls all together now

rsdata <- bind_rows(
  rsdata %>% mutate(
    casecontrol = 1
  ),
  hfpopcase %>% select(lopnr, casecontrol, shf_indexdtm, shf_sex, shf_age),
  control_rs,
  control_sos
) %>%
  mutate(
    shf_indexyear = if_else(is.na(shf_indexyear), year(shf_indexdtm), shf_indexyear),
    lopnrcase = if_else(is.na(lopnrcase), lopnr, lopnrcase),
    casecontrol = factor(casecontrol,
      levels = 1:4,
      labels = c("Case SwedeHF", "Case NPR", "Control SwedeHF", "Control NPR")
    )
  )
