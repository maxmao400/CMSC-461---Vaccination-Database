-- This operation requires transactional support due to concurrency. The transaction isolation level is read uncommitted. Without
-- transactional support this operation could corrupt the database and causing errors inside the database system.

set session transaction isolation level read uncommitted;

start transaction;
-- 1. a folk registering for a vaccine
insert into folks values ('1111111111111103', 'Folk','New','1964-10-24',1111111111, 001101011, 444433333, 'maxmao199@gmail.com');
insert into register values ('1111111111111103','AA00',0,3,'2019-01-02');
select* from register;

rollback;

