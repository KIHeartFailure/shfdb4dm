# Remove patients with 0 fu for "main" dataset ----------------------------

rsdatafull <- rsdata

rsdata <- rsdata %>%
  filter(casecontrol == "Case SwedeHF") %>%
  filter(sos_outtime_death > 0) %>%
  select(-matches("(?<!scb)_dis|_admvisit", perl = TRUE))

flow <- flow %>%
  add_row(
    Criteria = "Exclude posts with end of follow-up <= index date (died in hospital)",
    `Case SwedeHF` = nrow(rsdata)
  )

flow <- flow %>%
  add_row(
    Criteria = "Unique patients",
    `Case SwedeHF` = nrow(rsdata %>% distinct(lopnr))
  )