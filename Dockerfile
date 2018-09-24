FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
	openjdk-7-jdk \
	ant \
	lib32z1 \
	lib32ncurses5 \
	lib32bz2-1.0 \
	lib32stdc++6 \
	git

COPY appengine-java-sdk-1.9.64 /root/appengine-java-sdk-1.9.64 

ENV PATH="$PATH:/root/appengine-java-sdk-1.9.64/bin/"

RUN cd /root

EXPOSE 8888