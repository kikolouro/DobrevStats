FROM ubuntu:20.04
ADD crontab /etc/cron.d/response-cron
RUN chmod 0644 /etc/cron.d/response-cron
RUN touch /var/log/cron.log
RUN apt-get update
RUN apt-get -y install cron
RUN pip3 install -r /ext/requirements.txt
CMD cron && tail -f /var/log/cron.log