FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
	curl \
	unzip \
	openjdk-7-jdk \
	ant \
	lib32z1 \
	lib32ncurses5 \
	lib32bz2-1.0 \
	lib32stdc++6 \
	git

# RUN curl 'https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.65.zip' > /tmp/appengine.zip %% unzip -d /root /tmp/appengine.zip && rm /tmp/appengine.zip

COPY appengine-java-sdk/appengine-java-sdk-1.9.65 /root/appengine-java-sdk-1.9.65

ENV PATH="$PATH:/root/appengine-java-sdk-1.9.65/bin/"

EXPOSE 8888

RUN cd /root