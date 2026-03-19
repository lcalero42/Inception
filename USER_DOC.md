# User Documentation

*This markdown file has the ambition to help an end user or administrator on how to use the stack and what it contains.*

## Services provided by the stack
- **nginx** -> *an open source software for web serving*
- **wordpress** -> *an open-source content management system, basically it is where we can create/edit our website*
- **mariadb** -> *database management service*

Each one of these services are running inside of their own container.

## Start and Stop the project


### Start the project
There is **multiple prerequisistes** before we can actually run the containers.<br/>
1. First you must create these **folders**, knowing that *VOLUMES_LOCATION* is an **environment variable** that you can configure in the *.env* file :
	- *${VOLUMES_LOCATION}/wordpress*
	- *${VOLUMES_LOCATION}/mariadb*
2. Create a folder named "*secrets*" at the root of the repository, and inside this folder, create these **files** and put the needed **passwords** inside them :
	- *credentials.txt*
	- *db_password.txt*
	- *db_root_password.txt*
3. Now you're all set, you can ```make up``` to **build the images** and **run the containers**
> You can also type ```make``` to know all the commands you can do and what they do

### Stop the project
In order to stop everything, you just have to ```make clean``` and it will clean the volumes and stop the containers
> If you really want to keep nothing, such as the database, you can also delete what contains : ```${VOLUMES_LOCATION}/mariadb``` and ```${VOLUMES_LOCATION}/wordpress```


## Access the website and the administration pannel

### Access the website
In order to check that everything works, you can go to ```https://lcalero.42.fr``` or ```https://localhost``` and you should see the landing page of the **wordpress website**

### Access the administrator pannel
In order to access the **administrator pannel** of wordpress, you can go to ```https://localhost/wp-admin``` and then type your **adminstrator login** and **administrator password**

## Locate and manage credentials
The **credentials file** is located in *secrets/credentials.txt* (if you created it) and it should contain your **admin and user wordpress password** (of course you can edit them as you wish). Thus, at the creation of the **containers**, it will take the passwords you wrote in credentials.txt as the **passwords of the admin and user**.

## Check that the services are running correctly
After **running the containers**, you can execute **this command** : ```docker ps -a```<br/>
And if you see that all the **status are** *Up*, it means the containers **ran successfully**. <br/>
But the fact that the containers ran successfully **does not mean everything works**, to really check it works, it can depend on the service, but if you are able to see wordpress landing page at ```https://localhost```, it already means that **wordpress and nginx are working properly**.
For the other services, it depends a lot on the service itself.
> For example : for *vsftpd* (ftp service) you must run ```ftp lcalero.42.fr``` and log