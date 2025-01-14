# Further selection -------------------------------------------------------

flow[1, 3:5] <- rsdata %>%
  filter(casecontrol != "Case SwedeHF") %>%
  count(casecontrol) %>%
  pivot_wider(names_from = casecontrol, values_from = n)

rsdata <- rsdata %>%
  filter(shf_indexdtm >= ymd("2000-01-01"))

flow <- bind_rows(flow, tibble(Criteria = "Exclude posts with index date < 2000-01-01", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

rsdata <- rsdata %>%
  filter(casecontrol == "Case SwedeHF" & shf_indexdtm <= global_endcohortrs | casecontrol != "Case SwedeHF" & shf_indexdtm <= global_endcohortother)

flow <- bind_rows(flow, tibble(Criteria = paste0("Exclude posts with index date > ", global_endcohortrs, " (SwedeHF)/", global_endcohortother, " (NPR HF, Controls)"), rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

rsdata <- rsdata %>%
  filter(shf_age >= 18 & !is.na(shf_age))

flow <- bind_rows(flow, tibble(Criteria = "Exclude posts < 18 years", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

ejireg <- fall_ej_i_register %>%
  mutate(indexdtm = ymd(datum)) %>%
  select(lopnr, indexdtm) %>%
  group_by(lopnr, indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  mutate(notinreg = 1)

rsdata <- left_join(rsdata,
  ejireg,
  by = c("lopnr", "shf_indexdtm" = "indexdtm")
)

rsdata <- rsdata %>%
  filter(is.na(notinreg) | casecontrol %in% c("Control SwedeHF", "Control NPR")) %>% # not in scb register
  select(-notinreg)

flow <- bind_rows(flow, tibble(Criteria = "Exclude posts that are not present in SCB register", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

rsdata <- left_join(rsdata,
  ateranvpnr %>% mutate(AterPnr = 1),
  by = c("lopnr" = "LopNr")
)

rsdata <- rsdata %>%
  filter(is.na(AterPnr)) %>% # reused personr
  select(-AterPnr)

flow <- bind_rows(flow, tibble(Criteria = "Exclude posts with reused PINs", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

rsdata <- rsdata %>%
  filter(censdtm >= shf_indexdtm) # finns XXX poster som har sos hf diagnos, migrationsdatum, dör innan de blir controller/case. delete.

flow <- bind_rows(flow, tibble(Criteria = "Exclude posts end of follow-up < index", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

# Remove controls without cases -------------------------------------------

rsdata <- left_join(
  rsdata %>% select(lopnrcase) %>% distinct(lopnrcase),
  rsdata,
  by = "lopnrcase"
)

flow <- bind_rows(flow, tibble(Criteria = "Exclude controls without cases", rsdata %>% count(casecontrol) %>% pivot_wider(names_from = casecontrol, values_from = n)))

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
