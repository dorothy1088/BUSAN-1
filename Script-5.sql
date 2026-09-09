drop database if exists `d_2`;
create database if not exists `d_2`;
use `d_2`;

create table members(
	id bigint not null auto_increment primary key,
	name varchar(50) not null,
	dept_id bigint
	);
-- 외래키는 '다'쪽에 넣어줘야 된다. 
create table dept(
	id bigint not null auto_increment primary key,
	name varchar(50) not null 
	);

create table orders(
	id bigint not null auto_increment primary key,
	member_id bigint not null,
	product varchar(100) not null,
	amount bigint
	);

show tables; 

insert into dept
	(name)
values
	('개발팀'),
	('마케팅팀'),
	('디자인팀')
	;
insert into members
	(name, dept_id)
values
	('김철수', 1),
	('이영하', 1),
	('박준수', 2),
	('최범수', null),
	('한민준', null)
	;

insert into orders
	(member_id, product, amount)
values
	(1, '노트북', 1500000),
	(1, '마우스', 35000),
	(2, '키보드', 89000),
	(3, '모니터', 450000),
	(99, '헤드셋', 120000)
	;
	
select
	*
from
	members
	;
	
	select
	*
from
	dept
	;
	
select
	*
from
	orders
	;

-- join 의 종류: 보통 inner랑 left만 많이 씀 
-- inner join
-- left (outer) join
-- right join
-- full outer join
-- cross join
-- union (full join)
	
select
	*
from
	members m
inner join
	dept d
on
	m.dept_id = d.id
	;


select
	m.id as '회원 번호',
	m.name as '회원 이름',
	d.name as '부서 이름'
from
	members m
inner join
	dept d
on
	m.dept_id = d.id
	;

select
	*
from
	members m
inner join
	orders o
on
	m.id = o.member_id
;
# 이너 조인은 교집합이라 없는 건 제외시킴 그냥 테이블 붙이는 거임..

select
	m.id as 회원번호,
	m.name as 회원이름,
	o.product as 상품명,
	o.amount as 상품가액
from
	members m
inner join
	orders o
on
	m.id = o.member_id
;

-- 

select
	d.name as 부서명,
	m.name as 회원명,
	o.product as 상품명,
	o.amount as 상품가액
from
	members m
inner join
	dept d
on
	m.dept_id = d.id
inner join
	orders o
on
	o.member_id = m.id
	;

-- 개발팀 회원의 주문 건수와 총 구매액 집계

select
	m.name as 회원명,
	count(o.id) as 주문건수,
	sum(o.amount) as 주문총액
from
	members m
inner join 
	dept d
on
	m.dept_id = d.id
inner join
	orders o
on
	o.member_id = m.id
where
	d.name = '개발팀'
group by
	m.id, m.name ;

-- left join

select *
from
	members m
left join
	dept d
on
	m.dept_id = d.id
	;
-- from 기준으로 없는 건 null로 가지고 오는 건 같은 거 가지고 옴 


select
	m.name as 회원명,
	count(o.id) as 주문건수,
	sum(o.amount) as 총구매액
from
	members m
left join
	orders o
on
	m.id = o.member_id
group by
	m.id, m.name;

select
	m.name as 회원명,
	count(o.id) as 주문건수,
	coalesce(sum(o.amount), 0) as 총구매액 # null대신에 0이 등록
from
	members m
left join
	orders o
on
	m.id = o.member_id
group by
	m.id, m.name;

select
	*
from
	members m
left join
	dept d
on
m.dept_id = d.id
left join
	orders o
on
	m.id=o.member_id; 
# 멤버가 기준 회원아이디 99 있는 거 들어가 

select
	*
from
	members m
cross join
	orders o; 


select count(*) 
	*
from
	members m
cross join
	orders o; 

desc orders ; 
alter table orders add column created_at datetime default now();

select 
	dates.work_date,
	d.name,
	count(o.id) as 주문건수
from (
	select date('2026-09-07') as work_date
	union all select date('2026-09-08')
	union all select date('2026-09-09')
	) as dates
cross join
	dept d
left join 
	orders o
on 
	date(o.created_at)=dates.work_date
group by 
	dates.work_date, d.id, d.name ; 



select date('2026-09-07') as work_date









