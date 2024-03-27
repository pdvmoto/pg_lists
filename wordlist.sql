
/*

 wordlist.sql: table with words, possibly for wordle

*/

\timing on
\set ECHO all

-- cleanup
drop table wl_en ;
drop table wl_de ;
drop table wl_fr ;

-- define table

create table wl_en ( 
  id bigint primary key generated always as identity
, word text 
);

create table wl_de ( 
  id bigint primary key generated always as identity
, word text 
);

create table wl_fr ( 
  id bigint primary key generated always as identity
, word text 
);

-- index on word, if neededd
-- create index wl_en_wrdidx on wl_en ( word asc, id ) ;
-- create index wl_de_wrdidx on wl_de ( word asc, id ) ;
-- create index wl_fr_wrdidx on wl_fr ( word asc, id ) ;

-- add some words
insert into wl_en ( word ) values ( 'first' );
insert into wl_en ( word ) values ( 'second' );

select * from wl_en;

\COPY wl_en ( word ) FROM  'words_en.txt' ; 

\COPY wl_de ( word ) FROM  'wordlist_de.txt' ;

\COPY wl_fr ( word ) FROM  'wordlist_fr.txt' ;


select count (*), length(word) from wl_en group by length ( word ) order by 2;
select count (*), length(word) from wl_de group by length ( word ) order by 2;
select count (*), length(word) from wl_fr group by length ( word ) order by 2;

delete from wl_en where length ( word) != 5 ;
delete from wl_de where length ( word) != 5 ;
delete from wl_fr where length ( word) != 5 ;

update wl_en set word = lower(word) where  word != lower(word) ;
update wl_de set word = lower(word) where  word != lower(word) ;
update wl_fr set word = lower(word) where  word != lower(word) ;


