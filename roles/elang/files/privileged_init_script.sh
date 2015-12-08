
rabbitmqctl stop_app
rabbitmqctl join_cluster rabbit@bunny1
rabbitmqctl start_app

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"password":"!admini+","tags":"administrator"}' \
 http://localhost:8080/api/users/admin

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"password":"!monitoring+","tags":"monitoring"}' \
 http://localhost:8080/api/users/monitor

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"password":"!producing+","tags":""}' \
 http://localhost:8080/api/users/producer

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"password":"!consuming+","tags":""}' \
 http://localhost:8080/api/users/consumer

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"password":"!showme+","tags":"monitoring"}' \
 http://localhost:8080/api/users/view


curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"configure":".*","read":".*","write": ".*"}' \
 http://localhost:8080/api/permissions/%2F/admin

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"configure": "","read": ".*","write": ".*"}' \
 http://localhost:8080/api/permissions/%2F/monitor

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"configure": "","read": "","write": ".*"}' \
 http://localhost:8080/api/permissions/%2F/producer

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"configure": ".*","read": ".*","write": ""}' \
 http://localhost:8080/api/permissions/%2F/consumer

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"configure": "","read": ".*","write": ".*"}' \
 http://localhost:8080/api/permissions/%2F/view

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"pattern":"^sapi","definition":{"ha-mode":"all","ha-sync-mode":"automatic"}}' \
  http://localhost:8080/api/policies/%2F/ha-sapi


curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.direct
curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.fanout
curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.headers
curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.match
#curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.rabbitmq.log
#curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.rabbitmq.trace
curl -i -u guest:guest -XDELETE http://localhost:8080/api/exchanges/%2f/amq.topic

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"type":"fanout","auto_delete":false,"durable":true,"internal":false,"arguments":[]}' \
 http://localhost:8080/api/exchanges/%2f/sapi-async-exchange-alternate

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"type":"direct","auto_delete":false,"durable":true,"internal":false,"alternate-exchange":"sapi-async-exchange-alternate","arguments":{"alternate-exchange":"sapi-async-exchange-alternate"}}' \
 http://localhost:8080/api/exchanges/%2f/sapi-async-exchange

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"auto_delete":false,"durable":true,"arguments":[],"node":"rabbit@bunny1"}' \
 http://localhost:8080/api/queues/%2F/sapi-async

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"auto_delete":false,"durable":true,"arguments":[],"node":"rabbit@bunny1"}' \
 http://localhost:8080/api/queues/%2F/sapi-async-unrouted

curl -i -u guest:guest -H "content-type:application/json" \
 -XPOST -d'{"routing_key":"sapi-async","arguments":[]}' \
 http://localhost:8080/api/bindings/%2F/e/sapi-async-exchange/q/sapi-async

curl -i -u guest:guest -H "content-type:application/json" \
 -XPOST -d'{"routing_key":"","arguments":[]}' \
 http://localhost:8080/api/bindings/%2F/e/sapi-async-exchange-alternate/q/sapi-async-unrouted

curl -i -u guest:guest -XDELETE http://localhost:8080/api/bindings/%2F/e/sapi-async-exchange/q/sapi-async/sapi-async

curl -i -u guest:guest -H "content-type:application/json" \
 -XPOST -d'{"properties":{"delivery_mode":2},"routing_key":"sapi-async","payload":"my body 1","payload_encoding":"string"}' \
 http://localhost:8080/api/exchanges/%2F/sapi-async-exchange/publish

curl -i -u guest:guest -H "content-type:application/json" \
 -XPOST -d'{"routing_key":"sapi-async","arguments":[]}' \
 http://localhost:8080/api/bindings/%2F/e/sapi-async-exchange/q/sapi-async

curl -i -u guest:guest -H "content-type:application/json" \
 -XPOST -d'{"properties":{"delivery_mode":2},"routing_key":"sapi-async","payload":"my body 2","payload_encoding":"string"}' \
 http://localhost:8080/api/exchanges/%2F/sapi-async-exchange/publish
 