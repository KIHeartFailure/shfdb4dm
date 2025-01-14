# Prepare sos files -------------------------------------------------------

# dors
source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/rawData_sosdors.RData"))
source("./munge/01-prep_deathdata.R")
save(file = paste0("./data/", datadate, "/prepdors.RData"), list = c("dors"))

# sv
source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/rawData_sossv.RData"))
source("./munge/02-prep_nprsvdata.R")
save(file = paste0("./data/", datadate, "/prepsvlink.RData"), list = c("svlink"))

# ov
source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/rawData_sosov.RData"))
source("./munge/03-prep_nprovdata.R")
save(file = paste0("./data/", datadate, "/prepov.RData"), list = c("ov"))

# all
source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/prepsvlink.RData"))
load(paste0("./data/", datadate, "/prepov.RData"))
load(paste0("./data/", datadate, "/prepdors.RData"))

source("./munge/04-prep_nprdata.R")
save(file = paste0("./data/", datadate, "/patreg.RData"), list = c("patreg"))
save(file = paste0("./data/", datadate, "/hfpop.RData"), list = c("hfpop"))

# Prepare SwedeHF ---------------------------------------------------------

source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/rawData_rs.RData"))

source("./munge/05-clean_missing_swedehf.R")
source("./munge/06-center_swedehf.R")
source("./munge/07-merge_swedehf.R")
source("./munge/08-clean_outliers_swedehf.R")

save(file = paste0("./data/", datadate, "/rsdata_rs.RData"), list = c("rsdata", "flow"))

# Prepare SCB -------------------------------------------------------------

source(here::here("setup/setup.R"))
load(paste0("./data/", datadate, "/rsdata_rs.RData"))
load(paste0("./data/", datadate, "/hfpop.RData"))
load(paste0("./data/", datadate, "/rawData_scb.RData"))
load(paste0("./data/", datadate, "/prepdors.RData"))

source("./munge/09-controlscases_scb.R")
source("./munge/10-endtime.R")
source("./munge/11-selection-1.R")
source("./munge/12-countryofbirth_child_scb.R")
source("./munge/13-lisa_scb.R")

save(
  file = paste0("./data/", datadate, "/rsdata_rs_scb.RData"),
  list = c("rsdata", "flow", "ncontrols")
)

# Add on comorbs and outcomes ---------------------------------------------

source(here::here("setup/setup.R"))
gc()
load(paste0("./data/", datadate, "/rsdata_rs_scb.RData"))
load(paste0("./data/", datadate, "/patreg.RData"))
load(paste0("./data/", datadate, "/hfpop.RData"))

source("./munge/14-outcom_sos.R")
source("./munge/15-charlsoncomorbindex_sos.R")
source("./munge/16-death_sos.R")

save(
  file = paste0("./data/", datadate, "/rsdata_rs_scb_sos.RData"),
  list = c("rsdata", "flow", "ncontrols", "outcommeta", "ccimeta", "deathmeta")
)

# Final touches -----------------------------------------------------------
source(here::here("setup/setup.R"))
gc()
load(paste0("./data/", datadate, "/rsdata_rs_scb_sos.RData"))
load(paste0("./data/", datadate, "/patreg.RData"))

source("./munge/17-recat.R")
source("./munge/18-niceties.R")
source("./munge/19-selection-2.R")
source("./munge/20-create-hfh_sos.R")
source("./munge/21-save.R")

save(
  file = paste0("./data/", datadate, "/rsdata.RData"),
  list = c("rsdata")
)
