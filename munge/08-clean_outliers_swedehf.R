clean_outliers <- function(var, min, max) {
  var <- replace(var, var < min | var > max, NA)
}

rsdata <- rsdata %>%
  mutate(
    shf_age = clean_outliers(shf_age, 0, 120),
    shf_weight = clean_outliers(shf_weight, 10, 399),
    shf_weight_admvisit = clean_outliers(shf_weight_admvisit, 10, 399),
    shf_weight_dis = clean_outliers(shf_weight_dis, 10, 399),
    shf_height = clean_outliers(shf_height, 30, 299),
    shf_bmi = clean_outliers(shf_bmi, 10, 200),
    shf_bpdia = clean_outliers(shf_bpdia, 0, 150),
    shf_bpdia_admvisit = clean_outliers(shf_bpdia_admvisit, 0, 150),
    shf_bpdia_dis = clean_outliers(shf_bpdia_dis, 0, 150),
    shf_bpsys = ifelse(shf_bpsys < 40 | shf_bpsys > 300 | shf_bpsys < shf_bpdia, NA, shf_bpsys),
    shf_bpsys_admvisit = ifelse(shf_bpsys_admvisit < 40 | shf_bpsys_admvisit > 300 | shf_bpsys_admvisit < shf_bpdia_admvisit, NA, shf_bpsys_admvisit),
    shf_bpsys_dis = ifelse(shf_bpsys_dis < 40 | shf_bpsys_dis > 300 | shf_bpsys_dis < shf_bpdia_dis, NA, shf_bpsys_dis),
    shf_map = clean_outliers(shf_map, 40, 250),
    shf_heartrate = clean_outliers(shf_heartrate, 20, 300),
    shf_heartrate_admvisit = clean_outliers(shf_heartrate_admvisit, 20, 300),
    shf_heartrate_dis = clean_outliers(shf_heartrate_dis, 20, 300),
    shf_hb = clean_outliers(shf_hb, 20, 250),
    shf_hb_admvisit = clean_outliers(shf_hb_admvisit, 20, 250),
    shf_hb_dis = clean_outliers(shf_hb_dis, 20, 250),
    shf_potassium = clean_outliers(shf_potassium, 1.5, 9.9),
    shf_potassium_admvisit = clean_outliers(shf_potassium_admvisit, 1.5, 9.9),
    shf_potassium_dis = clean_outliers(shf_potassium_dis, 1.5, 9.9),
    shf_sodium = clean_outliers(shf_sodium, 100, 200),
    shf_sodium_admvisit = clean_outliers(shf_sodium_admvisit, 100, 200),
    shf_sodium_dis = clean_outliers(shf_sodium_dis, 100, 200),
    shf_crea = clean_outliers(shf_crea, 40, 2000),
    shf_crea_admvisit = clean_outliers(shf_crea_admvisit, 40, 2000),
    shf_crea_dis = clean_outliers(shf_crea_dis, 40, 2000),
    # shf_gfrckdepi derived from other vars with limits,
    shf_ntprobnp = clean_outliers(shf_ntprobnp, 5, 288888),
    shf_ntprobnp_admvisit = clean_outliers(shf_ntprobnp_admvisit, 5, 288888),
    shf_ntprobnp_dis = clean_outliers(shf_ntprobnp_dis, 5, 288888),
    shf_transferrin = clean_outliers(shf_transferrin, 1, 100),
    shf_ferritin = clean_outliers(shf_ferritin, 1, 1000),
    shf_qrs = clean_outliers(shf_qrs, 50, 250)
  )
