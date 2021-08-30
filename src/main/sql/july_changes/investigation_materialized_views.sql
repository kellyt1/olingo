-- positive cases
DROP MATERIALIZED VIEW covidsalesforce_owner.COVID_POSITIVE CASCADE ;
CREATE MATERIALIZED VIEW covidsalesforce_owner.COVID_POSITIVE AS
select  distinct inv.participant_id
from IDS_INVESTIGATION inv
     INNER JOIN ids_investigation_result ir on ir.investigation_id = inv.unid and ir.result_code = 'Test'
     INNER JOIN ids_investigation_result_attr i1 on i1.investigation_result_id = ir.unid and i1.name = 'Test'
     inner join ids_investigation_result_attr i2 on i2.investigation_result_id = ir.unid and i2.name = 'Result'
where inv.create_date >= timestamp '2020-01-01 00:00'
  and i1.value not in ('94563-4','94504-8','94564-2','94562-6','94505-5','94507-1','94503-0','94508-9','94547-7','94661-6','94720-0','94761-4','94762-2','94765-5','94768-9','94769-7','95125-1','MDHT90013','95411-5','95970-0', '95410-7')
and i2.value in ('260373001', '10828004', '840533007', '415361004');

CREATE UNIQUE INDEX IDX_COVID_POSITIVE_UNIQUE
ON covidsalesforce_owner.COVID_POSITIVE USING btree
(participant_id ASC NULLS LAST)
TABLESPACE pg_default;

alter materialized view covidsalesforce_owner.COVID_POSITIVE owner to covidsalesforce_dms_user;
grant select on covidsalesforce_owner.COVID_POSITIVE to covidsalesforce_user;

-- abnormal cases
DROP MATERIALIZED VIEW covidsalesforce_owner.COVID_ABNORMAL CASCADE ;
CREATE MATERIALIZED VIEW covidsalesforce_owner.COVID_ABNORMAL AS
select  distinct inv.participant_id
from IDS_INVESTIGATION inv
     INNER JOIN ids_investigation_result ir on ir.investigation_id = inv.unid and ir.result_code = 'Test'
     INNER JOIN ids_investigation_result_attr i1 on i1.investigation_result_id = ir.unid and i1.name = 'Test'
     left outer join ids_investigation_result_attr i2 on i2.investigation_result_id = ir.unid and i2.name = 'Result'
     inner join ids_investigation_result_attr i3 on i3.investigation_result_id = ir.unid and i3.name = 'AbnormalFlag'
where inv.create_date >= timestamp '2020-01-01 00:00'
and i1.value not in ('94563-4','94504-8','94564-2','94562-6','94505-5','94507-1','94503-0','94508-9','94547-7','94661-6','94720-0','94761-4','94762-2','94765-5','94768-9','94769-7','95125-1','MDHT90013','95411-5','95970-0', '95410-7')
and i2.unid is null
--check on AbnormalFlag added
and i3.value IN ('A','HH','>','AA','H');

CREATE UNIQUE INDEX IDX_COVID_ABNORMAL_UNIQUE
ON covidsalesforce_owner.COVID_ABNORMAL USING btree
(participant_id ASC NULLS LAST)
TABLESPACE pg_default;

alter materialized view covidsalesforce_owner.COVID_ABNORMAL owner to covidsalesforce_dms_user;
grant select on covidsalesforce_owner.COVID_ABNORMAL to covidsalesforce_user;