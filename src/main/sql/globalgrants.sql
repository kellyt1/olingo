grant all on all tables in schema covidsalesforce_owner to covidsalesforce_admin_role;
grant all on all sequences in schema covidsalesforce_owner to covidsalesforce_admin_role;
grant SELECT,USAGE on all sequences in schema covidsalesforce_owner to covidsalesforce_user_role;
grant SELECT,USAGE on all sequences in schema covidsalesforce_owner to covidsalesforce_readonly_role;
grant all on all functions in schema covidsalesforce_owner to covidsalesforce_admin_role;
grant all on all functions in schema covidsalesforce_owner to covidsalesforce_user_role;
grant select,update,insert,delete on all tables in schema covidsalesforce_owner to covidsalesforce_user_role;
grant select on all tables in schema covidsalesforce_owner to covidsalesforce_readonly_role;

