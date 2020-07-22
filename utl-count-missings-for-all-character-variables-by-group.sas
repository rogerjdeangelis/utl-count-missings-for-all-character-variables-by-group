Count missings for all character variables by group

github
https://tinyurl.com/y2tleabp
https://github.com/rogerjdeangelis/utl-count-missings-for-all-character-variables-by-group

Problem:
   Count missings by country for all character variables in sashelp.cars


sas forum
https://tinyurl.com/y5jn88po
https://communities.sas.com/t5/SAS-Programming/count-missings-for-all-character-variable/m-p/671471

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data have;
  set sashelp.prdsale;
  if uniform(12134)<.10 then COUNTRY  = ' ' ;
  if uniform(12134)<.20 then REGION   = ' ' ;
  if uniform(12134)<.35 then DIVISION = ' ' ;
  if uniform(12134)<.25 then PRODTYPE = ' ' ;
  if uniform(12134)<.25 then PRODUCT  = ' ' ;
run;quit;

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

 WORK.WANT total obs=4

             COUNTRY_    REGION_    DIVISION_    PRODTYPE_    PRODUCT_
  COUNTRY       mis        mis         mis          mis          mis

                148         29          54           47           38
  CANADA          0         76         161          118           93
  GERMANY         0         90         138          111           87
  U.S.A.          0         82         166          101          114


*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

%array(vs,values=%utl_varlist(have,keep=_character_));

proc sql;
  create
    table want as
  select
    country
    ,%do_over(vs,phrase=%str(
        sum(?='') as ?_mis),between=comma)
  from
    have
  group
    by country
;quit;


