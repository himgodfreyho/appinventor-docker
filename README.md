
# App Inventor Docker
This repo contains a ready-to-use Dockerfile to help you build an App Inventor server docker image. 

### Build and run by Dockerfile

To build the image, simply run:

```
docker build .
``` 
(Do not miss the dot at the end!)

You may give the image an easy-to-remember tag by the ``-t`` option.

```
docker build -t appinventorserver .
``` 
(Do not miss the dot at the end!)

After the image is built, you can log on to the container by:

```
docker run -it -p 8888:8888 -v "YOUR_APP_INVENTOR_PARENT_FOLDER_FULL_PATH:/root/appinventor-sources/" appinventorserver
```
The ``-p 8888:8888`` option forwards your 8888 port to the container 8888 port, so that you can access it at http://localhost:8888 on your host computer. (Host computer is the machine you are using, e.g., your Windows or Mac computer) 

The ``-v "YOUR_APP_INVENTOR_PARENT_FOLDER_FULL_PATH:/root/appinventor-sources/"`` option mounts the source code at your host computer to the container. The reason is that normally we shall use our favorite IDE to change the source code on our host computer. By mounting the source code as a volume, any changes to the source code will be synced to the container.

### Build and run by docker-compose
Alternatively, you can use docker-compose to build and run the container. The benefit is that you don't need to memorize the run command and the options. You can save it to the *docker-compose.yml* file. You may refer to *docker-compose.yml.example*.

Change *YOUR\_APP\_INVENTOR\_PARENT\_FOLDER\_FULL\_PATH* to the path of your source code.
For example,

```
    volumes:
     - /Users/macuser/Development/appinventor-sources:/root/appinventor-sources

```
To build and run:

```
docker-compose up -d
```
It should say:

```
Starting appinventor-docker_appinventorserver_1 ... done
```
Note the container name. In this case, the name is *appinventor-docker\_appinventorserver\_1*. You can also run ``docker container ls`` to check the name of all your containers. 

To log on to the container, use ``docker exec -it <CONTAINER_NAME> /bin/bash``. For example:

```
docker exec -it appinventor-docker_appinventorserver_1 /bin/bash
```

Follow the setup instructions at https://github.com/mit-cml/appinventor-sources.

### Starting the server
After logged on to the container, to start the server, you normally run

```
YOUR_APPENGINE_SDK_FOLDER/bin/dev_appserver.sh --port=8888 --address=0.0.0.0 appengine/build/war/
```
Alternatively, a *startserver.sh* script is prepared for you and added to the PATH, so that you do not need to memorize the path of your appengine SDK folder. You can simply run this command in your container (i.e., after you execute ``docker exec -it appinventor-docker_appinventorserver_1 /bin/bash``)

```
startserver.sh
```

The server should start within a few minutes, and say:

```
INFO: Dev App Server is now running
```

Now you can open it at http://localhost:8888/ on your browser.

# App Inventor Development
This section contains detailed instructions on how to set up an App Inventor server using Docker and how to develop App Inventor blocks.

The objective of this tutorial is to help you set up a local App Inventor server and to add new blocks to App Inventor.

Before you start, you should be familiar with the following:

1. The basic operation of command line tools, either Linux or Windows
2. Git
    - Git command
    - Github
    - Using Git for development (e.g., Git flow, Github flow)
    - How to do version control using Git 
    - You can use some of the Git GUI tools instead of the Git command line to manage the source code
3. The concept of software development, e.g., local environment, compiling, running a local server, testing, automated testing
4. Java programming
5. Java IDE


## 1. Get started
1. Install Git on your computer at https://git-scm.com/download
1. Read the instructions carefully at https://github.com/mit-cml/appinventor-sources.
2. You need to set up a local App Inventor server on your computer and run the source code on your computer.
3. For setup, you can follow the above instructions on MIT Github. Alternatively, we have prepared a Docker version for you.

### 1.1 Using Docker to set up an App Inventor server on your local computer

**If you do not want to use Docker, you can always set up a server on your Window, Mac or Linux computer. Follow the setup instructions at https://github.com/mit-cml/appinventor-sources and https://docs.google.com/document/pub?id=1Xc9yt02x3BRoq5m1PJHBr81OOv69rEBy8LVG_84j9jc.** 

