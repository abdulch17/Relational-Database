#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE games,teams")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do 
if [[ $WINNER != winner ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

if [[ -z $WINNER_ID ]] 
then
INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

if [[ $INSERT_TEAM == "INSERT 0 1" ]]
then
echo Inserted into teams, $WINNER
fi
fi
fi

if [[ $OPPONENT != opponent ]]
then
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

if [[ -z $OPPONENT_ID ]]
then
INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
if [[ $INSERT_TEAM == "INSERT 0 1" ]]
then
echo Inserted into teams, $OPPONENT
fi
fi
fi
done

echo $($PSQL "TRUNCATE games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do 
if [[ $YEAR != year ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
INSERT_MATCH=$($PSQL "INSERT INTO GAMES(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
if [[ $INSERT_MATCH == "INSERT 0 1" ]]
then
echo Inserted into teams 
fi
fi 
done

