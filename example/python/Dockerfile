FROM ubuntu:18.04
RUN apt-get update 
RUN apt-get install -y python3 python3-jwt
COPY webserver.py /
ENV GATEHOUSE_URL=http://localhost:9998
CMD [ "python3", "/webserver.py" ]
