#Docker App Inventor
1. Install Docker on your computer: <href="https://www.docker.com">https://www.docker.com</href>
- After installation, you should be able to run `docker` command on your command line tool.
- Open command line tool, change the current directory consisting the Dockerfile.
- Run ``docker build .``. This will build an App Inventor image with all dependencies based on Ubuntu 14.04. It might take 3-10 minutes, as it will install a few packages.
- If success, you should see something like this:

```
Step 5/5 : EXPOSE 8888
---> Running in 563dcb472750
Removing intermediate container 563dcb472750
 ---> b09dfafffa70
Successfully built b09dfafffa70
```
- Run 

```docker run -it -v /Users/hoyikhim/Development/appinventor-extensions-wency/appinventor/:/root/appinventor/ b09dfafffa70```