# default is to use tidyverse functions
select <- dplyr::select
rename <- dplyr::rename
filter <- dplyr::filter
mutate <- dplyr::mutate
complete <- tidyr::complete

global_endcohortrs <- ymd("2023-12-31")
global_endcohortother <- ymd("2021-12-31")
global_endfollowup <- ymd("2023-12-31")

datadate_1 <- "20220908"
datadate <- "20240423"

global_hficd <- " I110| I130| I132| I255| I420| I423| I425| I426| I427| I428| I429| I43| I50| J81| K761| R570| 414W| 425E| 425F| 425G| 425H| 425W| 425X| 428"
