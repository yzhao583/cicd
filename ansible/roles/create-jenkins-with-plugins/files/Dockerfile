FROM jenkins:2.1

USER jenkins

COPY plugins.txt .
RUN /usr/local/bin/plugins.sh plugins.txt

# Now copy the complete repo including Pipeline script (not only the files needed to warm up the Maven cache).
RUN rm -rf repo-wc
ADD repo repo-wc
USER root
RUN chown -R jenkins.jenkins repo-wc
USER jenkins
RUN git init --bare repo && \
    cd repo-wc && \
    git init && \
    git add . && \
    git -c user.email=demo@jenkins-ci.org -c user.name="Pipeline Demo" commit -m 'demo' && \
    git push ../repo master && \
    cd .. && \
    rm -rfv repo-wc
# TODO deletion of repo-wc does not seem to work: claims to have been deleted, but then still there in subsequent steps; anyway it is small
# RUN ls -lRa; false

ADD JENKINS_HOME /usr/share/jenkins/ref

USER root
RUN chown -R jenkins.jenkins /usr/share/jenkins/ref
COPY run.sh jetty.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run.sh /usr/local/bin/jetty.sh

USER jenkins
CMD /usr/local/bin/run.sh

EXPOSE 8080 8081 9418
