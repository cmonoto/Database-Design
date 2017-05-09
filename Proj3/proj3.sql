--  Before you try the code in this file from the psql client, you need to create your database NBA-xxx and copy data from NBA to it. For example,
--  createdb NBA-tuy
--  pg_dump -t player_rs_career NBA | psql NBA-tuy
--  Note that those should be done under the Linux console. Then you can log into NBA-xxx and try the following scripts.

--  The following line only needs to be executed once before you do anything at all with pgplsql functions
-- CREATE LANGUAGE 'plpgsql';

-- function 1 declaration

CREATE OR REPLACE FUNCTION player_height_rank (firstname VARCHAR, lastname VARCHAR) RETURNS int AS $$
DECLARE
   
BEGIN


END;
$$ LANGUAGE plpgsql;

-- executing the above function
-- select * from player_height_rank(‘Reggie’, ‘Miller’);


-- function 2 declaration

CREATE OR REPLACE FUNCTION player_weight_var (tid VARCHAR, yr INTEGER) 
RETURNS FLOAT AS $$
DECLARE
   
BEGIN

END;
$$ LANGUAGE plpgsql;



