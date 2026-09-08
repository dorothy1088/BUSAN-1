show databases;
drop database if exists `d_1`;
create database if not exists `d_1`;
use `d_1`;

-- <DDL>
-- 회원
-- 식별자, 이메일, 이름, 연령, 등급, 생성일자
-- 이메일은 중복되지 않았으면 좋겠다.

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
-- 속성은 순서가 없는데 행은 순서가 있음 

create table orders(
	id bigint not null primary key,
	member_id bigint not null,
	product varchar(100) not null,
	amount int not null,
	ordered_at timestamp default now(),
	foreign key (member_id) references `members`(id)
	);
show tables;
desc orders;


insert into members
	( id, name, email, age, grade )
	values
	( 1, '김민수', 'kim@example.com', 10, 'SILVER');

-- 1은 안됨.. 주키라서..
-- 테이블과 동시에 시퀀스 sql 제약조건이나 시퀀스 ..하나더..
-- auto_increment로 숫자 하나씩 올리기..


insert into members
	( name, email, age, grade )
	values
	( '김민수', 'kim@example.com', 10, 'SILVER');


insert into members
	( name, email, age)
	values
	( '빅주성', 'park@example.com', 10),
	('이영희', 'lee@example.com', 10),
	('박민준', 'min@example.com', 10);


select
	*
from 
	members
	;

-- 트랜잭션 발동 - 틀리면 자동 취소/ 취소된 id 숫자는 그대로 유효 
-- 로그성 데이터 -숫지 엄청난 건 데이터는 이거 쓰기 어려움 문자열로 해야..


select 
	name, email, age
from
	members 
;

select 
	name as 이름, email as 이메일, age as 나이
from
	members 
;


select 
	name 이름, email 이메일, age 나이
from
	members 
;

select
	*
from
	members
where
	grade == 'BRONZE'
; 
-- 틀림,, SQL는 등호가 한개이다..그래서 틀림

select
	*
from
	members
where
	grade = 'BRONZE'
;

select
	*
from
	members
where
	grade = 'BRONZE'
	and
	age >= 10
;

select
	*
from
	members
where age
	between 10 and 30
;























	
	
	