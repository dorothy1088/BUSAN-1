drop database if exists `d_1`;
create database if not exists `d_1`;
use `d_1`;


-- 회원
-- 식별자, 이메일, 이름, 연령, 등급, 생성일자 
-- 이메일은 중복되지 않았으면 좋겠다
create table members(
  id bigint not null auto_increment primary key,
  email varchar(100) not null unique,
  name varchar(50) not null,
  age int,
  grade varchar(10) default 'BRONZE',
  created_at timestamp default now()
);

show tables;
desc members;

-- 주문테이블
create table orders(
  id bigint not null auto_increment primary key,
  member_id bigint not null,
  product varchar(100) not null,
  amount int not null,
  ordered_at timestamp default now(),
  -- foreign key () references ``()
  foreign key (member_id) references `members`(id)
);

show tables;
desc orders;

insert into members
  ( name, email, age, grade )
values
  ( '김민수', 'kim2@example.com', 28, 'SILVER' )
;

insert into members
  ( name, email, age )
values
  ( '이영희', 'lee@example.com', 34 )
;

insert into members
  ( name, email, age )
values
  ( '박민수', 'park@example.com', NULL )
;

insert into members
  ( name, email, age, grade )
values
  ( '홍길동', 'a@google.com', 25, 'BRONZE'),
  ( '강감찬', 'b@naver.com', 41, 'GOLD'),
  ( '이순신', 'c@google.com', 33, 'SILVER')
;

select
	*
from
	members
where 
	grade in ('GOLD', 'SILVER')
;

select
	*
from
	members
where 
	grade not in ('BRONZE')
;


-- %, _
-- %김
-- 김%
-- %김% : 김이 포함만 되면 오케이 

select
	*
from
	members
where name
	like '김%'
;

select
	*
from
	members
where email
	like '%@google.com'
;

select
	*
from
	members
where name
	like '__수'
;

select
	*
from
	members
where 
	age = null
;
-- 이건 안된다.. is로 해야 

select
	*
from
	members
where 
	age is null
;

select
	distinct grade
from
	members
;

-모든 행에서 고유한 값만 나옴

select
	distinct grade
from
	members
order by grade desc
;

-- 범주형..정렬?은 안됨 

select
	count(*)
from 
	members
;
-- 열 취급 , 윈도우 함수 

select
	count(*) total_member_count
from 
	members
;
select
	name, 
	count(*) total_member_count
from 
	members
;
-- name 못 가지고 옴 왜냐면 그룹핑을 진행했기 때문에 

select
	count(age)
from 
	members
;
-- null을 제외하고 센다 

select
	count(name)
from 
	members
;

select
	avg(age) `평균나이`,
	min(age) `최소나이`,
	max(age) `최대나이`
from
	members
;


select
	count(*)
from
	members
;
select
	grade,
	count(*)
from
	members
group by
	grade
;
# 범주형 데이터에만 .. 수치형 아님 , 범주형은 수치도 있음 

select
	grade,
	count(*)
from
	members
group by
	grade
having
	count(*) >= 2
;
-- select도 컬럼 이름이 됨..

-- 서브쿼리는 수식 안에 또 수식이 들어감...
select 
	avg(age)
from members
; 

-- 서브쿼리 
select 
	name,
	age
from members
where 
	age >= (select avg(age) from members)
; 

select
	*
from
	members
limit 5 -- 가져올 데이터 양
offset 5 -- 가져올 데이터의 초기 위치값 
;
-- 여기까지 조회--

-- 수정
update 
	members
set 
	grade = 'GOLD'
;

select * from members ; 
-- 모든 게 다 골드로 바뀜 기존 데이터 날려버림...수정과 삭제는 조건절 줘야 ...
-- 취소는 그냥 rollback;하면 오케이

update 
	members
set 
	grade = 'GOLD'
where
	id = 1
;

select * from members;

update
	members
set
	grade = 'SILVER',
	age = 29
where
	email = 'kim2@example.com'
;

select * from members;

update
	members
set
	age = age + 1
where
	id = 3
;
select * from members;
# null은 null이다...

delete from members
where
	id = 3
; 
select * from members;
# 3번(식별자-특정행만) 건너뛰고 사라짐 

delete from members
where
	age is null
; 
# null인 거 지워버림 

delete from members
where
	1 = 1 and
	age is null
; 
# 1=1은 참..조건은 참일 때 붙이고 거짓일 때 빠짐 그러다 헷갈릴 수 있기에 그래서 아예 앞에 참을 하나 붙여놓음  



































 
