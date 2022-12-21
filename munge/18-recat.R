
rsdata <- rsdata %>%
  mutate(
    shf_sos_prevhfh1yr = ynfac(case_when(shf_location == "In-patient" & !is.na(shf_location) |
                                         !is.na(sos_timeprevhosphf) & sos_timeprevhosphf < 365 ~ 1, 
                                       TRUE ~ 0)),
    shf_sos_com_af = ynfac(case_when(
      sos_com_af == "Yes" |
        shf_af == "Yes" |
        shf_ekg == "Atrial fibrillation" ~ 1,
      TRUE ~ 0
    )),
    shf_sos_com_ihd = ynfac(case_when(
      sos_com_ihd == "Yes" |
        shf_revasc == "Yes" |
        sos_com_pci == "Yes" |
        sos_com_cabg == "Yes" ~ 1,
      TRUE ~ 0
    )),
    shf_sos_com_hypertension = ynfac(case_when(
      shf_hypertension == "Yes" |
        sos_com_hypertension == "Yes" ~ 1,
      TRUE ~ 0
    )),
    shf_sos_com_diabetes = ynfac(case_when(
      shf_diabetes == "Yes" |
        sos_com_diabetes == "Yes" ~ 1,
      TRUE ~ 0
    )),
    shf_sos_com_valvular = ynfac(case_when(
      shf_valvedisease == "Yes" |
        sos_com_valvular == "Yes" ~ 1,
      TRUE ~ 0
    )),
    sos_com_charlsonci_cat = factor(
      case_when(
        sos_com_charlsonci <= 1 ~ 1,
        sos_com_charlsonci <= 3 ~ 2,
        sos_com_charlsonci <= 7 ~ 3,
        sos_com_charlsonci >= 8 ~ 4
      ),
      levels = 1:4,
      labels = c(
        "0-1",
        "2-3",
        "4-7",
        ">=8"
      )
    ),
    sos_out_deathcvhosphf = ynfac(case_when(
      sos_out_deathcv == "Yes" |
        sos_out_hosphf == "Yes" ~ 1,
      TRUE ~ 0
    )),
    sos_out_deathhosphf = ynfac(case_when(
      sos_out_death == "Yes" |
        sos_out_hosphf == "Yes" ~ 1,
      TRUE ~ 0
    ))
  )
