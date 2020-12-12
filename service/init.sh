#!/bin/bash
echo "start"

# Exit immediately if any command exits with a non-zero status
set -e

maxAttempts=20

for (( i=1 ; i<=maxAttempts ; i++ ));
do
  rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD show overview
  if [ $? -eq 0 ]; then
      echo "connect to rabbitmq [$i/10]"
      break
  else
      echo "cannot connect to rabbitmq [$i/10]"
  fi

  if [ $i -eq $maxAttempts ]; then
    exit 1
  fi

  sleep 2
done

rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD import /rabbitmq_config/queue_test.json
rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD import /rabbitmq_config/queue_test2.json
rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD import /rabbitmq_config/exchange_test.json
rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD import /rabbitmq_config/binding_test.json
rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD publish routing_key="" exchange=test payload="test_message"

echo "actual configuration:"
rabbitmqadmin --host=$RABBITMQ_HOSTNAME --port=$RABBITMQ_PORT --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD export rabbit_conifg
cat rabbit_conifg
echo ""

echo "finish"
exit 0