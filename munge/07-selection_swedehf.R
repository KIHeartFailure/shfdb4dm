
flow <- c("No of posts in SwedeHF", nrow(rsdata))

# remove duplicated indexdates
rsdata <- rsdata %>%
  group_by(lopnr, shf_indexdtm) %>%
  arrange(shf_source) %>%
  slice(n()) %>%
  ungroup()

flow <- rbind(flow, c("Remove posts with duplicated index dates", nrow(rsdata)))

rsdata <- left_join(rsdata,
  ateranvpnr %>% mutate(AterPnr = 1),
  by = c("lopnr" = "LopNr")
)

rsdata <- rsdata %>%
  filter(is.na(AterPnr)) %>% # reused personr
  select(-AterPnr)

flow <- rbind(flow, c("Remove posts with reused PINs", nrow(rsdata)))

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
  filter(is.na(notinreg)) %>% # not in scb register
  select(-notinreg)

flow <- rbind(flow, c("Remove posts that are not present in SCB register", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_age >= 18 & !is.na(shf_age))

flow <- rbind(flow, c("Remove posts < 18 years", nrow(rsdata)))

rsdata <- left_join(rsdata,
  dors %>% select(lopnr, sos_deathdtm),
  by = "lopnr"
)

rsdata <- rsdata %>%
  filter((shf_indexdtm < sos_deathdtm | is.na(sos_deathdtm))) %>%
  select(-sos_deathdtm)

flow <- rbind(flow, c("Remove posts with end of follow-up <= index date (died in hospital)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_indexdtm > ymd("2000-01-01"))

flow <- rbind(flow, c("Remove posts with with index date < 2000-01-01", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_indexdtm <= global_endcohort)

flow <- rbind(flow, c(paste0("Remove posts with with index date > ", global_endcohort), nrow(rsdata)))

flow <- rbind(flow, c("Unique patients", nrow(rsdata %>% group_by(lopnr) %>% slice(1))))
