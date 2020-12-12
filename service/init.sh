#!/bin/bash
echo "start"

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

rabbitmqadmin --host=rabbitmq --port=15672 --username=admin --password=test list connections

echo "stop"
exit 0