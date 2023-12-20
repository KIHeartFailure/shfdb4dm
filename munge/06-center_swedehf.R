rsold <- left_join(rsold %>% select(-LANDSTING),
  enheteroldrs %>% select(ID, CENTRENAME, LANDSTING),
  by = c("CENTREID" = "ID")
)

rsold <- rsold %>%
  mutate(
    LANDSTING = str_remove(LANDSTING, "Landstinget i "),
    LANDSTING = str_remove(LANDSTING, "Landstinget "),
    LANDSTING = str_remove(LANDSTING, "Region "),
    LANDSTING = str_remove(LANDSTING, "s lans landsting"),
    LANDSTING = str_remove(LANDSTING, " lans landsting"),
    LANDSTING = str_remove(LANDSTING, " landsting"),
    LANDSTING = str_remove(LANDSTING, "s kommun"),
    LANDSTING = str_remove(LANDSTING, " lan"),
    LANDSTING = if_else(LANDSTING == "Jamtland", "Jamtland Harjedalen", LANDSTING),
    CENTRENAME = case_when(
      CENTRENAME == "Sahlgrenska Universitetssjukhuset / Sahlgrenska" ~ "Sahlgrenska Universitetssjukhuset - Sahlgrenska",
      CENTRENAME == "Sahlgrenska Universitetssjukhuset  / Molndal" ~ "Sahlgrenska Universitetssjukhuset - Molndal",
      CENTRENAME == "Sahlgrenska Universitetssjukhuset  / Ostra" ~ "Sahlgrenska Universitetssjukhuset - Ostra",
      CENTRENAME %in% c("Danderyd Web", "Danderyds sjukhus AB") ~ "Danderyds sjukhus",
      CENTRENAME %in% c("Karolinska Huddinge", "Karolinska Solna") ~ "Karolinska",
      CENTRENAME %in% c("Skanes universitetssjukhus  Lund", "Skanes universitetssjukhus Malmo") ~ "Skanes universitetssjukhus",
      CENTRENAME == "Halsoringen i Osby" ~ "VC Helsa Osby",
      TRUE ~ CENTRENAME
    )
  )


# lowest level. Used for VC och fristående (for hospital unit within hospital)
rsnew <- left_join(rsnew,
  enheternewrs %>% select(START, LABEL) %>% rename(UNIT = LABEL),
  by = c("HEALTH_CARE_UNIT_REFERENCE" = "START")
)

# second lowest level. Used for hospital (without hospital unit)
rsnew <- left_join(rsnew,
  enheternewrs %>% select(START, LABEL) %>% rename(D2 = LABEL),
  by = c("PARENT2" = "START")
)

# region
rsnew <- left_join(rsnew,
  enheternewrs %>% select(START, LABEL) %>% rename(regionnewrs = LABEL),
  by = c("PARENT1" = "START")
)

rsnew <- rsnew %>%
  mutate(
    regionnewrs = str_remove(regionnewrs, "Region "),
    regionnewrs = str_remove(regionnewrs, " lan"),
    regionnewrs = str_remove(regionnewrs, "sregionen"),
    regionnewrs = if_else(regionnewrs == "Jonkopings", "Jonkoping", regionnewrs),
    sjhnewrs = case_when(
      ORG_UNIT_LEVEL_NAME %in% c("Fristaende hjartmottagning", "Vardcentral") ~ UNIT,
      TRUE ~ D2
    )
  ) %>%
  select(-UNIT, -D2)
