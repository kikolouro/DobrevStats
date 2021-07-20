FROM python:3.8
ARG ENV

RUN apt-get update && apt-get install -y git cron

ADD crontab /etc/cron.d/response-cron
RUN chmod 0644 /etc/cron.d/response-cron
RUN echo "[+] RUNNING IN $ENV ENVORIMENT"
RUN if [ "x$ENV" = "xdev" ] ; then git clone --recursive --branch development https://github.com/kikolouro/DobrevStats /app ; else git clone --recursive https://github.com/kikolouro/DobrevStats /app ; fi

RUN touch /var/log/cron.log
COPY ./bots/config.yml /app/bots/config.yml
WORKDIR /app/bots

RUN pip3 install -r requirements.txt

RUN chmod +x ./start.sh
CMD cron && tail -f /var/log/cron.log && ./start.sh