#!/bin/bash

docker volume rm $(docker volume ls -qf dangling=true)

docker-compose -f docker-compose.yml up -d
sleep 40

docker cp /dev/docker_input_dir/part1_gameround.csv nifi:/opt/nifi/part1_gameround.csv
docker cp /dev/docker_input_dir/part2_gameround.csv nifi:/opt/nifi/part2_gameround.csv

sleep 5 

docker exec kafka kafka-topics --bootstrap-server kafka:9092 --create --topic staging-bets
docker exec kafka kafka-topics --bootstrap-server kafka:9092 --create --topic staging-corrections
sleep 5

#docker ps -a
docker ps

