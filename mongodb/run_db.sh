#!/bin/bash
mongodb
mongoimport -h mongodb --db open5gs --collection subscribers --file /tmp/imsi1.json --type json --jsonArray
sleep infinity
