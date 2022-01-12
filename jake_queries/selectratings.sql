select
 t2.name,
 t3.words,
 t1.explanation,

from rating t1 
inner join rater t2 on t1.rater_id = t2.id
inner join sentence t3 on t3.id=t1.sentence_id
where t1.explanation != NULL





rating

id	integer Auto Increment [nextval('rating_id_seq')]	
rater_id	integer	
sentence_id	integer	
explanation	text NULL	
created_at	timestamp(3) [CURRENT_TIMESTAMP]	
updated_at	timestamp(3) [CURRENT_TIMESTAMP]



rater

id	integer Auto Increment [nextval('rater_id_seq')]	
name	text	
created_at	timestamp(3) [CURRENT_TIMESTAMP]	
updated_at	timestamp(3) [CURRENT_TIMESTAMP]	



sentence


id	integer Auto Increment [nextval('sentence_id_seq')]	
words	text	
source_id	integer	
deleted	boolean [false]	
created_at	timestamp(3) [CURRENT_TIMESTAMP]	
updated_at	timestamp(3) [CURRENT_TIMESTAMP]	