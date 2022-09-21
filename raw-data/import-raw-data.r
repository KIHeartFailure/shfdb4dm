
ProjectTemplate::reload.project()

# Import data from UCR ----------------------------------------------------

ucrpath <- "./raw-data/UCR/20220908/"

# oldvals <- read_sas(paste0(ucrpath, "dat183_formats_old.sas7bdat"))

rsnew <- read_sasdata(path = ucrpath, filename = "lb_lev_rikssvikt_export")
rsold <- read_sasdata(path = ucrpath, filename = "lb_lev_rikssvikt_bas_ej_migr")

## corr with migrated, age and location
rsnewadd <- read_sasdata(path = ucrpath, filename = "dat776_export_tillagg2")

rsnew <- left_join(rsnew %>%
                     select(-MIGRATED),
                   rsnewadd %>% rename(MIGRATED = MIGRATED_NY),
                   by = c("patientreference_pseudonymiserad", "d_DATE_FOR_ADMISSION", "TYPE")
) %>% 
  filter(!is.na(d_age_at_VISIT_DATE))

# oldall <- read_sas("./raw-data/UCR/lb_ucr_lev_old_dat183_bas_alla.sas7bdat")

enheternewrs <- read_sasdata(path = ucrpath, filename = "rikssvikt_ng_formats")

enheteroldrs <- read.xlsx("./raw-data/UCR/RiksSvikt_center.xlsx")
enheteroldrs <- clean_data(enheteroldrs)

# Store as RData in /data folder ------------------------------------------

save(file = "./data/rawData_rs.RData", list = c(
  "rsnew",
  "rsold", 
  "enheternewrs", 
  "enheteroldrs"
))


# Import data from SCB ----------------------------------------------------

scbpath <- "./raw-data/SCB/20220908/"

fall_ej_i_register <- read_sasdata(path = scbpath, filename = "lb_lev_fall_ej_i_register")
fall_utan_kontroller_1 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_utan_kontroller_1")
fall_utan_kontroller_2 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_utan_kontroller_2")
fall_och_kontroller_1 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_och_kontroller_1")
fall_och_kontroller_2 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_och_kontroller_2")
lisa <- read_sasdata(path = scbpath, filename = "lb_lev_lisa", years = 1999:2020)
ateranvpnr <- read_sasdata(path = scbpath, filename = "lb_lev_ateranvpnr")
barnadop <- read_sasdata(path = scbpath, filename = "lb_lev_barnadop")
barnbio <- read_sasdata(path = scbpath, filename = "lb_lev_barnbio")
demo <- read_sasdata(path = scbpath, filename = "lb_lev_demografi")
migration <- read_sasdata(path = scbpath, filename = "lb_lev_migrationer")

# Store as RData in /data folder ------------------------------------------

save(file = "./data/rawData_scb.RData", list = c(
  "ateranvpnr",
  "barnadop",
  "barnbio",
  "demo",
  "fall_ej_i_register",
  "fall_och_kontroller_1",
  "fall_och_kontroller_2",
  "fall_utan_kontroller_1",
  "fall_utan_kontroller_2",
  "lisa",
  "migration"
))
