libname sos 'D:\STATISTIK\Projects\20210525_shfdb4\dm\raw-data\SOS\20240423';

proc import file="D:\STATISTIK\Projects\20210525_shfdb4\dm\data\v420\rsdata420.txt"
    out=rsdata420
    dbms=tab;
run;

data rsdata; 
set rsdata420 (keep = lopnr); 
run; 

PROC SORT DATA = rsdata NODUPKEY;
BY lopnr;
RUN;

data lm; 
set sos.ut_r_lmed_7140_2024 (keep = LopNr ATC EDATUM OTYP VERKS ANTAL forpddd antnum AR);
run; 


proc SQL;
create table lmrsdata as
   select *
   from rsdata as r inner join 
           lm as l
      on r.lopnr=l.lopnr;
quit;

libname extra "D:\STATISTIK\Projects\20210525_shfdb4\dm\data\20240423";

data extra.lm_swedehf; 
set lmrsdata; 
run; 
