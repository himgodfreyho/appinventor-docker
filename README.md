#Docker App Inventor
1. Install Docker on your computer: https://www.docker.com
2. After installation, you should be able to run 
	
	```
	docker
	```

	command on your command line tool.
- Open command line tool, change the current directory consisting the Dockerfile.
- Run 

	```
	docker build -t appinventorserver .
	``` 
	(Do not miss the dot at the end!)
	
	 This will build an App Inventor image with all dependencies based on Ubuntu 14.04. It can take from 3 to 10 minutes (depending on the specs of your computer and the speed of the network).
- If success, you should see something like this:

	```
...
Removing intermediate container 563dcb472750
 ---> b09dfafffa70
Successfully built 0bbb2254e236
Successfully tagged appinventorserver:latest
```

Note the container ID from the message: Successfully built 0bbb2254e236. In the above example, the container ID is 0bbb2254e236. And we have gave it a name appinventorserver.

###To start the docker container:
When you start the container, you need to copy the source from your host computer into the container. The command is:

```docker run -it -v "YOUR_APP_INVENTOR_SOURCES_FULL_PATH:/root/appinventor/" -p 127.0.0.1:8888:8888 appinventorserver ```

For example, my App Inventor source code is at */Users/hoyikhim/Development/appinventor-source/*: 

```docker run -it -v "/Users/hoyikhim/Development/appinventor-source/:/root/appinventor-sources/" -p 127.0.0.1:8888:8888 appinventorserver ```

<!--
docker run -it -v "/Users/hoyikhim/Development/appinventor-extensions-wency/:/root/appinventor-sources/" -p 127.0.0.1:8888:8888 appinventorserver
-->


After running the command, you started the container, and also logged in to the container environment (similar to SSH into a VM).

### Build you source code
For details, follow the instruction on <a href="https://github.com/mit-cml/appinventor-sources">https://github.com/mit-cml/appinventor-sources</a>. 

Generally, **for first time setup** you need to:

1. ``cd ~/appinventor-sources``
2. ``git submodule update --init``
3. ``cd appinventor``
4. ``ant MakeAuthKey``

To build the source code, at the *appinventor-sources/appinventor* directory run

``ant``


I have also prepared a script for you to start the server, you just need to type

``startserver.sh``
	
And the App Inventor server will start.

###