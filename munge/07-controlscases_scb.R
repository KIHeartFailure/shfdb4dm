
casecontrol <- bind_rows(
  fall_och_kontroller_1 %>% mutate(casetype = "withcontrols"),
  fall_och_kontroller_2 %>% mutate(casetype = "withcontrols"),
  fall_utan_kontroller_1 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_utan_kontroller_2 %>% mutate(casetype = "nocontrols") %>% rename(lopnr_fall = lopnr),
  fall_ej_i_register %>% mutate(casetype = "noreg") %>% rename(lopnr_fall = lopnr)
) %>%
  mutate(indexdtm = ymd(datum)) %>%
  select(lopnr_fall, lopnr_kontroll, fodelsear, indexdtm, casetype) %>%
  filter(indexdtm <= global_endcohort) ## OBS!!!!! Change this

case <- casecontrol %>%
  group_by(lopnr_fall, indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(-lopnr_kontroll)

# cases (rs + sos)
rsdata <- full_join(
  rsdata %>% mutate(inrs = 1),
  case,
  by = c("lopnr" = "lopnr_fall", "shf_indexdtm" = "indexdtm")
)

# kolla att sos cases är korrekt mot sos!!!!! HÄR

# select controls that have cases
control <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm, shf_sex), # add shf_age!!!!
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
    select(lopnrcase, lopnr, shf_indexdtm, shf_sex, fodelsear, casecontrol) # add shf_age
) %>%
  mutate(
    shf_indexyear = if_else(is.na(shf_indexyear), year(shf_indexdtm), shf_indexyear),
    lopnrcase = if_else(is.na(lopnrcase), lopnr, lopnrcase),
    casecontrol = factor(casecontrol, levels = 1:3, labels = c("Case SwedeHF", "Case SoS", "Control")), 
    scb_age = year(shf_indexdtm) - as.numeric(fodelsear)
    #scb_age = coalesce(scb_age, shf_age), CHANGE THIS WHEN GET DATA!!!!
    #shf_age = coalesce(shf_age, scb_age),
  ) %>%
  select(-inrs, -casetype -fodelsear)