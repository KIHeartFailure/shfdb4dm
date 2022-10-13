
# run 01-05

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rawData_rs.RData"))

source("./munge/01-clean_missing_swedehf.R")
source("./munge/02-center_swedehf.R")
source("./munge/03-merge_swedehf.R")
source("./munge/04-clean_outliers_swedehf.R")
source("./munge/05-imputebmi.R")

save(file = paste0("./data/", datadate, "/rsdata_rs.RData"), list = c("rsdata"))

# run 06-10

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rsdata_rs.RData"))
load(paste0("./data/", datadate, "./rawData_scb.RData"))
load(paste0("./data/", datadate, "./rawData_sosdors.RData"))

source("./munge/06-prep_deathdata.R")
source("./munge/07-selection_swedehf.R")
#source("./munge/08-controlscases_scb.R") # add also check cases from sos and change time. Do this later
rsdata <- rsdata %>% mutate(casecontrol = "Case SwedeHF")
source("./munge/09-countryofbirth_child_scb.R")
source("./munge/10-lisa_scb.R")

save(file = paste0("./data/", datadate, "/rsdata_rs_scb.RData"), 
     list = c("rsdata", "flow", "migration", "dors"))

# run 11

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rawData_sosov.RData"))
load(paste0("./data/", datadate, "/rawData_sossv.RData"))
load(paste0("./data/", datadate, "/rsdata_rs_scb.RData"))

source("./munge/11-prep_nprdata.R")

save(file = paste0("./data/", datadate, "/patreg.RData"), list = c("patreg"))
save(file = paste0("./data/", datadate, "/patregrsdata.RData"), list = c("patregrsdata"))

# run 12-18

ProjectTemplate::reload.project()
load(paste0("./data/", datadate, "/rsdata_rs_scb.RData"))
load(paste0("./data/", datadate, "/patregrsdata.RData"))

source("./munge/12-endtime.R")
source("./munge/13-outcom_sos.R")
source("./munge/14-charlsoncomorbindex_sos.R")
source("./munge/15-death_sos.R")
source("./munge/16-recat.R")
source("./munge/17-niceties.R")
source("./munge/18-save.R")

save(file = paste0("./data/", datadate, "/rsdata.RData"), 
            list = c("rsdata"))
