FROM dockerfile/java:oracle-java7
MAINTAINER Oleg Yashchuk <oazoer@gmail.com>

ENV ES_VERSION 1.4.1
WORKDIR /

# Download and unpack elasticsearch
RUN \
  wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz -O - | tar zxvf - && \
  mv /elasticsearch-$ES_VERSION /elasticsearch

ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN \
   cd /elasticsearch && \
   bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data", "/logs"]

EXPOSE 9200 9300

CMD ["elasticsearch/bin/elasticsearch"]
