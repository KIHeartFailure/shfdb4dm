# default is to use tidyverse functions
select <- dplyr::select 
rename <- dplyr::rename
filter <- dplyr::filter
mutate <- dplyr::mutate
complete <- tidyr::complete

global_endcohort <- ymd("2021-12-31")
global_endfollowup <- ymd("2021-12-31")