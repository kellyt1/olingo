CREATE OR REPLACE VIEW RemoveCovidIntake as

select  distinct c.case_id, c.unid as case_key, party.first_name, party.middle_name, party.last_name, party.birth_date, cp.email,
    c.modification_date,
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
    mview_covid.elr_reviewed_no,
    mview_covid.subject_id,
    mview_covid.calc_interview_jurisdiction,
    (to_char(c.modification_date, 'YYYY-MM-DD') || 'T' || to_char(c.modification_date, 'HH24:MI:SSz+0200')) as modification_date_fmt

from ids_product product
    inner join ids_case c on c.product_id = product.unid and c.status = 0
    inner join ids_participant p on p.case_id = c.unid
    inner join ids_party party on party.unid = p.party_id
    inner join ids_contactpoint cp on cp.party_id = party.unid
    inner join COVID_CASE_Q_AND_A_DENORMALIZED mview_covid on c.unid = mview_covid.case_id
    INNER JOIN COVID_POSITIVE inv ON inv.PARTICIPANT_ID = p.UNID

where product.code = 'NCOV'
AND(
    -- If intake_complete_date_time is today, we include this row
    to_date(mview_covid.intake_complete_date_time, 'mm/dd/yyyy hh:mi AM') = current_date
    OR (
    --If intake_complete_date_time is null but some other condition is met AND modification_date = today, we include this row
        c.modification_date between (current_date - interval '0 days') and (current_date + interval '1 days')
        AND(
            mview_covid.CITY IS NULL
            OR mview_covid.elr_reviewed_no IS null
            OR (mview_covid.disease_status IS NOT NULL AND mview_covid.disease_status NOT IN ('CONTACT'))
            OR mview_covid.COVID_MN_ID IS NOT NULL
            OR mview_covid.STATE <> 'MN'
            OR mview_covid.STATE IS NULL
            OR mview_covid.elr_reviewed_notes IS NOT NULL
        )
    )
)

order by c.case_id;

--this misses ones modified today
--and c.modification_date between (current_date - interval '3 days') and current_date
--need to consider the timestamp
--and c.modification_date between (current_date - interval '3 days') and (current_date + interval '1 days')

grant select on RemoveCovidIntake to covidsalesforce_user;
alter view RemoveCovidIntake owner to covidsalesforce_dms_user;