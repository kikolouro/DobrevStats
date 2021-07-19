FROM python:3.8

RUN apt-get update

RUN apt-get install git

ARG ENV
RUN echo $ENV
RUN if [ "x$ENV" = "xdev" ] ; then git clone --recursive --branch development https://github.com/kikolouro/DobrevStats /app ; else git clone --recursive https://github.com/kikolouro/DobrevStats /app ; fi

#RUN git clone --recursive https://github.com/kikolouro/DobrevStats /app

COPY ./config_GENERIC.yml /app/bots/config.yml
WORKDIR /app/bots

RUN pip3 install -r requirements.txt

RUN chmod +x ./start.sh

CMD ["./start.sh"]