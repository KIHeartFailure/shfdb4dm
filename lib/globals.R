# default is to use tidyverse functions
select <- dplyr::select
rename <- dplyr::rename
filter <- dplyr::filter
mutate <- dplyr::mutate
complete <- tidyr::complete

global_endcohort <- ymd("2021-12-31")
global_endfollowup <- ymd("2021-12-31")

datadate <- "20220908"

global_hficd <- " I110| I130| I132| I255| I420| I423| I425| I426| I427| I428| I429| I43| I50| J81| K761| R57| 414W| 425E| 425F| 425G| 425H| 425W| 425X| 428"
