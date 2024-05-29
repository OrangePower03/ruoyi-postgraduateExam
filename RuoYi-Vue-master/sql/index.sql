create index idx_school_name on wx_school (school_name);


create index idx_connect_id on wx_score (connect_id);
create index idx_connId_year on wx_score (connect_id, score_year);


create index idx_major_department on wx_mcd (major_id, department_id);


create index idx_major_name on wx_major (major_name);


create index idx_school on wx_department (department_school_id);
