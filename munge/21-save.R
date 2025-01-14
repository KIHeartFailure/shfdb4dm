patregrsdata <- left_join(
  rsdata %>%
    filter(casecontrol == "Case SwedeHF") %>%
    select(lopnr) %>%
    distinct(lopnr),
  patreg,
  by = "lopnr"
)

save(file = paste0("./data/", datadate, "/patregrsdata.RData"), list = c("patregrsdata"))

# For webb only

save(
  file = "./data/rsdata_for_webb.RData",
  list = c("rsdatafull", "flow", "ncontrols", "outcommeta", "ccimeta", "deathmeta")
)


# Version number

version <- "422"

assign(paste0("rsdata", version), rsdata)
assign(paste0("rsdatafull", version), rsdatafull)

# alla hfh

assign(paste0("hfh", version), hfh)
assign(paste0("hfhfull", version), hfhfull)

dir.create(paste0("./data/v", version))

# For webb/stat report

save(
  file = paste0("./data/v", version, "/meta_statreport.RData"),
  list = c("flow", "ncontrols", "outcommeta", "ccimeta", "deathmeta")
)

# RData

save(
  file = paste0("./data/v", version, "/rsdata", version, ".RData"),
  list = c(paste0("rsdata", version))
)
save(
  file = paste0("./data/v", version, "/rsdatafull", version, ".RData"),
  list = c(paste0("rsdatafull", version))
)

save(
  file = paste0("./data/v", version, "/hfh", version, ".RData"),
  list = c(paste0("hfh", version))
)
save(
  file = paste0("./data/v", version, "/hfhfull", version, ".RData"),
  list = c(paste0("hfhfull", version))
)

# Txt

write.table(rsdata,
  file = paste0("./data/v", version, "/rsdata", version, ".txt"),
  quote = FALSE, sep = "\t", row.names = FALSE, na = ""
)

# Stata 14

write_dta(rsdata,
  path = paste0("./data/v", version, "/rsdata", version, ".dta"),
  version = 14
)
write_dta(hfh,
  path = paste0("./data/v", version, "/hfh", version, ".dta"),
  version = 14
)