1. Install Docker on your computer: https://www.docker.com
2. After installation, start the Docker demon by clicking Docker.exe on Windows or Docker app on Mac. 
    ![](https://i.imgur.com/3TCv04h.png) ![](https://i.imgur.com/nwLnhfD.png)

    Make sure the Docker demon is running. Check your status bar. 
    ![](https://i.imgur.com/Mk5r6Rg.png) ![](https://i.imgur.com/fYHiq3M.png) 
    


3. Then open your command line tool. You should be able to run 
    
    ```
    docker
    ```

4. Download the Dockerfile prepared for you at https://github.com/himgodfreyho/appinventor-docker.
5. Unzip the file.
6. Open command line tool, change the current directory where the Dockerfile is located.
7. Run 

    ```
    docker build -t appinventorserver .
    ``` 
    (Do not miss the dot at the end!)
    
     This will build an App Inventor image with all the dependencies based on Ubuntu 14.04. It can take from 3 to 10 minutes (depending on the configuration of your computer and the speed of the network).
     
     While you are waiting, you can start downloading the source code of App Inventor first by following the instructions at Section 1.2.
5. If it is built successfully, you should see something like this:

```
...
Removing intermediate container 563dcb472750
 ---> b09dfafffa70
Successfully built 0bbb2254e236
Successfully tagged appinventorserver:latest
```

Note the container ID from the message: `Successfully built 0bbb2254e236 `. In the above example, the container ID is _0bbb2254e236_. And we have given it a name _appinventorserver_.

### 1.2 Download the source code of App Inventor
1. Download the source code to your preferred directory by opening the command line tool and typing:
    (Note that you should do it on your host computer.)
    ```
    git clone https://github.com/mit-cml/appinventor-sources.git
    ```
2. The *appinventor parent folder* is the directory containing the following folder and files:

    ![](https://i.imgur.com/pnLeTc9.png)

3. The *appinventor-sources folder* is the directory containing the following folders and files:
    ![](https://i.imgur.com/zQOI3Lr.png)
    

4. After cloning, go to *appinventor-sources* (``cd appinventor-sources``) and type the following commands:

    
```
git submodule update --init
```

### 1.3 To start the docker container
You can change the CPU and memory resources for your Docker container, depending on the specifications of your computer. Generally, we recommend assigning half of your CPU cores and memories for Docker so that it will not affect the performance of your host computer.

![](https://i.imgur.com/kJCqQQS.png)

When you start the container, you need to copy the source code (the *appinventor parent folder*) as a mounted volume from your host computer into the container. The command for start and mount is:


``` 
docker run -it -v "YOUR_APP_INVENTOR_PARENT_FOLDER_FULL_PATH:/root/appinventor-sources/" -p 8888:8888 appinventorserver
```
(Don't miss the double quote on the path.)

For example, on Mac if the App Inventor parent folder is at */Users/macuser/Development/appinventor-source/*, the command will be:

```
docker run -it -v "/Users/macuser/Development/appinventor-source/:/root/appinventor-sources/" -p 127.0.0.1:8888:8888 appinventorserver
```

On Windows, if the App Inventor parent folder is at *C:\Users\Win User\Downloads\appinventor-sources-master/*, the command will be: 

```
docker run -it -v "C:\Users\Win User\Downloads\appinventor-sources-master/:/root/appinventor-sources/" -p 127.0.0.1:8888:8888 appinventorserver
```

You may be asked to enter the User's password on the Windows computer for granting share folder right.

After running the command, the container should start, and you have logged into the container environment.

Type ``ls`` and you should see that the appinventor-sources folder is mounted.

## 2. Build your source code
For details, read the instruction carefully at https://github.com/mit-cml/appinventor-sources. 

**For the first-time setup** you need to run the following commands: (Note that if you are using Docker, make sure you are working in the container environment instead of your host computer.)

1. ``cd appinventor``
2. ``ant MakeAuthKey``

To build the source code, at the *appinventor-sources/appinventor* directory run

```
ant
```


If you are using my Docker image, a script has been prepared for you to start the server, you just need to type

```
startserver.sh
```

After a few minutes, you should see: 

```
...
INFO: The admin console is running at http://localhost:8888/_ah/admin
Oct 12, 2018 5:11:54 AM com.google.appengine.tools.development.DevAppServerImpl doStart
INFO: Dev App Server is now running
```

The App Inventor server is now started. Open the browser and go to http://localhost:8888, you should see your local version of App Inventor.

![](https://i.imgur.com/cIYlcOg.png)

Click <u>Click Here to use your Google Account to login</u>, then click Login. **Leave the email "test@example.com" unchanged!**
![](https://i.imgur.com/HbcIFK3.png)

## 3. Modifying the source code
You can use any IDE you are familiar with to edit the source code.

If you are using Docker, you should edit the source code on your host computer, and then build and run the source code in the Docker container.

Every time you have changed the code, you may need to re-build it. To speed up the development process, see <a href="https://docs.google.com/document/d/1sAw0QObTxTWqRX7GQRCa2z9TIV2r5AKT9UKMFF1acZI/pub#h.e5ttjsa1wtlw">https://docs.google.com/document/d/1sAw0QObTxTWqRX7GQRCa2z9TIV2r5AKT9UKMFF1acZI/pub#h.e5ttjsa1wtlw</a>

## 4. Exercise: Creating a block
Referring to the following application, when a user shakes his/her phone, the phone will say a message using the Text-to-Speech function. 

![](https://i.imgur.com/PwQ069F.png)

In this exercise, we are going to combine the blocks into one block.

The source code of the component are located at *appinventor-sources/appinventor/components/src/com/google/appinventor/components/runtime*. 

Open *AccelerometerSensor.java*, you can see the source code of the block. ![](https://i.imgur.com/hDrIvbQ.png)

If we need to use the Text-to-Speech function, we should import the TextToSpeech class. At line 21, add: 

```java
import com.google.appinventor.components.runtime.TextToSpeech;
```
![](https://i.imgur.com/h1Oxkct.png)

At line 130, add ``private ComponentContainer container;`` to define a private variable for the container instance.

![](https://i.imgur.com/lmZnOz1.png)

At line 140, add 

```java
this.container = container;
```
![](https://i.imgur.com/UpMsdt4.png)

At line 275: add: 

```java
  /**
   * Indicates the device started being shaken, and say Hello to the user.
   */
  @SimpleEvent
  public void ShakeToSayHello() {
    TextToSpeech textToSpeech = new TextToSpeech(this.container);
    textToSpeech.Speak("Hello");
    EventDispatcher.dispatchEvent(this, "Shaking");
  }
```
![](https://i.imgur.com/rXKI14C.png)

Finally, after adding a new block, we need to add the definition to the Block editor. Open *OdeMessages.java* at *appinventor-sources/appinventor/appengine/src/com/google/appinventor/client*. Add these lines at the end of the file.

```java
  @DefaultMessage("ShakeToSayHello")
  @Description("")
  String ShakeToSayHelloEvents();
```

 ![](https://i.imgur.com/2mC3q9Q.png).
 
 Go to the command line tool and type:
 
 ```
 ant
 ```
 to build the code.
 
 After building it successfully, type:
 
 ```
 startserver.sh
 ```
 to start the server.

Go to http://localhost:8888, you should see the block you have added.
![](https://i.imgur.com/KqOjIPp.png)

(Although it might seem combining shaking and text-to-speech into one block is not very useful to users, the primary purpose of this exercise is letting you know how to build your own block, and know what is the concept behind when building App Inventor block.)

For details, you can refer to https://docs.google.com/document/d/1CNNT5MSzRR7vrHPOGNVxtV3GqWqx29wtLv1QfHosvqk/

**Remember to update the apk every time you have changed the code by copying the apk to your phone manually using a USB cable and installing it.**

## 5. Points to note
1. If you see errors during compiling, it is highly possible that there are bugs or errors in your newly modified codes! If this is not the case, try ``ant clean`` before compiling.
2. If you cannot see App Inventor on your browser, try clearing the cache of your browser. Also, you might try using the private mode.

    ![](https://i.imgur.com/k4nCkic.png)
    
    ![](https://i.imgur.com/7rgQSHO.png)


3. If you cannot see the changes on your browser after the codes are compiled successfully, try clearing the cache of your browser.
4. Make good use of Git version control to keep track of what you have changed. 
5. Write meaningful commit messages.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTY5ODA4NzExOF19
-->