
ProjectTemplate::reload.project()

load("./data/rawData_rs.RData")

# run 01-05
source("./munge/01-clean_missing_swedehf.R")
source("./munge/02-center_swedehf.R")
source("./munge/03-merge_swedehf.R")
source("./munge/04-clean_outliers_swedehf.R")
source("./munge/05-imputebmi.R")

save(file = "./data/rsdata_rs.RData", list = c("rsdata"))

# run 06-09
ProjectTemplate::reload.project()
load(file = "./data/rsdata_rs.RData")
load("./data/rawData_scb.RData")

source("./munge/06-selection_swedehf.R") # mod when get age and sos data
source("./munge/07-controlcases_scb.R") # add also check cases from sos and change time
source("./munge/08-countryofbirth_child_scb.R")
source("./munge/09-lisa_scb.R")

save(file = "./data/rsdata_rs_scb.RData", list = c("rsdata", "flow", "migration"))

ProjectTemplate::reload.project()
load("./data/rawData_sossv.RData")
load("./data/rawData_sosov.RData")

# run 10
source("./munge/10-prep_sosdata.R")

save(file = "./data/patreg.RData", list = c("patreg"))

ProjectTemplate::reload.project()
load(file = "./data/rsdata_rs_scb.RData")
load(file = "./data/patreg.RData")
load("./data/rawData_sosdors.RData")

# run 11-16
source("./munge/11-endtime.R")
source("./munge/12-outcom_sos.R")
source("./munge/13-charlsoncomorbindex_sos.R")
source("./munge/14-death_sos.R")
source("./munge/15-niceties.R")
source("./munge/16-save.R")

save(file = "./data/rsdata.RData", list = c("rsdata"))
