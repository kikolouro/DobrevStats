FROM python:3.8

RUN apt-get update

RUN apt-get install git

RUN git clone --recursive https://github.com/kikolouro/DobrevStats /app

COPY ./config_GENERIC.yml /app/bots/config.yml
WORKDIR /app/bots

RUN pip3 install -r requirements.txt

RUN chmod +x ./start.sh

CMD ["./start.sh"]