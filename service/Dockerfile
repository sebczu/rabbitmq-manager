FROM rabbitmq:3.8.9-management

COPY /init.sh /init.sh
RUN chmod 777 /init.sh
COPY /rabbitmq_config /rabbitmq_config

CMD ["/init.sh"]