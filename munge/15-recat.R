
rsdata <- rsdata %>%
  mutate(
    shf_nyha_cat = factor(case_when(
      shf_nyha %in% c("I", "II") ~ 1,
      shf_nyha %in% c("III", "IV") ~ 2
    ), levels = 1:2, labels = c("I - II", "III-IV")),
    shf_age_cat = factor(case_when(
      is.na(shf_age) ~ NA_real_,
      shf_age < 75 ~ 1,
      shf_age >= 75 ~ 2
    ),
    levels = 1:2,
    labels = c("<75", ">=75")
    ),
    shf_ef_cat = factor(case_when(
      shf_ef == ">=50" ~ 3,
      shf_ef == "40-49" ~ 2,
      shf_ef %in% c("30-39", "<30") ~ 1
    ),
    levels = 1:3,
    labels = c("HFrEF", "HFmrEF", "HFpEF")
    ),
    shf_smoking_cat = factor(case_when(
      shf_smoking %in% c("Former", "Never") ~ 0,
      shf_smoking %in% c("Current") ~ 1
    ),
    levels = 0:1,
    labels = c("No", "Yes")
    ),
    shf_anemia = case_when(
      is.na(shf_hb) | is.na(shf_sex) ~ NA_character_,
      shf_sex == "Female" & shf_hb < 120 | shf_sex == "Male" & shf_hb < 130 ~ "Yes",
      TRUE ~ "No"
    ),
    shf_map_cat = case_when(
      shf_map <= 90 ~ "<=90",
      shf_map > 90 ~ ">90"
    ),
    shf_potassium_cat = factor(
      case_when(
        is.na(shf_potassium) ~ NA_real_,
        shf_potassium < 3.5 ~ 2,
        shf_potassium <= 5 ~ 1,
        shf_potassium > 5 ~ 3
      ),
      levels = 1:3,
      labels = c("normakalemia", "hypokalemia", "hyperkalemia")
    ),
    shf_heartrate_cat = case_when(
      shf_heartrate <= 70 ~ "<=70",
      shf_heartrate > 70 ~ ">70"
    ),
    shf_device_cat = factor(case_when(
      is.na(shf_device) ~ NA_real_,
      shf_device %in% c("CRT-P", "CRT-D", "ICD") ~ 2,
      TRUE ~ 1
    ),
    levels = 1:2,
    labels = c("No", "CRT/ICD"),
    ),
    shf_bmi_cat = factor(case_when(
      is.na(shf_bmi) ~ NA_real_,
      shf_bmi < 30 ~ 1,
      shf_bmi >= 30 ~ 2
    ),
    levels = 1:2,
    labels = c("<30", ">=30")
    ),
    shf_gfrckdepi_cat = factor(case_when(
      is.na(shf_gfrckdepi) ~ NA_real_,
      shf_gfrckdepi >= 60 ~ 1,
      shf_gfrckdepi < 60 ~ 2,
    ),
    levels = 1:2,
    labels = c(">=60", "<60")
    ),
    shf_sos_com_af = case_when(
      sos_com_af == "Yes" |
        shf_af == "Yes" |
        shf_ekg == "Atrial fibrillation" ~ "Yes",
      TRUE ~ "No"
    ),
    shf_sos_com_ihd = case_when(
      sos_com_ihd == "Yes" |
        shf_revasc == "Yes" |
        sos_com_pci == "Yes" |
        sos_com_cabg == "Yes" ~ "Yes",
      TRUE ~ "No"
    ),
    shf_sos_com_hypertension = case_when(
      shf_hypertension == "Yes" |
        sos_com_hypertension == "Yes" ~ "Yes",
      TRUE ~ "No"
    ),
    shf_sos_com_diabetes = case_when(
      shf_diabetes == "Yes" |
        sos_com_diabetes == "Yes" ~ "Yes",
      TRUE ~ "No"
    ),
    shf_sos_com_valvular = case_when(
      shf_valvedisease == "Yes" |
        sos_com_valvular == "Yes" ~ "Yes",
      TRUE ~ "No"
    ),
    shf_followuplocation_cat = if_else(shf_followuplocation %in% c("Primary care", "Other"), "Primary care/Other",
      as.character(shf_followuplocation)
    )
  )


## income
inc <- rsdata %>%
  group_by(lopnr, shf_indexyear) %>%
  slice(1) %>%
  ungroup() %>%
  group_by(shf_indexyear) %>%
  summarise(incsum = list(enframe(quantile(scb_dispincome,
    probs = c(0.33, 0.66),
    na.rm = TRUE
  )))) %>%
  unnest(cols = c(incsum)) %>%
  spread(name, value)

rsdata <- left_join(
  rsdata,
  inc,
  by = "shf_indexyear"
) %>%
  mutate(
    scb_dispincome_cat = case_when(
      scb_dispincome < `33%` ~ 1,
      scb_dispincome < `66%` ~ 2,
      scb_dispincome >= `66%` ~ 3
    ),
    scb_dispincome_cat = factor(scb_dispincome_cat, labels = c("Low", "Medium", "High"))
  ) %>%
  select(-`33%`, -`66%`)
