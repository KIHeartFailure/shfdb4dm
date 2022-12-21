
# Migration ---------------------------------------------------------------

migration <- inner_join(
  rsdata %>%
    select(lopnr, shf_indexdtm),
  migration %>%
    filter(Posttyp == "Utv"),
  by = c("lopnr" = "LopNr")
) %>%
  mutate(tmp_migrationdtm = ymd(Datum)) %>%
  filter(
    tmp_migrationdtm > shf_indexdtm,
    tmp_migrationdtm <= global_endfollowup
  ) %>%
  group_by(lopnr, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, shf_indexdtm, tmp_migrationdtm)

rsdata <- left_join(rsdata,
  migration,
  by = c("lopnr", "shf_indexdtm")
)


# Death -------------------------------------------------------------------

rsdata <- left_join(rsdata,
  dors %>% select(lopnr, sos_deathcause, sos_deathdtm),
  by = "lopnr"
)

# Controls ----------------------------------------------------------------

hfsos <- patreg %>%
  filter(DIA_all != "") %>%
  mutate(tmp_hfsos = stringr::str_detect(DIA_all, global_hficd)) %>%
  filter(tmp_hfsos)

controlstososcase <-
  inner_join(
    rsdata %>%
      filter(casecontrol %in% c("Control SwedeHF", "Control NPR")) %>%
      select(lopnr, lopnrcase, casecontrol, shf_indexdtm),
    hfsos,
    by = "lopnr"
  ) %>%
  mutate(tmp_hfsosdtm = INDATUM - 1) %>% # set to day BEFORE HF diagnosis (otherwise will get HF diagnos at end date)
  group_by(lopnr, shf_indexdtm, casecontrol) %>%
  arrange(tmp_hfsosdtm) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, casecontrol, shf_indexdtm, tmp_hfsosdtm)

# sos fall är unika individer

rsdata <- left_join(
  rsdata,
  controlstososcase,
  by = c("lopnr", "shf_indexdtm", "casecontrol")
)

rscaseunik <- rsdata %>%
  filter(casecontrol == "Case SwedeHF") %>%
  select(lopnr, lopnrcase, shf_indexdtm) %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(1) %>%
  ungroup()

controlstorscase <- left_join(
  rsdata %>%
    filter(casecontrol %in% c("Control SwedeHF", "Control NPR")) %>%
    select(lopnr, lopnrcase, casecontrol, shf_indexdtm),
  rscaseunik,
  by = "lopnr",
  suffix = c("", "_case")
) %>%
  filter(!is.na(shf_indexdtm_case)) %>%
  group_by(lopnr, shf_indexdtm, casecontrol) %>%
  arrange(shf_indexdtm_case) %>%
  slice(1) %>%
  ungroup() %>%
  mutate(tmp_hfrsdtm = shf_indexdtm_case - 1) %>% # set to day BEFORE HF diagnosis (otherwise will get HF diagnosis at end date)
  select(lopnr, casecontrol, shf_indexdtm, tmp_hfrsdtm)

rsdata <- left_join(
  rsdata,
  controlstorscase,
  by = c("lopnr", "shf_indexdtm", "casecontrol")
)

rsdata <- rsdata %>%
  mutate(
    censdtm = coalesce(
      pmin(sos_deathdtm, tmp_migrationdtm, na.rm = TRUE),
      global_endfollowup
    ),
    censdtm = pmin(censdtm, tmp_hfsosdtm, na.rm = TRUE),
    censdtm = pmin(censdtm, tmp_hfrsdtm, na.rm = TRUE)
  ) %>%
  filter(censdtm >= shf_indexdtm) %>% # finns XXX poster som har sos hf diagnos, migrationsdatum, dör innan de blir controller/case. delete.
  select(-shf_deathdtm)

# n controls for cases

nkontroller <- rsdata %>%
  filter(casecontrol %in% c("Control SwedeHF", "Control NPR")) %>%
  select(lopnrcase, casecontrol, shf_indexdtm) %>%
  group_by(lopnrcase, casecontrol, shf_indexdtm) %>%
  mutate(
    ncontrols = n(),
    tmppop = str_replace(casecontrol, "Control ", "")
  ) %>%
  slice(1) %>%
  ungroup() %>%
  select(-casecontrol)

rsdata <- left_join(
  rsdata %>%
    mutate(tmppop = str_replace(casecontrol, "Control |Case ", "")),
  nkontroller,
  by = c("lopnr" = "lopnrcase", "shf_indexdtm", "tmppop")
) %>%
  mutate(
    ncontrols = replace_na(ncontrols, 0)
  )

ncontrols <- full_join(
  rsdata %>%
    filter(casecontrol %in% c("Case SwedeHF", "Case NPR")) %>%
    group_by(casecontrol) %>%
    count(ncontrols) %>%
    ungroup(),
  rsdata %>%
    filter(casecontrol %in% c("Case SwedeHF", "Case NPR")) %>%
    group_by(lopnr, casecontrol) %>%
    arrange(desc(ncontrols)) %>%
    slice(1) %>%
    ungroup() %>%
    group_by(casecontrol) %>%
    count(ncontrols) %>%
    ungroup(),
  by = c("ncontrols", "casecontrol")
) %>%
  mutate(
    n.y = replace_na(n.y, 0)
  )

names(ncontrols) <- c("Population", "No controls", "Posts", "Unique patients")
