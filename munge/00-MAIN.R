
# Project specific packages, functions and settings -----------------------

source(here::here("setup/setup.R"))

# run 01-05
load(paste0("./data/", datadate, "/rawData_rs.RData"))

source("./munge/01-clean_missing_swedehf.R")
source("./munge/02-center_swedehf.R")
source("./munge/03-merge_swedehf.R")
source("./munge/04-clean_outliers_swedehf.R")
source("./munge/05-imputebmi.R")

save(file = paste0("./data/", datadate, "/rsdata_rs.RData"), list = c("rsdata"))

# run 06 Prep DORS

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rawData_sosdors.RData"))

source("./munge/06-prep_deathdata.R")

save(
  file = paste0("./data/", datadate, "/prepdors.RData"),
  list = c("dors")
)

# run 07-09 Prep NPR

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rawData_sossv.RData"))
source("./munge/07-prep_nprsvdata.R")
save(file = paste0("./data/", datadate, "/prepsvlink.RData"), list = c("svlink", "svhf"))

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rawData_sosov.RData"))
source("./munge/08-prep_nprovdata.R")
save(file = paste0("./data/", datadate, "/prepov.RData"), list = c("ov", "ovhf"))

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/prepsvlink.RData"))
load(paste0("./data/", datadate, "/prepov.RData"))
load(paste0("./data/", datadate, "/prepdors.RData"))

source("./munge/09-prep_nprdata.R")

save(file = paste0("./data/", datadate, "/patreg.RData"), list = c("patreg"))
save(file = paste0("./data/", datadate, "/hfpop.RData"), list = c("hfpop"))

# run 10-13

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rsdata_rs.RData"))
load(paste0("./data/", datadate, "/hfpop.RData"))
load(paste0("./data/", datadate, "/rawData_scb.RData"))
load(paste0("./data/", datadate, "/prepdors.RData"))

source("./munge/10-selection_swedehf.R")
source("./munge/11-controlscases_scb.R")
source("./munge/12-countryofbirth_child_scb.R")
source("./munge/13-lisa_scb.R")

save(
  file = paste0("./data/", datadate, "/rsdata_rs_scb.RData"),
  list = c("rsdata", "flow", "migration")
)

# run 14-20

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rsdata_rs_scb.RData"))
load(paste0("./data/", datadate, "/patreg.RData"))
load(paste0("./data/", datadate, "/prepdors.RData"))

source("./munge/14-endtime.R")
source("./munge/15-outcom_sos.R")
source("./munge/16-charlsoncomorbindex_sos.R")
source("./munge/17-death_sos.R")
source("./munge/18-recat.R")
source("./munge/19-niceties.R")
source("./munge/20-save.R")

save(
  file = paste0("./data/", datadate, "/rsdata.RData"),
  list = c("rsdata")
)
