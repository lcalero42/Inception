# User Documentation

*This document explains what the stack provides and how an end user or administrator can use it.*

## Services provided by the stack

The stack runs the following services, each in its **own container**:

- **nginx**: open-source software used for web serving.
- **wordpress**: open-source content management system, where you can create and edit your website.
- **mariadb**: database management service used to store WordPress data.

## Starting and stopping the project

### Starting the project

Before you can start the containers, you must complete a few prerequisites:

1. Create the following **folders**, where `VOLUMES_LOCATION` is an **environment variable** defined in your `.env` file:
   - `${VOLUMES_LOCATION}/wordpress`
   - `${VOLUMES_LOCATION}/mariadb`
2. At the root of the repository, create a folder named `secrets`, then inside it create these **files** and write the required **passwords** in them:
   - `credentials.txt`
   - `db_password.txt`
   - `db_root_password.txt`
3. Once this is done, run `make up` to **build the images** and **start the containers**.

You can also run `make` to list all available commands and see what they do.

### Stopping the project

To stop everything, run `make clean`; this will stop the containers and clean the volumes.

If you want to remove all data (including the database), you can also delete the contents of:

- `${VOLUMES_LOCATION}/mariadb`
- `${VOLUMES_LOCATION}/wordpress`

## Accessing the website and admin panel

### Accessing the website

To verify that the stack is working, open:

- `https://lcalero.42.fr`  
or  
- `https://localhost`

You should see the landing page of the **WordPress website**.

### Accessing the administration panel

To access the **WordPress administration panel**, open:

- `https://localhost/wp-admin`

Then enter your **administrator login** and **administrator password**.

## Locating and managing credentials

The **credentials file** is located at `secrets/credentials.txt` (if you created it) and should contain your **WordPress admin and user passwords**, which you can edit as needed.

When the containers are created, they will read the passwords from `credentials.txt` and use them as the **admin and user passwords**.

## Checking that services are running

After **starting the containers**, run:

```bash
docker ps -a
