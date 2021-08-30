drop index idx_answertbl_questionid;
drop index idx_questionset_caseid;
drop index idx_case_productid; 
drop index idx_investigation_participantid;
drop index idx_investigationresult_investigationid;
--drop index idx_investigationattr_investigationresultid;
drop index idx_contactpoint_partyid;
drop index idx_participant_caseid;
--drop index idx_investigationresultsattr_test;
drop index idx_investigationresultsattr_idx2;

drop index idx_mview_caseid_unique;


create index idx_answertbl_questionid ON IDS_ANSWER USING btree (question_id);
create index idx_questionset_caseid on IDS_QUESTIONSET USING btree (case_id);
create index idx_case_productid on IDS_CASE USING btree (product_id);
create index idx_investigation_participantid ON IDS_INVESTIGATION USING btree (participant_id);
create index idx_investigationresult_investigationid ON IDS_INVESTIGATION_RESULT USING btree (investigation_id, result_code);
create index idx_investigationattr_investigationresultid ON IDS_INVESTIGATION_RESULT_ATTR USING btree (investigation_result_id);
create index idx_contactpoint_partyid on ids_contactpoint using btree (party_id);
create index idx_participant_caseid on ids_participant using btree (case_id);

CREATE UNIQUE INDEX idx_mview_caseid_unique
ON covidsalesforce_owner.covid_case_q_and_a_denormalized USING btree
(case_id ASC NULLS LAST, city ASC NULLS LAST, intake_complete_date_time ASC nulls FIRST, elr_reviewed_no ASC nulls FIRST, disease_status ASC NULLS LAST)
TABLESPACE pg_default;

--

CREATE INDEX
    idx_investigationresultsattr_idx2
ON
    ids_investigation_result_attr
USING
    btree
    (
        investigation_result_id,
        name,
        value
    );
