
# Cause of death ----------------------------------------------------------

rsdata <- rsdata %>%
  mutate(
    sos_out_death = ynfac(ifelse(censdtm == sos_deathdtm & !is.na(sos_deathdtm), 1, 0)),
    sos_outtime_death = as.numeric(censdtm - shf_indexdtm)
  )

rsdata <- create_deathvar(
  cohortdata = rsdata,
  indexdate = shf_indexdtm,
  censdate = censdtm,
  deathdate = sos_deathdtm,
  name = "cv",
  orsakvar = sos_deathcause,
  orsakkod = "I|J81|K761|R570|G45",
  valsclass = "fac",
  warnings = FALSE
)
rsdata <- rsdata %>%
  mutate(
    sos_out_deathnoncv =
      ynfac(if_else(sos_out_death == "No" | sos_out_deathcv == "Yes", 0, 1))
  )

rsdata <- create_deathvar(
  cohortdata = rsdata,
  indexdate = shf_indexdtm,
  censdate = censdtm,
  deathdate = sos_deathdtm,
  name = "scd",
  orsakvar = sos_deathcause,
  orsakkod = "I461",
  valsclass = "fac",
  warnings = FALSE
)


deathmeta <- metaout
rm(metaout)

rsdata <- rsdata %>%
  mutate(
    sos_out_hospdeathscd = ifelse(sos_out_deathscd == "Yes" | sos_out_hospscd == "Yes", 1, 0),
    sos_out_hospdeathscd = ynfac(sos_out_hospdeathscd)
  ) %>%
  select(-sos_out_deathscd, -sos_out_hospscd, -sos_deathdtm)
