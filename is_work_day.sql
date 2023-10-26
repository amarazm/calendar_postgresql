CREATE OR REPLACE FUNCTION public.is_work_day( check_dt date)
	RETURNS bool
	LANGUAGE plpgsql
AS $function$
 declare  
   l_res int;
    l_year int;
    l_month int;
     l_day int;
	begin
		 l_year := extract( year from check_dt);
		 l_month := extract( month from check_dt);
   	     l_day := extract( day from check_dt);

   	    raise notice '% % %',l_year, l_month, l_day;

select count(1)
  into l_res
  from calendar_v toc where toc.year = l_year and (
      (l_day::text = ANY(string_to_array(translate(toc."январь",'+',''), ',')) and l_month=1)
   or (l_day::text = ANY(string_to_array(translate(toc."февраль",'+',''), ',')) and l_month=2)
   or (l_day::text = ANY(string_to_array(translate(toc."март",'+',''), ',')) and l_month=3)
   or (l_day::text = ANY(string_to_array(translate(toc."апрель",'+',''), ',')) and l_month=4)
   or (l_day::text = ANY(string_to_array(translate(toc."май",'+',''), ',')) and l_month=5)
   or (l_day::text = ANY(string_to_array(translate(toc."июнь",'+',''), ',')) and l_month=6)
   or (l_day::text = ANY(string_to_array(translate(toc."июль",'+',''), ',')) and l_month=7)  
   or (l_day::text = ANY(string_to_array(translate(toc."август",'+',''), ',')) and l_month=8)   
   or (l_day::text = ANY(string_to_array(translate(toc."сентябрь",'+',''), ',')) and l_month=9)   
   or (l_day::text = ANY(string_to_array(translate(toc."октябрь",'+',''), ',')) and l_month=10)   
   or (l_day::text = ANY(string_to_array(translate(toc."ноябрь",'+',''), ',')) and l_month=11)    
   or (l_day::text = ANY(string_to_array(translate(toc."декабрь",'+',''), ',')) and l_month=12)
  );   
  
        return l_res = 0;
	END;
$function$
;
