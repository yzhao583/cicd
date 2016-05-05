FROM jenkins:2.0

USER jenkins

COPY plugins.txt .
RUN /usr/local/bin/plugins.sh plugins.txt


EXPOSE 8080 8081 9418
