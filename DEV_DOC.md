# Developer Documentation

*This document explains how to set up the environment from scratch, build and launch the project, manage containers and volumes, and identify where data is stored and how it persists.*

## 1. Environment setup from scratch

### Prerequisites

To work on this project, you need:

- Docker and Docker Compose installed.
- `make` available on your system.
- This repository cloned locally.
- A `.env` file configured with at least:
  - `VOLUMES_LOCATION` (base path where the data volumes will be stored).

### Required directories (volumes)

Create the following directories, where `VOLUMES_LOCATION` comes from your `.env` file:

- `${VOLUMES_LOCATION}/wordpress`
- `${VOLUMES_LOCATION}/mariadb`

These directories are used as data volumes for WordPress and MariaDB so that their data persists independently from the containers.

### Configuration files and secrets

At the root of the repository, create a folder named `secrets`, then inside it create the following files:

- `credentials.txt`
- `db_password.txt`
- `db_root_password.txt`

Fill them with the appropriate passwords:

- `credentials.txt`: WordPress admin and user passwords.
- `db_password.txt`: MariaDB user password.
- `db_root_password.txt`: MariaDB root password.

When the containers are created, the stack reads `secrets/credentials.txt` and uses its values as the WordPress admin and user passwords.

## 2. Build and launch with Makefile and Docker Compose

From the root of the repository, run:

`make up`

This will:

- Build the Docker images for the stack.
- Start all containers (nginx, WordPress, MariaDB, and any additional services).

You can also run `make` with no arguments to list all available Makefile targets and see what they do, including how they map to Docker and Docker Compose operations.

## 3. Managing containers and volumes

### Useful commands for containers

Check container status (including stopped ones):

`docker ps -a`

If the containers are running correctly, their status will be `Up`. This confirms that the containers are started, but not that each service is functionally correct.

To stop and clean the stack using the Makefile:

`make clean`

This stops the containers and cleans the associated volumes defined by the project.

For service-level checks:

- Web stack (nginx + WordPress): open `https://localhost` or `https://lcalero.42.fr` in a browser.
- Example FTP service (if present, like `vsftpd`): run `ftp lcalero.42.fr` and try to authenticate.

### Volumes and data persistence

Project data is stored in the directories pointed to by `VOLUMES_LOCATION`:

- WordPress data: `${VOLUMES_LOCATION}/wordpress`
- MariaDB data: `${VOLUMES_LOCATION}/mariadb`

These directories ensure data persistence across container rebuilds and restarts. Rebuilding or restarting containers will not erase WordPress or MariaDB data. Manually deleting the contents of these directories will reset the WordPress site and database.

If you want a completely clean state (no persistent data):

- Run `make clean`.
- Then delete:

`${VOLUMES_LOCATION}/mariadb`  
`${VOLUMES_LOCATION}/wordpress`

## 4. Accessing the running stack (for verification)

After `make up` completes:

- Website (front-end):
  - `https://localhost`
  - `https://lcalero.42.fr`
- WordPress admin panel:
  - `https://localhost/wp-admin`

Use the administrator credentials defined in `secrets/credentials.txt` to log in and verify that the stack is working as expected.
