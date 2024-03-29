# Comorbidities -----------------------------------------------------------

rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "hypertension",
  diakod = " I1[0-5]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "diabetes",
  diakod = " E1[0-4]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "ihd",
  diakod = " 41[0-4]| I2[0-5]",
  # stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "mi",
  diakod = " 410| 412| I21| I22| I252",
  # stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "angina",
  diakod = " I20",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  opvar = OP_all,
  type = "com",
  name = "pci",
  opkod = " FNG",
  # stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "cabg",
  diakod = " Z951| Z955",
  opkod = " FNA| FNB| FNC| FND| FNE| FNF| FNH",
  # stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "dcm",
  diakod = " I420",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "pad",
  diakod = " I7[0-3]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "af",
  diakod = " I48",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "stroke",
  diakod = " 43[0-4]| 438| I6[0-4]| I69[0-4]",
  # stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "tia",
  diakod = " G45",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- rsdata %>%
  mutate(sos_com_stroketia = ynfac(if_else(sos_com_stroke == "Yes" | sos_com_tia == "Yes", 1, 0)))

rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "valvular",
  diakod = " I0[5-8]| I3[4-9]| Q22| Q23[0-3]| Q23[0-3]| Q23[5-9]| Z95[2-4]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "renal",
  diakod = " N1[7-9]| Z491| Z492",
  opkod = " KAS00| KAS10| KAS20| DR014| DR015| DR016| DR020| DR012| DR013| DR023| DR024| TJA33| TJA35",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "hyperkalemia",
  diakod = " E875",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "hypokalemia",
  diakod = " E876",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "dialysis",
  diakod = " Z491| Z492",
  opkod = " DR014| DR015| DR016| DR020| DR012| DR013| DR023| DR024| TJA33| TJA35",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "copd",
  diakod = " J4[0-4]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "respiratory",
  diakod = " J",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "liver",
  diakod = " B18| I85| I864| I982| K70| K710| K711| K71[3-7]| K7[2-4]| K760| K76[2-9]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "sleepapnea",
  diakod = " G473",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "dementia",
  diakod = " F0[0-4]| R54",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "depression",
  diakod = " F3[2-4]",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "com",
  name = "cancer3y",
  diakod = " C",
  stoptime = -3 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "muscoloskeletal3y",
  diakod = " M",
  stoptime = -3 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  evar = ekod_all,
  type = "com",
  name = "alcohol",
  diakod = " E244| E52| F10| G312| G621| G721| I426| K292| K70| K860| O354| P043| Q860| T51| Z502| Z714",
  ekod = " Y90| Y91",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "bleed",
  diakod = " S064| S065| S066| I850| I983| K226| K250| K252| K254| K256| K260| K262| K264| K266| K270| K272| K274| K276| K280| K284| K286| K290| K625| K661| K920| K921| K922| H431| N02| R04| R58| T810| D629",
  opkod = " DR029",
  stoptime = -5 * 365.25,
  valsclass = "fac",
  warnings = FALSE
)

# Outcomes ----------------------------------------------------------------


rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosphf",
  diakod = global_hficd,
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "counthosphf",
  diakod = global_hficd,
  noof = TRUE,
  censdate = censdtm,
  valsclass = "num",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospany",
  diakod = " ",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospcv",
  diakod = " I| J81| K761| G45| R570",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospnoncv",
  diakod = " I| J81| K761| G45| R570",
  diakodneg = TRUE,
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospstroketia",
  diakod = " I6[0-4]| G45",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospmi",
  diakod = " I21| I22",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospihd",
  diakod = " I2[0-5]",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospventfib",
  diakod = " I490| I472",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospscd",
  diakod = " I461",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosprespiratory",
  diakod = " J",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosppneumonia",
  diakod = " J09| J1[0-8]",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  opvar = OP_all,
  type = "out",
  name = "hosprenal",
  diakod = " N1[7-9]| KAS00| KAS10| KAS20| Z491| Z492",
  opkod = " DR014| DR015| DR016| DR020| DR012| DR013| DR023| DR024| TJA33| TJA35",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospcancer",
  diakod = " C",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  opvar = OP_all,
  type = "out",
  name = "hospbleed",
  diakod = " S064| S065| S066| I850| I983| K226| K250| K252| K254| K256| K260| K262| K264| K266| K270| K272| K274| K276| K280| K284| K286| K290| K625| K661| K920| K921| K922| H431| N02| R04| R58| T810| D629",
  opkod = " DR029",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosphyperkalemia",
  diakod = " E875",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosphypokalemia",
  diakod = " E876",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospsyncope",
  diakod = " R55",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hosptrauma",
  diakod = " S| T0| T1[0-4]",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- create_sosvar(
  sosdata = patreg %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  add_unique = casecontrol,
  sosdate = INDATUM,
  opvar = OP_all,
  type = "out",
  name = "hosprevasc",
  opkod = " FNG| FNA| FNB| FNC| FND| FNE| FNF| FNH",
  censdate = censdtm,
  valsclass = "fac",
  warnings = FALSE
)

