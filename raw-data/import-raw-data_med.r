source(here::here("setup/setup.R"))

outputpath <- paste0("./data/", datadate, "/")

lmswedehf <- haven::read_sas(paste0("./data/", datadate, "/lm_swedehf.sas7bdat"))

save(
  file = paste0(outputpath, "lmswedehf.RData"),
  list = c(
    "lmswedehf"
  )
)
