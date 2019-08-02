# Ambari installation documentation:
# https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.7.3
# https://cwiki.apache.org/confluence/display/AMBARI/Ambari+Development
FROM debian:stable

COPY sources.list.d/ /etc/apt/sources.list.d
COPY preferences.d/ /etc/apt/preferences.d

# Step 1: Download and build Ambari 2.7.3 source
RUN apt-get update \
    && apt-get install -y \
        gcc \
        git \
        wget \
        maven \
        bzip2 \
        python \
        python-dev \
        # Java 8 is installed from unstable
        openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists

RUN wget http://www.apache.org/dist/ambari/ambari-2.7.3/apache-ambari-2.7.3-src.tar.gz \
    && tar xfvz apache-ambari-2.7.3-src.tar.gz
WORKDIR apache-ambari-2.7.3-src
# This http -> https substitution should apply this patch:
#   https://github.com/apache/ambari/pull/3043/commits/aa17909031bddaea31d3745eecd2d59694ba87a2#diff-e27e4810555fd794a37a7fa3672e3ee4
RUN sed -i -re "s/http:(.*nexus-private.*)/https:\1/" ambari-metrics/pom.xml
RUN mvn versions:set -DnewVersion=2.7.3.0.0
RUN cd ambari-metrics \
    && mvn versions:set -DnewVersion=2.7.3.0.0 \
    && cd -
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
RUN mvn -B clean install jdeb:jdeb -DnewVersion=2.7.3.0.0 -DbuildNumber=4295bb16c439cbc8fb0e7362f19768dde1477868 -DskipTests -Dpython.ver="python >= 2.6"

# Step 2: Install Ambari Server
# This should also pull in postgres packages and cURL as well.
RUN apt-get update \
    && apt-get install -y expect ./ambari-server/target/*.deb \
    && rm -rf /var/lib/apt/lists

## Step 3: Setup Ambari Server
COPY setup-server setup-server
RUN ./setup-server

ENTRYPOINT ambari-server start