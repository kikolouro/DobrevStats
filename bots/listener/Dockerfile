FROM python:3.8
ARG ENV

RUN apt-get update && apt-get install -y git
RUN echo $ENV
RUN echo "[+] RUNNING IN $ENV ENVIRONMENT"
RUN if [ "x$ENV" = "xdev" ] ; then echo "ASNJASJDNASJDASJDASNDJASNDJASNDJASNDJASDNJASDNSAJDNJASDNASJDNJASJASNDJASDAJ\n\n\n\n"; git clone --single-branch --recursive --branch development https://github.com/kikolouro/DobrevStats /app ; else git clone --recursive https://github.com/kikolouro/DobrevStats /app ; fi


WORKDIR /app/bots
RUN pip3 install -r requirements.txt
WORKDIR /app/bots/listener


RUN chmod +x ./start.sh
RUN ./start.sh