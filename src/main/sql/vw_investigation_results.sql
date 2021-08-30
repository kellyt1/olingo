Create or Replace view vw_investigation_results as
select max(modification_date) as modification_date, result_code, investigation_id, max(unid) as unid
from ids_investigation_result
group by investigation_id, result_code;

alter view vw_investigation_results owner to covidsalesforce_dms_user;
grant select on vw_investigation_results to covidsalesforce_user;