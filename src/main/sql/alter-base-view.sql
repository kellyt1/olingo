drop view covid_case;
CREATE OR REPLACE VIEW covid_case as

select c.case_id, c.unid as case_key, party.first_name, party.middle_name, party.last_name, party.birth_date, cp.email,

mview_covid.street_1,
mview_covid.city,
mview_covid.state,
mview_covid.zip,
mview_covid.county,
mview_covid.email_address,
mview_covid.telephone_home,
mview_covid.telephone_cell,
mview_covid.telephone_work,
mview_covid.covid_mn_id,
mview_covid.intake_complete_date_time,
mview_covid.specimen_date,
mview_covid.preferred_language,
mview_covid.language_interview,
mview_covid.interview_jurisdiction,
mview_covid.subregion_based_jurisdiction,
mview_covid.tribe_name,
mview_covid.living_reservation,
mview_covid.reservation_name,
mview_covid.case_interview_status,
mview_covid.calc_interview_jurisdiction,
c.modification_date,
mview_covid.subject_id,
(to_char(c.modification_date, 'YYYY-MM-DD') || 'T' || to_char(c.modification_date, 'HH24:MI:SSz+0200')) as modification_date_fmt,
       mview_covid.latest_call_attempt_date_time
from ids_product product
     inner join ids_case c on c.product_id = product.unid and c.status = 0
     inner join ids_participant p on p.case_id = c.unid
     inner join ids_party party on party.unid = p.party_id
     inner join ids_contactpoint cp on cp.party_id = party.unid
     inner join COVID_CASE_Q_AND_A_DENORMALIZED mview_covid on c.unid = mview_covid.case_id
where product.code = 'NCOV'
and to_date(mview_covid.intake_complete_date_time, 'mm/dd/yyyy hh:mi AM') between current_date - interval '6 days' and current_date

and mview_covid.case_interview_status is null
and mview_covid.covid_mn_id is not null
and mview_covid.intake_complete_date_time is not null
and mview_covid.covid_status = '1'
and mview_covid.interview_jurisdiction is not null
and (mview_covid.living_setting is null or mview_covid.living_setting in ('1', '5', '7', '8', '10', '11', '12'))
and (mview_covid.no_working_phone is null or mview_covid.no_working_phone = '2')
and mview_covid.state = 'MN'
and mview_covid.is_person_dead is null
and mview_covid.date_of_death is null
and (mview_covid.covid_still_hosp is null or mview_covid.covid_still_hosp <> '1');

alter view covid_case owner to covidsalesforce_dms_user;
grant select on  Covid_case  to covidsalesforce_user;
