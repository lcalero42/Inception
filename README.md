*This project has been created as part of the 42 curriculum by lcalero*

## Description 📋

This project called *Inception* is intended to teach the **basics of *docker*** and understand its use by building a **basic docker architecture** and **environment**.
First, the project asks us to build and configure **different mandatory communicating services**, each one running in a **container** :</n>
- nginx
- wodpress
- mariadb</n>

Then, we need to add ***docker volumes*** to have **permanant storage** but we also need to add a ***docker network*** to make the containers **communicate between each other**

## Instruction ✉️

1. To setup this project, first **clone the repository** with : ```git clone <url>```
2. Then, to be able to run the **containers**, you will have to create **multiple secret files** in a secrets folder at the root of the repository *(to keep your passwords safe and to not put them directly in the .env)* : credentials.txt, db_password.txt, db_root_password.txt
3. Then, the last step is to setup locally where the **volumes** will be **binded**. Here, the subject requires to **store our volumes** in *"home/login/data"*, so we need to create two folders at this location :
*wordpress* and *mariadb*
4. To finish, you should be able after these steps to run ```make up``` to **build the images** and **run the containers**

## Project Description 📝

In this project, we use ***docker*** to build a **healthy architecture** to make **communicate multiple services together** each one having its **dedicated container**. Docker is very useful because first, it **helps you working with your team** because everyone has the **exact same environment** (and we know that environment issues can cause a lot of headaches in this indusrty). It was by the way, the first intent by the developers of docker.<br/>
Here, as i said we have **each service on a container**, and we can manage them with the ***docker-compose.yml*** file, then we have a ***Makefile*** that will execute **docker-compose commands**. This **architecture** is very useful because we can shut down or start our containers very **fast**.</br>
Now, we're going to study the basic concepts of docker. 

### Virtual Machines vs Docker
First, what's the difference? A ***VM(Virtual Machine)*** is a completly **emulated Operating system** on your computer, emulating *RAM*, *Chores* and pretty much **all the hardware of a computer**<br/> **Containers** are different, they are much **lighter** than an entire Virtual Machine, it only **virtualize software layers** obove the **Operating System**.

### Secrets vs Environment variables
**Environment variables** are **PUBLIC values** that you set in a *.env* that can be used in the containers themselves for multiple purposes : **installation, configuration** of a service...<br/>
**Secrets** is almost the same, except that these **values are PRIVATE** and not environment variables, which is a very **important difference** even if they serve the same purpose. For example you would want to put your *passwords*, *API keys* in **docker secrets**.<br/> But how do we know secrets are really more secure than .env? What does it change exactly?<br/>
The main difference is that you can easily see the environment of a container with **```docker inspect```**. That's why we have **docker secrets**, that **mounts the secrets as files** under the */run/secrets/...* path so that these don't show up in the docker inspect and not as exposed as environment variables.

### Docker Networks vs Host Networks
**docker bridge network** is a feature of docker that allows you to make multiple **containers communicate between each other** because containers are fully **independants by default**. The services Communicate using service names (DNS) and every service has its own IP adress.<br/>
**Host Network** directly uses the **IP of the host** and uses the **host's network** directly but this type of network **cannot be used in multi container architecture** even if they are **more performant** because they can't establish communication between the containers.

### Docker Volumes vs Bind Mounts
**Docker volumes** are a feature of Docker that allow **persistent storage** by storing data **outside of containers**.
By default, when a container is removed, its **internal data is lost**, so volumes are used to **keep important data** such as *databases*.

Volumes are **managed by Docker** and stored in a **dedicated location** on the host (e.g. /var/lib/docker/volumes).
They allow containers to read and write data that persists even if the container is stopped or recreated.

Bind mounts are **similar** but **work differently**.
They link a **specific directory** from the host directly to a directory **inside the container**.

This means:

- if a file is created on the host, it appears in the container
- if a file is created in the container, it appears on the host

The main difference is that:

- bind mounts use a **direct path on the host** and give **full control over the files**
- volumes are **managed by Docker** and **abstract the storage location**


## Resources 🌐

Here is the list of the main **references** i used to make this **project** :
- [docker doc](https://docs.docker.com/get-started/)
- [write Dockerfile](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/ecrire-dockerfile/)
- [wordpress doc](https://wordpress.org/documentation/)
- [nginx doc](https://nginx.org/en/docs/)
- [mariadb doc](https://mariadb.com/docs)
- [docker course](https://courses.mooc.fi/)

> In this project, i mainly used **AI** for **documentation** purposes such as **configuration informations** on a service of the project