curl -X "POST" "http://0.0.0.0:8088/query" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d $'{
  "ksql": "
CREATE TABLE rounds_agg AS
	SELECT
		LEFT(created_timestamp, 13) AS date_hour,
		game_id,
		game_name,
		SUM(real_amount_bet) AS real_amount_bet,
		SUM(bonus_amount_bet) AS bonus_amount_bet,
		SUM(real_amount_win) AS real_amount_win,
		SUM(bonus_amount_win) AS bonus_amount_win
	FROM
		rounds
	GROUP BY
		LEFT(created_timestamp, 13) AS date_hour,
		game_id,
		game_name
	EMIT CHANGES;",
  "streamsProperties": {}
}'
