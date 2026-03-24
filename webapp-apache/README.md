# Apache WebApp Docker Project

This project demonstrates a containerized Apache web application using Docker. It serves a simple HTML website with a custom 404 error page.

## Project Structure

```
webapp-apache/
├── apache.conf         # Apache virtual host configuration
├── Dockerfile          # Dockerfile to build the Apache image
├── index.html          # Main HTML page
└── error_404.html      # Custom 404 error page
```

## Features

* Serves a simple static website via Apache
* Custom 404 error page
* Fully Dockerized for easy deployment
* Can be run alongside other containerized services (e.g., Nginx)

## Prerequisites

* Docker installed on your machine
* Docker Compose (optional, for multi-container setup)

## Build and Run

### Using Docker CLI

1. Build the Apache image:

```bash
docker build -t apache-site ./webapp-apache
```

2. Run the container:

```bash
docker run -d -p 8082:80 --name apache-container apache-site
```

3. Access the website in your browser:

```
http://localhost:8082
```

4. Test the custom 404 page:

```
http://localhost:8082/nonexistentpage
```

### Using Docker Compose (optional)

1. Navigate to the project root where `docker-compose.yml` exists.
2. Run:

```bash
docker-compose up --build
```

3. Access the Apache site via the mapped host port (e.g., `http://localhost:8082`).

## Inside the Container

You can inspect the container:

```bash
docker exec -it apache-container /bin/bash
```

The website files are located at:

```
/var/www/html/
```

* `index.html` → main page
* `error_404.html` → custom error page

## Notes

* Apache runs in foreground mode to keep the container alive
* Host port can be changed in `docker run` or `docker-compose.yml`
* Compatible with Ubuntu + Apache2 base image

## Author

**Lalit Kumar Gautam**

* Email: [hi.lkgautam@gmail.com](mailto:hi.lkgautam@gmail.com)
* GitHub: [https://github.com/Hi-Lalit](https://github.com/Hi-Lalit)
