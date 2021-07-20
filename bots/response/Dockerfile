FROM ubuntu:20.04
ARG ENV
ADD ./bots/response/crontab /etc/cron.d/response-cron
RUN chmod 0644 /etc/cron.d/response-cron
RUN touch /var/log/cron.log
RUN apt-get update
RUN apt-get -y install cron git python3-pip
RUN echo "[+] RUNNING IN $ENV ENVIRONMENT"
RUN if [ "x$ENV" = "xdev" ] ; then git clone --single-branch --recursive --branch development https://github.com/kikolouro/DobrevStats /app ; else git clone --recursive https://github.com/kikolouro/DobrevStats /app ; fi
COPY ./bots/config.yml /app/bots/config.yml

COPY ./bots/response/script.sh /bot.sh
RUN chmod +x /bot.sh
WORKDIR /app/bots
RUN pip3 install -r requirements.txt
CMD cron && tail -f /var/log/cron.log