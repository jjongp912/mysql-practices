-- pet table 생성
create table pets(
name varchar(20),
owner varchar(20),
species varchar(20),
gender char(1),
birth date,
death date
);

-- table scheme 확인
desc pets;

-- insert
insert into pets values('보리','jjongp','dog','w','2019-06-21',null);
insert into pets(owner,name,species,gender,birth)
values('jjongp','coco','cat','m','2018-9-12');
insert into pets values('마음이','jjongp','dog','m','2010-08-12','2020-12-23');

-- select
select * from pets;

select name, birth from pets;

select name, birth from pets order by birth asc;

select count(*) from pets;
select count(*) from pets where death is not null;

-- update(U)
update pets
set species='monkey'
where name='choco';

-- delete(D)
delete from pets where death is not null;

