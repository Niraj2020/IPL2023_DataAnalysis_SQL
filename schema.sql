create database ipl;
use ipl;

CREATE TABLE matches (id integer auto_increment primary key,
  season integer,
  city varchar(255),
  date date,
  team1 varchar(255), 
  team2 varchar(255), 
  toss_winner varchar(255), 
  toss_decision varchar(255), 
  result varchar(255), 
  dl_applied integer, 
  winner varchar(255), 
  win_by_runs integer, 
  win_by_wickets integer, 
  player_of_the_match varchar(255), 
  venue varchar(255), 
  umpire1 varchar(255), 
  umpire2 varchar(255), 
  umpire3 integer
);

CREATE TABLE deliveries (
  matchid integer auto_increment primary key, 
  inning integer, 
  batting_team varchar(255), 
  bowling_team varchar(255), 
  Overs integer, 
  ball integer, 
  batsman varchar(255), 
  non_striker varchar(255), 
  bowler varchar(255), 
  is_super_over integer, 
  wide_runs integer, 
  bye_runs integer, 
  legbye_runs integer, 
  noball_runs integer, 
  penalty_runs integer, 
  batsman_runs integer, 
  extra_runs integer, 
  total_runs integer, 
  player_dismissed varchar(255), 
  dismissal_kind varchar(255), 
  fielder varchar(255)
);

select * from matches;
show databases;
use ipl;

select * from deliveries;







