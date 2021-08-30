drop view covid_case_calllog;
create or replace view covid_case_calllog  as
select distinct c.case_id, c.unid as case_key, a.iteration, c.modification_date,
(select a1.value from ids_case c1, ids_questionset q1, ids_answer a1 where c1.case_id = c.case_id and   q1.case_id = c1.unid and a1.questionset_id = q1.unid
  and a1.iteration = a.iteration and a1.question_id = 'CALL_ATTEMPT_DATE') as call_attempt_date,

(select a1.value from ids_case c1, ids_questionset q1, ids_answer a1 where c1.case_id = c.case_id and   q1.case_id = c1.unid and a1.questionset_id = q1.unid
  and a1.iteration = a.iteration and a1.question_id = 'CALL_ATTEMPT_MADE_BY') as call_attempt_made_by,

(select a1.value from ids_case c1, ids_questionset q1, ids_answer a1 where c1.case_id = c.case_id and   q1.case_id = c1.unid and a1.questionset_id = q1.unid
  and a1.iteration = a.iteration and a1.question_id = 'CALL_RESULT') as call_result,

(select a1.value from ids_case c1, ids_questionset q1, ids_answer a1 where c1.case_id = c.case_id and   q1.case_id = c1.unid and a1.questionset_id = q1.unid
  and a1.iteration = a.iteration and a1.question_id = 'CALL_LOG_COMMENTS') as call_log_comments

from ids_product product,
     ids_case c,
     ids_participant p,
     ids_party party,
     ids_contactpoint cp,
     ids_questionset qs,
     ids_answer a
where product.code = 'NCOV'
and   c.product_id = product.unid
and   p.case_id = c.unid
and   party.unid = p.party_id
and   cp.party_id = party.unid
and   qs.case_id = c.unid
and   a.questionset_id = qs.unid
and   a.question_id in ('CALL_ATTEMPT_DATE', 'CALL_ATTEMPT_MADE_BY', 'CALL_RESULT', 'CALL_LOG_COMMENTS')
--and c.modification_date > CURRENT_DATE
order by iteration desc;

alter view covid_case_calllog owner to covidsalesforce_dms_user;

grant select on covid_case_calllog to covidsalesforce_user;