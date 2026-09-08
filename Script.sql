show databases;
use mysql;
show tables;
select
*
from
 user;
select
 user.host, user 
 from user;
select 
host, user
from user;

create user
  'user1'@'%'
   identified by '1234'
   ;

select
  User 계정명,
  Host 호스트
 from 
  user
 where 
  User= 'user1'
  ;


grant
  all privileges
 on
  *.*
 to
  'user1'@'%'
  ;
flush privileges;

show grants for 'user1'@'%';


drop user 'user1'@'%';

create user
  'star1'@'%'
 identified by 'day'
;

grant all privileges
 on
  *.*
 to
  'star1'@'%'
 ;
flush privileges;














