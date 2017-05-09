--  Before you try the code in this file from the psql client, you need to create your database NBA-xxx and copy data from NBA to it. For example,
--  createdb NBA-tuy
--  pg_dump -t player_rs_career NBA | psql NBA-tuy
--  Note that those should be done under the Linux console. Then you can log into NBA-xxx and try the following scripts.

--  The following line only needs to be executed once before you do anything at all with pgplsql functions
-- CREATE LANGUAGE 'plpgsql';

-- function 1 declaration

CREATE OR REPLACE FUNCTION player_height_rank (firstname VARCHAR, lastname VARCHAR) RETURNS int AS $$
DECLARE

   rank INTEGER :=0;
   offset INTEGER :=0;
   tempValue float := 0.0;
   r record;
BEGIN


FOR r IN SELECT  (P.h_feet *12*2.54 + P.h_inches *2.54) as height, P.firstname, P.lastname
FROM players as P 
ORDER BY  (P.h_feet *12*2.54 + P.h_inches *2.54) DESC, P.firstname, P.lastname
LOOP

IF r.height = tempValue then
offset:= offset +1;
ELSE
rank:= rank + offset +1;
offset:=0;
tempValue:=r.height;
END IF;

IF r.lastname = $2 AND r.firstname = $1 THEN
RETURN rank;
END IF;
END LOOP;

RETURN 0;


END;
$$ LANGUAGE plpgsql;

-- executing the above function
-- select * from player_height_rank('Reggie', 'Miller');


-- function 2 declaration

CREATE OR REPLACE FUNCTION player_weight_var (tid VARCHAR, yr INTEGER) 
RETURNS FLOAT AS $$
DECLARE
   result float := 0.0;
   a record;
   diff float := 0.0;
   
BEGIN


FOR a IN SELECT COUNT(p.weight) as num,
avg(p.weight) as avg, pr.tid, pr.year
FROM players p, player_rs pr
WHERE p.ilkid = pr.ilkid
GROUP BY pr.tid, pr.year
LOOP

select into diff sum((p.weight - a.avg) * (p.weight - a.avg)), pr.tid, pr.year
from players p, player_rs pr
where p.ilkid = pr.ilkid
GROUP BY pr.tid, pr.year;

IF a.tid = $1 AND a.year = $2 then
result = diff/ a.num;
RETURN result;
ELSE 
END IF;
END LOOP;

RETURN -1.0;



END;
$$ LANGUAGE plpgsql;


--select * from player_weight_var('HOU', 1972);
