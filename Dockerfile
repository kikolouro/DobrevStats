FROM python:3.8

RUN apt-get update

RUN apt-get install git

RUN git clone --recursive https://github.com/kikolouro/DobrevStats /app

WORKDIR /app/listener

RUN pip3 install -r requirements.txt

ENTRYPOINT ["/start.sh"]