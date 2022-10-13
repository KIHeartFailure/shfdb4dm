
# Migration ---------------------------------------------------------------

# koll <- migration %>%
#  filter(Posttyp == "Utv") %>%
#  group_by(lopnr) %>%
#  slice(2) %>%
#  ungroup() %>%
#  count()

migration <- inner_join(rsdata %>%
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

# koll <- rsdata %>%
#  mutate(shf_deathdtm = if_else(shf_deathdtm > ymd("2018-12-31"), as.Date(NA), shf_deathdtm) )  %>%
#  filter(sos_deathdtm != shf_deathdtm |
#           is.na(sos_deathdtm) != is.na(shf_deathdtm)) %>%
#  select(shf_deathdtm, sos_deathdtm) # not so big diff, use sos dtm


# # Controls ----------------------------------------------------------------
#
 hfsos <- patregrsdata %>%
   filter(DIA_all != "") %>%
   mutate(tmp_hfsos = stringr::str_detect(DIA_all, global_hficd)) %>%
   filter(tmp_hfsos)
#
# controlstososcase <-
#   inner_join(rsdata %>%
#                filter(casecontrol == "Control") %>%
#                select(lopnr, lopnrcase, shf_indexdtm, shf_indexyear),
#              hfsos,
#              by = "lopnr"
#   ) %>%
#   mutate(tmp_hfsosdtm = INDATUM - 1) %>% # set to day BEFORE HF diagnosis (otherwise will get HF diagnos at end date)
#   group_by(lopnr, shf_indexdtm) %>%
#   arrange(tmp_hfsosdtm) %>%
#   slice(1) %>%
#   ungroup() %>%
#   select(lopnr, shf_indexdtm, tmp_hfsosdtm)
#
# rsdata <- left_join(rsdata,
#                     controlstososcase,
#                     by = c("lopnr", "shf_indexdtm")
# )
#
# controlstorscase <- left_join(rsdata %>%
#                                 filter(casecontrol == "Control") %>%
#                                 select(lopnr, lopnrcase, shf_indexdtm),
#                               rsdata %>%
#                                 filter(casecontrol %in% c("Case SwedeHF", "Case Sos")) %>%
#                                 select(lopnr, lopnrcase, shf_indexdtm),
#                               by = "lopnr",
#                               suffix = c("", "_case")
# ) %>%
#   filter(!is.na(shf_indexdtm_case)) %>%
#   group_by(lopnr) %>%
#   arrange(shf_indexdtm_case) %>%
#   slice(1) %>%
#   ungroup() %>%
#   mutate(tmp_hfrsdtm = shf_indexdtm_case - 1) %>% # set to day BEFORE HF diagnosis (otherwise will get HF diagnos at end date)
#   select(lopnr, shf_indexdtm, tmp_hfrsdtm)
#
# rsdata <- left_join(rsdata,
#                     controlstorscase,
#                     by = c("lopnr", "shf_indexdtm")
# )

rsdata <- rsdata %>%
  mutate(
    censdtm = coalesce(
      pmin(sos_deathdtm, tmp_migrationdtm, na.rm = TRUE),
      global_endfollowup
    )
    # censdtm = pmin(censdtm, tmp_hfsosdtm, na.rm = TRUE),
    # censdtm = pmin(censdtm, tmp_hfrsdtm, na.rm = TRUE)
  ) %>%
  filter(censdtm >= shf_indexdtm) %>% # finns 683 poster som har sos hf diagnos, migrationsdatum, dör innan de blir controller. delete.
  select(-shf_deathdtm)


# # n controls for cases
#
#  nkontroller <- rsdata %>%
#    filter(casecontrol == "Control") %>%
#    select(lopnrcase, shf_indexdtm) %>%
#    group_by(lopnrcase, shf_indexdtm) %>%
#    mutate(ncontrols = n()) %>%
#    slice(1) %>%
#    ungroup()
#
#  rsdata <- left_join(rsdata,
#                      nkontroller,
#                      by = c("lopnr" = "lopnrcase", "shf_indexdtm")
#  ) %>%
#    mutate(
#      ncontrols = replace_na(ncontrols, 0)
#    )
#
# ncontrols <- full_join(
#    rsdata %>% filter(casecontrol == "Case") %>%
#      count(ncontrols),
#    rsdata %>%
#      filter(casecontrol == "Case") %>%
#      group_by(lopnr) %>%
#      arrange(desc(ncontrols)) %>%
#      slice(1) %>%
#      ungroup() %>%
#      count(ncontrols),
#    by = "ncontrols"
#  ) %>%
#    mutate(
#      n.y = replace_na(n.y, 0)
#    )
#
#  names(ncontrols) <- c("No controls", "Posts", "Unique patients")
