UPDATE tag SET description = 'Home, Hearth, Artists, Musicians, Master Craftsman that create things to endure. Things that are one with nature and animals. Things that ground you and enrich your heart and sense of community and one another. These are the things of Tapestry' WHERE name = 'Tapestry';
UPDATE tag SET description = 'Genius, Imagination, Ambition and Possibility, Light is the cardinal element of change, all forms of magic, chaos, and imagination. Infinite possibility and power lie in the cardinality of Light.' where name = 'Light';
UPDATE tag SET description = 'Creeds to Gods and Country, Discipline, and Divine Perfection, Martial Arts and the perfection of self through means that rely upon divine will or self-mastery. these are the domain of Crystal' where name = 'Crystal';
UPDATE tag SET description = 'Ego, Deception, Guile, Science and Technology agnostic to the value of human life. All things must come to an end - short term solutions that give catharsis. Void is the domain of that which devours and necessary evils - All good deeds cast a shadow -  Lies, trickery, murder, betrayal and the gaping maw of the unknown. These are all in the realm of Void.' where name = 'Void';
UPDATE tag SET description = 'This category exists when the target text does not firmly map to any one/combination of the cardinality tags' where name = 'NONE';
Update tag set description = '' where name in ('Blade','Divine','Relic','Armor','Dream','Blood');
select * from tag order by description desc