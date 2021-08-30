drop table agent_work;
CREATE TABLE
    agent_work (
id	VARCHAR(36) NOT NULL,
accept_datetime	TIMESTAMP WITHOUT TIME ZONE,
agent_work_name	VARCHAR(255),
assigned_datetime	TIMESTAMP WITHOUT TIME ZONE,
cancel_datetime	TIMESTAMP WITHOUT TIME ZONE,
close_datetime	TIMESTAMP WITHOUT TIME ZONE,
company VARCHAR(255),
county VARCHAR(255),
decline_datetime	TIMESTAMP WITHOUT TIME ZONE,
handle_time	bigint,
is_owner_change_initiated	BOOLEAN,
is_status_change_initiated	BOOLEAN,
medss_event_id	VARCHAR(255),
medss_event_name	VARCHAR(255),
medss_event_record_type	VARCHAR(255),
medss_event_status	VARCHAR(255),
mn_id	VARCHAR(255),
original_group_name	VARCHAR(255),
original_queue_name	VARCHAR(255),
owner_name	VARCHAR(255),
push_timeout	bigint,
push_timeout_datetime	TIMESTAMP WITHOUT TIME ZONE,
region	VARCHAR(255),
request_datetime	TIMESTAMP WITHOUT TIME ZONE,
speed_to_answer	bigint,
status	VARCHAR(255),
user_name	VARCHAR(255),
user_role	VARCHAR(255),
insert_datetime	TIMESTAMP WITHOUT TIME ZONE,
modified_datetime	TIMESTAMP WITHOUT TIME ZONE,
CONSTRAINT pk_agent_work PRIMARY KEY (id)
);

grant select,update,insert,delete on  agent_work  to covidsalesforce_user;