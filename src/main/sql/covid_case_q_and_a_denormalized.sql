DROP MATERIALIZED VIEW covidsalesforce_owner.COVID_CASE_Q_AND_A_DENORMALIZED CASCADE;
CREATE MATERIALIZED VIEW covidsalesforce_owner.COVID_CASE_Q_AND_A_DENORMALIZED AS
                             SELECT
                          "q"."case_id"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'STREET_1')) THEN "a"."value" ELSE null END)) "street_1"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'CITY')) THEN "a"."value" ELSE null END)) "city"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'STATE')) THEN "a"."value" ELSE null END)) "state"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'ZIP')) THEN "a"."value" ELSE null END)) "zip"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'COUNTY')) THEN "a"."value" ELSE null END)) "county"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'EMAIL_ADDRESS')) THEN "a"."value" ELSE null END)) "email_address"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'TELEPHONE_HOME')) THEN "a"."value" ELSE null END)) "telephone_home"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'TELEPHONE_CELL')) THEN "a"."value" ELSE null END)) "telephone_cell"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'TELEPHONE_WORK')) THEN "a"."value" ELSE null END)) "telephone_work"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'NCOV_ADMINISTRATIVE') AND ("a"."question_id" = 'COVID_MN_ID')) THEN "a"."value" ELSE null END)) "covid_mn_id"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'NCOV_ADMINISTRATIVE') AND ("a"."question_id" = 'INTAKE_COMPLETE_DATE_TIME')) THEN "a"."value" ELSE null END)) "intake_complete_date_time"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'CLINICAL') AND ("a"."question_id" = 'SPECIMEN_DATE')) THEN "a"."value" ELSE null END)) "specimen_date"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'PREFERRED_LANGUAGE')) THEN "a"."value" ELSE null END)) "preferred_language"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'LANGUAGE_INTERVIEW')) THEN "a"."value" ELSE null END)) "language_interview"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'NCOV_CALLS') AND ("a"."question_id" = 'INTERVIEW_JURISDICTION')) THEN "a"."value" ELSE null END)) "interview_jurisdiction"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'NCOV_ADMINISTRATIVE') AND ("a"."question_id" = 'SUBREGION_BASED_JURISDICTION')) THEN "a"."value" ELSE null END)) "subregion_based_jurisdiction"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'TRIBE_NAME')) THEN "a"."value" ELSE null END)) "tribe_name"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'LIVING_RESERVATION')) THEN "a"."value" ELSE null END)) "living_reservation"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'DEMOGRAPHIC') AND ("a"."question_id" = 'RESERVATION_NAME')) THEN "a"."value" ELSE null END)) "reservation_name"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'NCOV_CALLS') AND ("a"."question_id" = 'CASE_INTERVIEW_STATUS')) THEN "a"."value" ELSE null END)) "case_interview_status"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'ADMINISTRATIVE') AND ("a"."question_id" = 'DISEASE_STATUS_CONTACT')) THEN "a"."value" ELSE null END)) "disease_status_contact"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'ADMINISTRATIVE') AND ("a"."question_id" = 'DISEASE_STATUS_NOT_A_CASE')) THEN "a"."value" ELSE null END)) "disease_status_no_a_case"
                        , "max"((CASE WHEN (("q"."questionset_id" = 'ADMINISTRATIVE') AND (a.question_id IN ('DISEASE_STATUS_UNDEFINED','DISEASE_STATUS_SUSPECT','DISEASE_STATUS_PROBABLE','DISEASE_STATUS_CONFIRMED','DISEASE_STATUS_NOT_A_CASE','DISEASE_STATUS_CARRIER','DISEASE_STATUS_CONTACT','DISEASE_STATUS_PENDING'))) THEN a.value ELSE null END)) disease_status
                        , max((CASE WHEN ((q.questionset_id = 'ADMINISTRATIVE') AND (a.question_id = 'ELR_REVIEWED_NO')) THEN a.value ELSE null END)) elr_reviewed_no
                        , max((CASE WHEN ((q.questionset_id = 'ADMINISTRATIVE') AND (a.question_id = 'ELR_REVIEWED_NOTES')) THEN a.value ELSE null END)) elr_reviewed_notes
                        , max((CASE WHEN ((q.questionset_id = 'DEMOGRAPHIC') AND (a.question_id = 'SUBJECT_ID')) THEN a.value ELSE null END)) subject_id
                        , max((CASE WHEN ((q.questionset_id = 'NCOV_CALLS') AND (a.question_id = 'CALC_INTERVIEW_JURISDICTION')) THEN a.value ELSE null END)) calc_interview_jurisdiction

                        , max((CASE WHEN (a.question_id = 'COVID_STATUS') THEN a.value ELSE null END)) covid_status
                        , max((CASE WHEN (a.question_id = 'LIVING_SETTING') THEN a.value ELSE null END)) living_setting
                        , max((CASE WHEN (a.question_id = 'NO_WORKING_PHONE') THEN a.value ELSE null END)) no_working_phone
                        , max((CASE WHEN (a.question_id = 'IS_PERSON_DEAD_YES') THEN a.value ELSE null END)) is_person_dead
                        , max((CASE WHEN (a.question_id = 'COVID_STILL_HOSP') THEN a.value ELSE null END)) covid_still_hosp
                        , max((CASE WHEN (a.question_id = 'DATE_OF_DEATH') THEN a.value ELSE null END)) date_of_death
                        , max((CASE WHEN (a.question_id = 'CALL_ATTEMPT_DATE_TIME') THEN a.value ELSE null END)) latest_call_attempt_date_time

                        FROM
                          ids_product psub
                          inner join ids_case csub on csub.product_id = psub.unid
                          inner join ids_questionset q on csub.unid = q.case_id 
                          INNER JOIN ids_answer a ON "a"."questionset_id" = "q"."unid"
                        where psub.code = 'NCOV'
                        GROUP BY 1;
CREATE UNIQUE INDEX idx_mview_caseid_unique
ON covidsalesforce_owner.covid_case_q_and_a_denormalized USING btree
(case_id ASC NULLS LAST, city ASC NULLS LAST, intake_complete_date_time ASC nulls FIRST, elr_reviewed_no ASC nulls FIRST, disease_status ASC NULLS LAST)
TABLESPACE pg_default;

alter materialized view covidsalesforce_owner.COVID_CASE_Q_AND_A_DENORMALIZED owner to covidsalesforce_dms_user;                        
grant select on COVID_CASE_Q_AND_A_DENORMALIZED to covidsalesforce_user;