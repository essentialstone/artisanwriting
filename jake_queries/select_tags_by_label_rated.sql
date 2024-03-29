with cte1 as 
(
select
 t3.words as words,
 t2.name as r_user,
 t4.rating_id,
 t5.name tagname,
 t1.explanation
from rating t1
join rater t2 on t1.rater_id = t2.id
join sentence t3 on t1.sentence_id = t3.id
join tag_rating t4 on t1.id = t4.id
join tag t5 on t4.tag_id = t5.id
)

select words,tagname from cte1 where tagname in ('Tapestry','NONE')