outcommeta <- metaout
rm(metaout)

# Time first hf diagnosis -------------------------------------------------

hfdiag <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm),
  hfpop,
  by = "lopnr"
) %>%
  mutate(tmp_sosdtm = coalesce(UTDATUM, INDATUM)) %>%
  group_by(lopnr, shf_indexdtm) %>%
  arrange(tmp_sosdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, shf_indexdtm, tmp_sosdtm)

rsdata <- left_join(
  rsdata,
  hfdiag,
  by = c("lopnr", "shf_indexdtm")
) %>%
  mutate(
    sos_durationhf = as.numeric(shf_indexdtm - tmp_sosdtm),
    sos_durationhf = case_when(
      casecontrol %in% c("Control SwedeHF", "Control NPR") ~ NA_real_,
      is.na(sos_durationhf) | sos_durationhf < 0 ~ 0,
      TRUE ~ sos_durationhf
    )
  ) %>%
  select(-tmp_sosdtm)


# Time since last HF hospitalization --------------------------------------

hfhospsos <- patreg %>%
  filter(sos_source == "sv") %>%
  mutate(tmp_hfhospsos = stringr::str_detect(HDIA, global_hficd)) %>%
  filter(tmp_hfhospsos)

hfhosp <- inner_join(
  rsdata %>% select(lopnr, shf_indexdtm),
  hfhospsos,
  by = "lopnr"
) %>%
  mutate(tmp_sosdtm = coalesce(UTDATUM, INDATUM)) %>%
  filter(tmp_sosdtm <= shf_indexdtm) %>%
  group_by(lopnr, shf_indexdtm) %>%
  arrange(tmp_sosdtm) %>%
  slice(n()) %>%
  ungroup() %>%
  select(lopnr, shf_indexdtm, tmp_sosdtm)

rsdata <- left_join(
  rsdata,
  hfhosp,
  by = c("lopnr", "shf_indexdtm")
) %>%
  mutate(
    sos_timeprevhosphf = as.numeric(shf_indexdtm - tmp_sosdtm),
    sos_timeprevhosphf = case_when(
      casecontrol %in% c("Control SwedeHF", "Control NPR") ~ NA_real_,
      is.na(sos_timeprevhosphf) ~ NA_real_,
      TRUE ~ sos_timeprevhosphf
    )
  ) %>%
  select(-tmp_sosdtm)


# Location defined from NPR -----------------------------------------------

hfhosp <- inner_join(
  rsdata %>% filter(casecontrol %in% c("Case SwedeHF", "Case NPR")) %>% select(lopnr, shf_indexdtm, shf_indexhosptime),
  patreg %>% filter(sos_source == "sv"),
  by = "lopnr"
) %>%
  mutate(
    tmp_indexstartdtm = if_else(!is.na(shf_indexhosptime), shf_indexdtm - shf_indexhosptime, shf_indexdtm),
    tmp_locationhf = 1,
    tmp_hfhospsos = stringr::str_detect(HDIA, global_hficd)
  ) %>%
  filter(tmp_hfhospsos &
    (tmp_indexstartdtm >= INDATUM & tmp_indexstartdtm <= UTDATUM |
      shf_indexdtm >= INDATUM & shf_indexdtm <= UTDATUM)) %>%
  group_by(lopnr, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, shf_indexdtm, tmp_locationhf)

allhosp <- inner_join(
  rsdata %>% filter(casecontrol %in% c("Case SwedeHF", "Case NPR")) %>% select(lopnr, shf_indexdtm, shf_indexhosptime),
  patreg %>% filter(sos_source == "sv"),
  by = "lopnr"
) %>%
  mutate(
    tmp_indexstartdtm = if_else(!is.na(shf_indexhosptime), shf_indexdtm - shf_indexhosptime, shf_indexdtm),
    tmp_locationany = 1
  ) %>%
  filter(tmp_indexstartdtm >= INDATUM & tmp_indexstartdtm <= UTDATUM |
    shf_indexdtm >= INDATUM & shf_indexdtm <= UTDATUM) %>%
  group_by(lopnr, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, shf_indexdtm, tmp_locationany)

hospall <- full_join(hfhosp, allhosp, by = c("lopnr", "shf_indexdtm")) %>%
  mutate(sos_location = if_else(!is.na(tmp_locationhf), 1, 2)) %>%
  select(-starts_with("tmp_"))

rsdata <- left_join(
  rsdata,
  hospall,
  by = c("lopnr", "shf_indexdtm")
) %>%
  mutate(
    sos_location = factor(
      case_when(
        !is.na(sos_location) ~ sos_location,
        casecontrol %in% c("Case SwedeHF", "Case NPR") ~ 3,
        TRUE ~ NA_real_
      ),
      levels = 1:3, labels = c("HF in-patient", "Other in-patient", "Out-patient")
    ),
    sos_timeprevhosphf = if_else(sos_location == "HF in-patient", 0, sos_timeprevhosphf)
  )
