
# Setting Up Flask App with MySQL using Docker

This guide helps you set up a simple Flask app connected to a MySQL database, all within Docker containers.

## Pre-requisites

Ensure you have Docker installed. Optionally, you can have Git for cloning the repository.

## Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/your-repo-name.git
    ```

2. Navigate to the project directory:

    ```bash
    cd your-repo-name
    ```

3. Create a `.env` file for MySQL configuration:

    ```bash
    touch .env
    ```

4. Add MySQL details to `.env`:

    ```makefile
    MYSQL_HOST=mysql
    MYSQL_USER=your_username
    MYSQL_PASSWORD=your_password
    MYSQL_DB=your_database
    ```

## Usage

1. Start containers with Docker Compose:

    ```bash
    docker-compose up --build
    ```

2. Access the app in your browser:

    - Frontend: [http://localhost](http://localhost)
    - Backend: [http://localhost:5000](http://localhost:5000)

3. Create the `messages` table in MySQL:

    - Use a MySQL client or tool and run:

        ```sql
	CREATE DATABASE IF NOT EXISTS KYC;
	USE KYC;
	CREATE TABLE IF NOT EXISTS messages (
    		id INT AUTO_INCREMENT PRIMARY KEY,
    		message TEXT
	);
        ```

4. Interact with the app:

    - Visit [http://localhost](http://localhost) to see the frontend. Submit messages via the form.
    - Visit [http://localhost:5000/insert_sql](http://localhost:5000/insert_sql) to insert messages directly into the database.

## Cleanup

To stop and remove containers:

```bash
docker-compose down
```

## To run this two-tier application without Docker Compose

- First create a docker image from Dockerfile
```bash
docker build -t flaskapp .
```

- Now, make sure that you have created a network using following command
```bash
docker network create twotier
```

- Attach both the containers in the same network, so that they can communicate with each other

i) MySQL container 
```bash
docker run -d \
    --name mysql \
    -v mysql-data:/var/lib/mysql \
    --network=twotier \
    -e MYSQL_DATABASE=mydb \
    -e MYSQL_USER=root \
    -e MYSQL_ROOT_PASSWORD=admin \
    -p 3306:3306 \
    mysql:5.7

```
ii) Backend container
```bash
docker run -d \
    --name flaskapp \
    --network=twotier \
    -e MYSQL_HOST=mysql \
    -e MYSQL_USER=root \
    -e MYSQL_PASSWORD=admin \
    -e MYSQL_DB=mydb \
    -p 5000:5000 \
    flaskapp:latest

```

## Notes

- Replace placeholders with your MySQL configuration.

- This setup is for demonstration; in production, follow best practices.

- Validate and reactify user inputs to prevent vulnerabilities.

- Check Docker logs for troubleshooting.

```
