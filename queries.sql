-- shape of data
select count(*) as no_of_rows from matches;
select count(*) as no_of_columns from information_schema.columns where
table_name='mathes';

--viewing the data
select * from matches limit 5;
select * from deliveries limit 5;

--view selected columns
select date, team1, team2, winner from matches limit 5;

-- distinct values
SELECT COUNT(DISTINCT(player_of_match)) FROM matches;

select distinct on (season) * from matches order by season, date desc;

--Get details of top 5 matches which were won by maximum number of runs
select * from matches;
order by win_by_runs desc limit 5;

--Order the rows by city in which the match was played
select * from matches order by city limit 5;

--Find venue of 10 most recently played matches
select venue from matches order by date desc limit 10;


--case
--Return a column with comment based on total_runs
select batsman, total_runs,
case when total_runs=4 then 'Four'
     when total_runs=6 then 'six'
     when total_runs=1 then 'single'
     when total_runs=0 then 'duck'
end as howzthat
from deliveries;

--Data Aggregation
--What is the highest runs by which any team won a match
select max(win_by_runs) from matches;

--How many extra runs have been conceded in ipl
select sum(extra_runs) from deliveries;

--On an average, teams won by how many runs in ipl
select round(avg(win_by_runs),2) from matches;

--Filters
--How many extra runs were conceded in ipl by SK Warne
select sum(extra_runs) from deliveries where bowler='SK Warne';

--How many boundaries (4s or 6s) have been hit in ipl
select count(total_runs) from deliveries 
where total_runs=4 or total_runs=6;

--How many balls did SK Warne bowl to batsman SR Tendulkar
select count(*) from deliveries where batsman='SR Tendulkar' AND bowler = 'SK Warne';

--How many matches were played in the month of Apri
select count(*) from matches where extract(month from date)=4;

--How many matches were played in the March and June
select count(*) from matches where extract(month from date)=3 or extract(month from date)=6;

--Total number of wickets taken in ipl (count not null values)
select count(player_dismissed) as total_wickets
from deliveries
where player_dismissed is not null;

--Pattern Match
--How many batsmen have names starting with S
select count(distinct(batsman)) from deliveries
where batsman like 's%';

--How many teams have word royal in it (could be anywhere in the team name, any case)
select count(distinct(team1)) from matches where lower(team1) like '%royal%';


--Group by
Maximum runs by which any team won a match per season
select season, max(win_by_runs) from matches
group by season
order by season;

--Create score card for each match Id
select match_id, batting_team, batsman, sum(batsman_runs) from deliveries 
group by match_id, batting_team, batsman
order by match_id, batting_team;

--Total boundaries hit in ipl by each team
select batting_team, count(total_runs) as no_of_bounderies
from deliveries
where total_runs=4 or total_runs=6
group by batting_team
order by no_of_bounderies desc;

--Top 10 players with max boundaries (4 or 6)
select batsman, count(batsman_runs) from deliveries 
where batsman_runs=6 or batsman_runs=4
group by batsman 
order by count(batsman_runs) desc limit 10;

--Top 20 bowlers who conceded highest extra runs
select bowler, sum(extra_runs) as total_extra_runs
from deliverirs
group by bowler
order by total_extra_runs desc limit 20;

SELECT bowler, SUM(extra_runs) as total_extra_runs 
FROM deliveries 
GROUP BY bowler 
ORDER BY total_extra_runs DESC LIMIT 20;

--Top 10 wicket takers
select bowler, count(player_dismissed) as total_wickets from deliveries
where player_dismissed is not null
group by bowler
order by total_wickets desc limit 10; 



--Name and number of wickets by bowlers who have taken more than or equal to 100 wickets in ipl
select bowler, count(player_dismissed) as total_wickets
from deliveries
where player_dismissed is not null
group by bowler
having count(player_dismissed)>=100
order by total_wickets desc;

--Window Functions
--Top 2 player_of_the_match for each season

SELECT season, player_of_match, count 
FROM (SELECT row_number() OVER (partition by season) AS rn, * 
     FROM (SELECT season, player_of_match,COUNT(player_of_match) 
         FROM matches GROUP BY season, player_of_match 
         ORDER BY season ASC, count DESC)
     sub) 
sub1 
WHERE rn < 3;


--Join
--Combine column date from matches with table deliveries to get data by year
select d.*, m.id, m.date from deliveries d 
join matches m on m.id=d.match_id limit 2;


