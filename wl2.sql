
/*

 wordlist.sql: table with words, possibly for wordle

*/

\timing on
\set ECHO all

-- cleanup
drop table wl_fr2 ;

-- define table

create table wl_fr2 ( 
  id bigint primary key generated always as identity
, word text 
);

-- index on word, if neededd
-- create index wl_fr_wrdidx on wl_fr ( word asc, id ) ;

\COPY wl_fr2 ( word ) FROM  'wordlist_fr2.txt' ;

select count (*), length(word) from wl_fr2 group by length ( word ) order by 2;

delete from wl_fr where length ( word) != 5 ;

update wl_fr2 set word = lower(word) where  word != lower(word) ;

with q as (
  select word from wl_fr2 w2 
  where not exists ( select word from wl_fr w3 where w3.word = w2.word) )
insert into wl_fr as w ( word )
  select word from q  ;

INSERT INTO wl_fr (word)
SELECT word
FROM wl_fr2
WHERE NOT EXISTS (
    SELECT 1
    FROM wl_fr
    WHERE wl_fr.word = wl_fr2.word
    )
;
