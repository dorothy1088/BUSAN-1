show databases;
# create database [데이터베이스_이름]

create database`test_db_1`
;

create database
  if not exists `test_db_1`
  ;

show databases;
use test_db_1;

drop database test_db_1; #복구 안됨 

create database if not exists `d_1`;
use `d_1`;

show tables;

create table t1(
 id bigint not null comment '주키', #주석 넣어주기
 c1_char char(100) not null,
 c2_num int,
 c3_date timestamp
);

show tables;

desc `t1`; #속성 출력 

desc t1;
-- 어떤 ddl 사용했는지 조회
show create table `t1`;

-- 컬럼 정보 확인
show columns from `t1`;

drop table `t1`;
show tables;

-- `d_2`이름을 갖는 데이터베이스 생성 쿼리 작성하기 
create database if not exists `d_2`;
use `d_2`; 
# 강의목록 - id, (수강생목록-)학번, ...
# 학생 정보- id, 학번, 이름 // 이 두개는 관계형 1대다 관계형 
# 부서(department)- id, 이름 // 사원- id, 이름 : dep_id (외래키): 식별할 수 있는 겹치지 않는 키여야 함 


# dep를 붙여서 딱 보이게.. # 컬럼의 

create table `department`(
	dep_id bigint not null primary key,
	dep_name varchar(50) not null 
	);

desc `department`;
create table `employees`(
	emp_id bigint not null primary key,
	emp_name varchar(100),
	dep_id bigint,
	constraint `fk_emp_dep`
	  foreign key (`dep_id`)
	  references `department`(`dep_id`)
	  on delete cascade
	  on update cascade 
);

desc `employees`;



















