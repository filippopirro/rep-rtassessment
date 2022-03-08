curl -X "POST" "http://0.0.0.0:8088/query" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d $'{
  "ksql": "
CREATE TABLE rounds AS
	SELECT
		COALESCE(rs.created_timestamp, rs.created_timestamp) AS created_timestamp,
		COALESCE(rs.game_instance_id, cs.game_instance_id) AS game_instance_id,
		COALESCE(rs.user_id, cs.user_id) AS user_id,
		COALESCE(rs.game_id, cs.game_id) AS game_id,
		COALESCE(rs.real_amount_bet, 0) + COALESCE(cs.real_amount_bet, 0)
		COALESCE(rs.bonus_amount_bet, 0) + COALESCE(cs.bonus_amount_bet, 0), 
		COALESCE(rs.real_amount_win, 0) + COALESCE(cs.real_amount_win, 0),
		COALESCE(rs.bonus_amount_win, 0) + COALESCE(cs.bonus_amount_win, 0),
		COALESCE(rs.game_name, cs.game_name) AS game_name,
		COALESCE(rs.provider, cs.provider) AS provider
	FROM
		rounds_staging rs
		FULL OUTER JOIN
		corrections_staging cs
			ON rs.game_instance_id
	EMIT CHANGES;",
  "streamsProperties": {}
}'
