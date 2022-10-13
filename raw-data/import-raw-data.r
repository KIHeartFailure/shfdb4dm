
ProjectTemplate::reload.project()

outputpath <- paste0("./data/", datadate, "/")

# Import data from UCR ----------------------------------------------------

ucrpath <- paste0("./raw-data/UCR/", datadate, "/")

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

save(
  file = paste0(outputpath, "rawData_rs.RData"),
  list = c(
    "rsnew",
    "rsold",
    "enheternewrs",
    "enheteroldrs"
  )
)

rm(list = c(
  "rsnew",
  "rsnewadd",
  "rsold",
  "enheternewrs",
  "enheteroldrs"
))

# Import data from SCB ----------------------------------------------------

scbpath <- paste0("./raw-data/SCB/", datadate, "/")

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

save(
  file = paste0(outputpath, "rawData_scb.RData"),
  list = c(
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
  )
)

rm(list = c(
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

# Import data from SOS ----------------------------------------------------

sospath <- paste0("./raw-data/SOS/", datadate, "/")

dors <- read_sasdata(path = sospath, filename = "ut_r_dors_36421_2021", clean = FALSE)
#dorsar <- read_sasdata(path = sospath, filename = "ut_r_dors_ar_36421_2021", clean = FALSE)
#dorsavi <- read_sasdata(path = sospath, filename = "ut_r_dors_avi_36421_2021", clean = FALSE)
#dorsh <- read_sasdata(path = sospath, filename = "ut_r_dors_h_36421_2021", clean = FALSE)

# Store as RData in /data folder ------------------------------------------

save(
  file = paste0(outputpath, "rawData_sosdors.RData"),
  list = c(
    "dors"
  )
)

rm(list = c(
  "dors"#,
  #"dorsar",
  #"dorsavi",
  #"dorsh"
))

sv <- read_sasdata(path = sospath, filename = "ut_r_par_sv_36421_2021", clean = FALSE)
ov <- read_sasdata(path = sospath, filename = "ut_r_par_ov_36421_2021", clean = FALSE)

# Store as RData in /data folder ------------------------------------------

save(
  file = paste0(outputpath, "rawData_sossv.RData"),
  list = c(
    "sv")
)
save(
  file = paste0(outputpath, "rawData_sosov.RData"),
  list = c(
    "ov"
  )
)
