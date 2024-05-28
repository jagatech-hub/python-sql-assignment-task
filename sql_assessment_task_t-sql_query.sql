 -- T-SQL query serves the purpose of identifying clashes for each trainer based on their class schedules. 
WITH CTE_Clash AS (
    SELECT 
        A1.trainerid,
        A1.starttime AS class_starttime,
        A1.endtime AS class_endtime,
        A2.starttime AS conflicting_starttime,
        A2.endtime AS conflicting_endtime,
        row_number() over (partition by A1.trainerid order by A1.starttime, A1.endtime) rn
    FROM 
        TableA A1,TableA A2 
		WHERE A1.trainerid = A2.trainerid
                 AND A1.starttime < A2.endtime
                 AND A1.endtime > A2.starttime
                 AND A1.starttime <> A2.starttime
)
SELECT DISTINCT 
    c.trainerid,
    c.class_starttime,
    c.class_endtime,
    c.conflicting_starttime,
    c.conflicting_endtime
FROM 
    CTE_Clash c
where rn > 1