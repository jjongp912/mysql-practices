desc emaillist;

-- insert
insert into emaillist values(null, '박', '종진', 'jjongp912@naver.com');
insert into emaillist values(null, '둘', '리', 'dooly@naver.com');

-- select
select no, first_name, last_name, email
from emaillist
order by no desc;