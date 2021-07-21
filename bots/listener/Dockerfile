FROM python:3.8
ARG ENV

RUN apt-get update && apt-get install -y git
RUN echo "[+] RUNNING IN $ENV ENVIRONMENT"
RUN if [ "x$ENV" = "xdev" ] ; then git clone --single-branch --recursive --branch development https://github.com/kikolouro/DobrevStats /app ; else git clone --recursive https://github.com/kikolouro/DobrevStats /app ; fi


WORKDIR /app/bots
RUN pip3 install -r requirements.txt
WORKDIR /app/bots/listener
COPY ./bots/config.yml /app/bots/config.yml
RUN chmod +x ./start.sh
ENTRYPOINT ["./start.sh"]