CREATE or replace VIEW user_vote_breakdown as (
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

breakdown as 
(
select r_user as User,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'David') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'David') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'David') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'David') as Void, 
(Select count(*) from cte1 where r_user = 'David' and tagname in ('Light','Tapestry','Crystal','Void')) as TotalRelevant,
(Select count(*) from cte1 where r_user	= 'David') as TotalForUser from cte1 where r_user = 'David' group by r_user
union
select r_user as User,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'Jeremy') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'Jeremy') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'Jeremy') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'Jeremy') as Void,
(Select count(*) from cte1 where r_user = 'Jeremy' and tagname in ('Light','Tapestry','Crystal','Void')) as TotalRelevant,
(Select count(*) from cte1 where r_user	= 'Jeremy') as TotalForUser from cte1 where r_user = 'Jeremy' group by r_user
union
select r_user as User,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'James') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'James') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'James') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'James') as Void,
(Select count(*) from cte1 where r_user = 'James' and tagname in ('Light','Tapestry','Crystal','Void')) as TotalRelevant,
(Select count(*) from cte1 where r_user	= 'James') as TotalForUser from cte1 where r_user = 'James' group by r_user
union
select r_user as User,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'Jake') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'Jake') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'Jake') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'Jake') as Void,
(Select count(*) from cte1 where r_user = 'Jake' and tagname in ('Light','Tapestry','Crystal','Void')) as TotalRelevant,
(Select count(*) from cte1 where r_user	= 'Jake') as TotalForUser  from cte1 where r_user = 'Jake' group by r_user
union
select r_user as User,
(Select count(*) from cte1 where tagname ='Light' and  r_user = 'Ethan') as Light,
(Select count(*) from cte1 where tagname ='Crystal' and  r_user = 'Ethan') as Crystal,
(Select count(*) from cte1 where tagname ='Tapestry' and  r_user = 'Ethan') as Tapestry,
(Select count(*) from cte1 where tagname ='Void' and  r_user = 'Ethan') as Void,
(Select count(*) from cte1 where r_user = 'Ethan' and tagname in ('Light','Tapestry','Crystal','Void')) as TotalRelevant,
(Select count(*) from cte1 where r_user	= 'Ethan') as TotalForUser  from cte1 where r_user = 'Ethan' group by r_user
)

Select * from breakdown order by TotalRelevant desc
)