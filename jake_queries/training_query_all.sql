with cte1 as 
(
select
 t3.words,
 t2.name as r_user,
 t4.rating_id as rid,
 t5.name as tagname,
 t1.explanation as exp
from rating t1
join rater t2 on t1.rater_id = t2.id
join sentence t3 on t1.sentence_id = t3.id
join tag_rating t4 on t1.id = t4.id
join tag t5 on t4.tag_id = t5.id
),
/*

select r_user, 
(Select count(*) from cte1 where tagname ='Light') as Light,
(Select count(*) from cte1 where tagname ='Crystal') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry') as Tapestry,
(Select count(*) from cte1 where tagname ='Void') as Void
from cte1 where r_user = "David" group by r_user


select t1.r_user, t2.Light, t2.Crystal, t2.Tapestry, t2.Void
 'Light '|| (Select Count(*) from cte1 where tagname='Light') || ' '||
 'Tapestry '|| (Select Count(*) from cte1 where tagname='Tapestry') || ' '||
 'Crystal '|| (Select Count(*) from cte1 where tagname='Crystal') || ' '||
 'Void ' || (Select Count(*) from cte1 where tagname='Void') as Breakdown from cte1  group by r_user

*/
--select r_user as Who, count(*) as TotalRated from cte1 group by r_user order by TotalRated desc


with cte1 as 
(
select
 t3.words,
 t2.name as r_user,
 t4.rating_id as rid,
 t5.name as tagname,
 t1.explanation as exp
from rating t1
join rater t2 on t1.rater_id = t2.id
join sentence t3 on t1.sentence_id = t3.id
join tag_rating t4 on t1.id = t4.id
join tag t5 on t4.tag_id = t5.id
)

select r_user,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'David') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'David') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'David') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'David') as Void from cte1 where r_user = 'David' group by r_user
Union
select r_user,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'Jeremy') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'Jeremy') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'Jeremy') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'Jeremy') as Void from cte1 where r_user = 'Jeremy' group by r_user
union
select r_user,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'James') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'James') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'James') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'James') as Void from cte1 where r_user = 'James' group by r_user
union
select r_user,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'Jake') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'Jake') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'Jake') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'Jake') as Void from cte1 where r_user = 'Jake' group by r_user