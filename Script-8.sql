drop database if exists air_delivery;
create database if not exists air_delivery;
use air_delivery;

-- Q1 수기로 벌크 insert 쿼리로 바꿔줘 
-- 번호, 품목, 특별 수화물, 보내는 곳, 받는 곳, 항공사, 거리단위, 특별운임, 운임, 보내는 날짜
create table draft(
	id int unsigned not null primary key auto_increment,
	sort varchar(4) not null,
	is_rush tinyint unsigned not null,
	export varchar(5) not null,
	import varchar(5) not null,
	airline varchar(10) not null,
	distance tinyint unsigned not null,
	special_rate int unsigned not null,
	freight_charge int unsigned not null,
	reg_date date not null);
	
	INSERT INTO `draft`
(
    `sort`,
    `is_rush`,
    `export`,
    `import`,
    `airline`,
    `distance`,
    `special_rate`,
    `freight_charge`,
    `reg_date`
)
VALUES
('식품',     0, '중국', '한국', '대한항공', 1, 0,    1500, '2022-02-07'),
('기호품',   0, '한국', '호주', '아시아나', 2, 0,    2500, '2022-02-07'),
('전자제품', 1, '일본', '한국', '닛폰항공', 1, 1000, 1500, '2022-02-07'),
('의약품',   1, '미국', '한국', '델타항공', 4, 1000, 3000, '2022-02-08'),
('식품',     0, '인도', '한국', '고우에어', 3, 0,    2500, '2022-02-08'),
('일반우편', 0, '한국', '캐나다', '대한항공', 4, 0,    3000, '2022-02-08'),
('의류',     1, '한국', '일본', '아시아나', 1, 1000, 1500, '2022-02-10'),
('전자제품', 1, '미국', '한국', '델타항공', 4, 1000, 3000, '2022-02-10'),
('주류',     1, '칠레', '한국', '라탐항공', 4, 1000, 3000, '2022-02-11'),
('주류',     1, '독일', '한국', '대한항공', 4, 1000, 3000, '2022-02-11');
	
-- Q2 전체 데이트 조회	
select * from draft ; 

-- Q3 우리 공항에서 보낸 항공편의 전체 데이터를 보고 싶다(항공편 갯수 집계)
select export as '보내는 곳', count(export) as '항공편 수' from draft group by export; 

-- Q4 보내는 곳이 한국만 나오게 출력을 조정
 select export as '보내는 곳', count(export) as '항공편 수' from draft group by export 
	having export = '한국' ;

-- Q5 미국 출발 - 받는 곳이 한국인 항공편 몇개?
select export as '받는 곳', count(export) as '항공편수' from draft group by export having export = '미국';

-- 테이블 분리= 정규화

-- ㅃ6 풍류 (범주형 데이터)를 관리할 수 있는 테이블 하나 만들기
desc draft;
create table sort_table(
	id int unsigned not null primary key auto_increment,
	sort varchar(4) not null,
	is_rush tinyint unsigned not null);

insert into sort_table
  ( sort, is_rush )
values
  ( '식품', 0 ),
  ( '기호품', 0 ),
  ( '전자제품', 1),
  ( '의약품', 1),
  ( '의류', 0 ),
  ( '주류', 1 ),
  ( '일반우편', 0)
;

-- Q7 특별 수화물은 0, 아니면 X로 출력
select 
	id as 번호,
	sort as 품류,
	case 
		when is_rush = 0
		then 'X'
		else 'O'
	end as 특별수화물
from sort_table;

select * from draft ;

-- inner join
update draft d join sort_table st on d.sort = st.sort set d.sort = st.id; 

alter table draft drop column is_rush;

desc draft; 

alter table draft change sort sort_id int not null;
alter table draft modify column sort_id int unsigned not null; 
alter table draft add foreign key(sort_id) references sort_table(id); 

select d.id as 물류대장표_번호, st.sort as 품목,
case
	when st.is_rush = 0
	then 'X'
	else 'O'
	end as 특별수하물여부
	from draft d
	left join sort_table st
	on d.sort_id = st.id;

-- Q8

drop table if exists distance_charge ;
create table distance_charge(
id int unsigned not null primary key auto_increment,
distance int not null,
culture_code varchar(5) not null unique,
freight_charge int unsigned not null);

select * from draft; 

insert into distance_charge
set
	culture_code = '아시아',
	distance = 1,
	freight_charge = 1500;


insert into distance_charge
set
	culture_code = '오세아니아',
	distance = 2,
	freight_charge = 2000;

insert into distance_charge
set
	culture_code = '인도',
	distance = 3,
	freight_charge = 2500;

insert into distance_charge
set
	culture_code = '유럽-미주',
	distance = 4,
	freight_charge = 3000;

select * from dis

create table culture(
id int unsigned not null primary key auto_increment,
culture_code varchar(5) not null ,
nation varchar(10) not null);

insert into culture
(culture_code, nation)
values
('아시아','한국'),
('아시아','중국'),
('아시아','일본'),
('오세아니아','호주'),
('인도','인도'),
('유럽-미주','칠레'),
('유럽-미주','미국'),
('유럽-미주','캐나다');

select * from culture;
select c.nation as 국가명, dc.distance as 거리단위, dc.freight_charge as 운임
from culture c
left join distance_charge dc on c.culture_code = dc.culture_code;

select * from draft; 

select c.nation as 국가명, dc.distance as 거리단위, dc.freight_charge as 운임
from culture c
left join distance_charge dc on c.culture_code = dc.culture_code
where c.nation = '호주'or c.nation='캐나다'or c.nation='칠레';

select c.nation as 국가명, dc.distance as 거리단위, dc.freight_charge as 운임
from culture c
left join distance_charge dc on c.culture_code = dc.culture_code
where c.culture_code = '아시아';

create table special_charge_table(
id int unsigned not null primary key auto_increment,
is_rush tinyint unsigned not null,
special_rate int unsigned not null);

insert into special_charge_table
(is_rush,special_rate )
values
(1, 1000),
(0,0);

desc draft;
alter table draft drop column distance;
alter table draft drop column special_rate;
alter table draft drop column freight_charge;

-- Q11
select d.id as 번호, c.nation as 국가명, d.sort_id as 품류, dc.freight_charge as 운임
from draft d 
left join distance_charge dc on c.culture_code = dc.culture_code
where c.culture_code = '칠레';

select st.sort as 품류,c.nation as 국명, dc.freight_charge as 운임
from sort_table st
join culture c
on c.nation = '칠레' 
join distance_charge dc 
on c.culture_code = dc.culture_code 
where st.sort = '전자제품'


















