curl -X "POST" "http://0.0.0.0:8088/query" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d $'{
  "ksql": "
CREATE TABLE rounds_staging (
	created_timestamp TIMESTAMP,
	game_instance_id BIGINT,
	user_id VARCHAR,
	game_id BIGINT,
	real_amount_bet DOUBLE,
	bonus_amount_bet DOUBLE,
	real_amount_win DOUBLE,
	bonus_amount_win DOUBLE,
	game_name VARCHAR,
	provider VARCHAR
) WITH (
	KAFKA_TOPIC = 'staging-bets',
	VALUE_FORMAT = 'AVRO'
);",
  "streamsProperties": {}
}'
