--drop view remove_covid_case;
CREATE OR REPLACE VIEW remove_ltf_covid_case as

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
  and to_date(mview_covid.intake_complete_date_time, 'mm/dd/yyyy hh:mi AM') between current_date - interval '10 days' and current_date
  and c.modification_date between (current_date - interval '0 days') and (current_date + interval '1 days')
  and   mview_covid.covid_mn_id IS NOT NULL
  and          mview_covid.CASE_INTERVIEW_STATUS = '1'
        --Question.CASE_INTERVIEW_STATUS.Value = 1 (LTF)


;

alter view remove_ltf_covid_case owner to covidsalesforce_dms_user;
grant select on  remove_ltf_covid_case  to covidsalesforce_user;