FROM ubuntu:14.04

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install -y \
	wget \
	unzip \
	openjdk-8-jdk \
	ant \
	lib32z1 \
	lib32ncurses5 \
	lib32bz2-1.0 \
	lib32stdc++6 \
	git


RUN wget -O /tmp/appengine.zip https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.66.zip

RUN unzip /tmp/appengine.zip -d /root && rm /tmp/appengine.zip

COPY startserver.sh /root/scripts/

RUN chmod +x /root/scripts/startserver.sh

ENV PATH="$PATH:/root/appengine-java-sdk-1.9.66/bin/"

ENV PATH="$PATH:/root/scripts/"

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

ENV PATH="$PATH:$JAVA_HOME/bin"

WORKDIR /root/

EXPOSE 8888

