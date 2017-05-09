-- change xxx in this line to your NetID 

\o proj2-jinhao.out



-- Put your SQL statement under the following lines:


--1. Find all the coaches who have coached exactly ONE team. List their first names followed by their last names;
select firstname,lastname from coaches_season where tid in
(select tid from coaches_season group by tid having count(tid)=1 );

--2. Find all the players who played in a Boston team and a Denver team (this does not have to happen in the same season). List their first names only. 
select PR.firstname from teams T, player_rs PR where T.tid = PR.tid
AND T.location = 'Boston' 
union
select PR2.firstname from teams T2, player_rs PR2 where T2.tid = PR2.tid 
AND T2.location = 'Denver';

--3. Find those who happened to be a coach and a player in the same team in the same season. List their first names, last names, the team where this happened, and the year(s) when this happened. 
select C.firstname , C.lastname , T.location , C.year
from coaches_season C, player_rs p, teams T
where C.firstname = p.firstname AND C.lastname = p.lastname 
AND C.tid = p.tid AND C.tid = T.tid AND T.tid = p.tid AND C.year = p.year;


--4. Find the average height (in centimeters) of each team coached by Phil Jackson in each season. Print the team name, season and the average height value (in centimeters), and sort the results by the average height. 
select t.name, AVG(p.h_feet * 30.48 + p.h_inches * 2.54), c.year
from teams t, coaches_season c, players p, player_rs pr
where p.ilkid = pr.ilkid and pr.tid = c.tid and c.tid = t.tid and t.tid = pr.tid
and c.firstname = 'Phil' and c.lastname = 'Jackson' and c.year = pr.year
group by t.name, c.year
order by AVG(p.h_feet * 30.48 + p.h_inches * 2.54) DESC;
--5. Find the coach(es) (first name and last name) who have coached the largest number of players in year 1999.


select c.firstname , c.lastname , pr.tid, count(pr.ilkid)
from coaches_season c, player_rs pr
where c.year = 1999 and pr.year = 1999
group by pr.tid ,c.firstname , c.lastname
order by count(pr.ilkid) DESC LIMIT 1;



--6. Find the coaches who coached in ALL leagues. List their first names followed by their last names. 
select c.firstname, c.lastname
from coaches_season c, teams t
group by c.firstname, c.lastname
having count(t.league) > 1;

--7. Find those who happened to be a coach and a player in the same season, but in different teams. List their first names, last names, the season and the teams this happened. 
select C.firstname , C.lastname , C.year , C.tid
from coaches_season C, player_rs p
where C.firstname = p.firstname AND C.lastname = p.lastname 
AND C.tid <> p.tid AND C.year = p.year;



--8. Find the players who have scored more points than Michael Jordan did. Print out the first name, last name, and total number of points they scored.

select b1.firstname,b1.lastname,c1.pts from players b1,player_rs_career c1 where b1.ilkid =c1.ilkid AND c1.pts>(

select c1.pts from player_rs_career c1 where c1.firstname='Michael' AND lastname ='Jordan');


--9. Find the second most successful coach in regular seasons in history. The level of success of a coach is measured as season_win /(season_win + season_loss). Note that you have to count in all seasons a coach attended to calculate this value. 

SELECT C.lastname, C.firstname, COUNT(C.season_win/(C.season_win + C.season_loss)) AS myCount FROM coaches_season C  WHERE (C.season_win/(C.season_win + C.season_loss)) NOT IN (SELECT MAX(C2.season_win/(C2.season_win + C2.season_loss)) AS myCount2 FROM coaches_season C2 ORDER BY myCount2 DESC) GROUP BY C.lastname, C.firstname, (C.season_win/(C.season_win + C.season_loss)) ORDER BY myCount DESC LIMIT 1;


--10. List the top 10 schools that sent the largest number of drafts to NBA. List the name of each school and the number of drafts sent. Order the results by number of drafts (hint: use "order by" to sort the results and 'limit xxx' to limit the number of rows returned); 
SELECT  draft_from, COUNT(ilkid) AS myCount FROM draft WHERE league = 'N' or league ='B' or league ='A' 
GROUP BY draft_from ORDER BY myCount DESC LIMIT 10;





-- redirecting output to console
\o


