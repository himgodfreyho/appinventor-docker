FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	openjdk-7-jdk \
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

EXPOSE 8888