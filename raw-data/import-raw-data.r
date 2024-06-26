source(here::here("setup/setup.R"))

outputpath <- paste0("./data/", datadate, "/")

# Import data from UCR ----------------------------------------------------

ucrpath <- paste0("./raw-data/UCR/", datadate_1, "/")

rsold <- read_sasdata(path = ucrpath, filename = "lb_lev_rikssvikt_bas_ej_migr")

enheteroldrs <- read.xlsx("./raw-data/UCR/RiksSvikt_center.xlsx")
enheteroldrs <- clean_data(enheteroldrs)

ucrpath <- paste0("./raw-data/UCR/", datadate, "/")

rsnew <- read_sasdata(path = ucrpath, filename = "lb_lev_ucr")

enheternewrs <- read_sasdata(path = ucrpath, filename = "rikssvikt_formats")
enheternewrs <- enheternewrs %>% filter(FMTNAME == "RSV_ORG_UNIT_NAME")

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

# Import data from SCB ----------------------------------------------------

source(here::here("setup/setup.R"))
scbpath <- paste0("./raw-data/SCB/", datadate_1, "/")
outputpath <- paste0("./data/", datadate, "/")

fall_ej_i_register <- read_sasdata(path = scbpath, filename = "lb_lev_fall_ej_i_register")
fall_utan_kontroller_1 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_utan_kontroller_1")
fall_utan_kontroller_2 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_utan_kontroller_2")
fall_och_kontroller_1 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_och_kontroller_1")
fall_och_kontroller_2 <- read_sasdata(path = scbpath, filename = "lb_lev_fall_och_kontroller_2")

scbpath <- paste0("./raw-data/SCB/", datadate, "/Leverans/")
lisa <- read_sasdata(path = scbpath, filename = "lb_lev_lisa", years = 1999:2022)
postnr <- read_sasdata(path = scbpath, filename = "lb_lev_postnr", years = 1999:2023)
ateranvpnr <- read_sasdata(path = scbpath, filename = "lb_lev_ateranvpnr")
barnadop <- read_sasdata(path = scbpath, filename = "lb_lev_barnadop")
barnbio <- read_sasdata(path = scbpath, filename = "lb_lev_barnbio")
demo <- read_sasdata(path = scbpath, filename = "lb_lev_grunduppgifter")
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
    "migration",
    "postnr"
  )
)

# Import data from SOS ----------------------------------------------------
source(here::here("setup/setup.R"))
sospath <- paste0("./raw-data/SOS/", datadate, "/")
outputpath <- paste0("./data/", datadate, "/")

dors <- read_sasdata(path = sospath, filename = "ut_r_dors_7140_2024", clean = FALSE)
# dorsavi <- read_sasdata(path = sospath, filename = "ut_r_dors_avi_7140_2024", clean = FALSE)
# dorsh <- read_sasdata(path = sospath, filename = "ut_r_dors_h_7140_2024", clean = FALSE)

# Store as RData in /data folder ------------------------------------------

save(
  file = paste0(outputpath, "rawData_sosdors.RData"),
  list = c(
    "dors"
  )
)

source(here::here("setup/setup.R"))
sospath <- paste0("./raw-data/SOS/", datadate, "/")
outputpath <- paste0("./data/", datadate, "/")

sv <- read_sasdata(path = sospath, filename = "ut_r_par_sv_7140_2024", clean = FALSE)
ov <- read_sasdata(path = sospath, filename = "ut_r_par_ov_7140_2024", clean = FALSE)

# Store as RData in /data folder ------------------------------------------

save(
  file = paste0(outputpath, "rawData_sossv.RData"),
  list = c(
    "sv"
  )
)
save(
  file = paste0(outputpath, "rawData_sosov.RData"),
  list = c(
    "ov"
  )
)
