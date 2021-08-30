--drop view remove_covid_case;
CREATE OR REPLACE VIEW remove_covid_case as

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
  and(
            mview_covid.interview_jurisdiction in ('LPH', 'TPH', 'UNI', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11')
        --INTERVIEW_JURISDICTION = LPH, TPH, UNI, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11
        OR
            mview_covid.LIVING_SETTING IS NOT NULL AND mview_covid.LIVING_SETTING not in ('1','5','7','8','10','11','12')
        --(Question.LIVING_SETTING.Value <> NULL AND Question.LIVING_SETTING.Value <> 1,5,7,8,10,11,12)
        OR
            mview_covid.IS_PERSON_DEAD = 'YES'
        --Question.IS_PERSON_DEAD.Value = YES
        OR
            mview_covid.DATE_OF_DEATH IS NOT NULL
        -- Question.DATE_OF_DEATH.Value <> NULL
        OR
            mview_covid.covid_still_hosp = '1'
        -- Output.eoCOVIDStillHosp = 1
        OR
            mview_covid.COVID_STATUS != '1'
        -- Question.COVID_STATUS.Value <> 1
        OR
            mview_covid.CASE_INTERVIEW_STATUS IS NOT NULL
        --Question.CASE_INTERVIEW_STATUS.Value <> NULL
        OR
            (mview_covid.NO_WORKING_PHONE != '2' AND mview_covid.NO_WORKING_PHONE IS NOT NULL))
        --(Question.NO_WORKING_PHONE.Value <> 2 AND Question.NO_WORKING_PHONE.Value <> NULL)

;

alter view remove_covid_case owner to covidsalesforce_dms_user;
grant select on  remove_covid_case  to covidsalesforce_user;