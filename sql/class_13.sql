create database db_movie;
use db_movie;

create table movie(
	id int primary key auto_increment,
    title varchar(50) not null,
    director varchar(20) not null,
    release_date date not null,
    genre varchar(10) not null,
    rating double not null
);
desc movie;
-- drop table movie;
insert into movie (title, director, release_date, genre, rating)
values
('괴물', '봉준호', '2006-07-27', '드라마', 8.28),
('극한직업', '이병헌', '2019-01-23', '코미디', 9.20),
('명량', '김한민', '2014-07-30', '사극', 9.17),
('신과함께-죄와 벌', '김용화', '2017-12-20', '판타지', 7.56),
('밀양', '임권택', '2016-09-07', '드라마', 7.76),
('반도', '연상호', '2020-07-15', '액션', 6.71),
('베테랑', '류승완', '2015-08-05', '액션', 8.49),
('변호인', '양우석', '2013-12-18', '드라마', 8.41),
('군함도', '류승완', '2017-07-26', '사극', 8.01),
('암살', '최동훈', '2015-07-22', '액션', 8.37);

select * from movie;

-- 문제 1. 평점이 9점이 넘는 영화 제목과 감독만 출력하라
select title, director
from movie
where rating > 9;

-- 문제 2. 2016년 이후로 개봉한 영화에 대한 정보를 조회
select *
from movie
where release_date > '2016-01-01';

-- 문제 3. 오늘부로 '박태현' 감독의 신작 영화 '스타워즈-이미테이션'을 출시하게 되었다.
insert into movie (title, director, release_date, genre, rating)
values ('스타워즈-이미테이션', '박태현', '2024-06-04', 'SF', 0);

-- 문제 4. 테이블에서 가장 평점이 높은 영화를 찾고 그 row 를 전체 출력하시오
select *
from movie
where rating = (select max(rating) from movie);

-- 문제 5. 가장 최근에 개봉한 영화를 찾아라
select *
from movie
where release_date = (select max(release_date) from movie);

-- 문제 6. 드라마,액션을 제외한 김씨가 아닌 작품 조회
select *
from movie
where genre != '드라마'
and genre != '액션'
and director not like '김%';