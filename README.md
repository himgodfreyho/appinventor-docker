#Docker App Inventor
1. Install Docker on your computer: <href="https://www.docker.com">https://www.docker.com</href>
- After installation, you should be able to run `docker` command on your command line tool.
- Open command line tool, change the current directory consisting the Dockerfile.
- Run ``docker build .``. This will build an App Inventor image with all dependencies based on Ubuntu 14.04. It might take 3-10 minutes, as it will install a few packages (depending on the speed of your computer and the network).
- If success, you should see something like this:

```
Step 5/5 : EXPOSE 8888
---> Running in 563dcb472750
Removing intermediate container 563dcb472750
 ---> b09dfafffa70
Successfully built b09dfafffa70
```

Note the container ID at the message `Successfully built XXX`. In the above example, the container ID is b09dfafffa70. NOTE THAT every time you build the container, the container ID will be different.

###To start the docker container:
When you start the container, you need to copy the source from your host computer into the container. The command is:

```docker run -it -v YOUR_APP_INVENTOR_SOURCES_FULL_PATH:/root/appinventor/ -p 127.0.0.1:8888:8888 b09dfafffa70```

For example, my App Inventor source code is at */Users/hoyikhim/Development/appinventor-source/*: 

```docker run -it -v /Users/hoyikhim/Development/appinventor-source/:/root/appinventor-sources/ -p 127.0.0.1:8888:8888 b09dfafffa70```

<!--
docker run -it -v /Users/hoyikhim/Development/appinventor-extensions-wency/:/root/appinventor-sources/ -p 127.0.0.1:8888:8888 e2fbf9e2e81d
-->


After running the command, you started the container, and also logged in to the container environment (similar to SSH into a VM).
###