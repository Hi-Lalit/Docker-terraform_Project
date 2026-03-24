# Docker WebApps Project (Apache + Nginx)

This repository demonstrates **two containerized web applications**:

1. **Apache WebApp** – serves a static website with a custom 404 page.
2. **Nginx WebApp** – serves another static website with a custom 404 page.

Both applications are fully Dockerized and can run simultaneously using Docker Compose.

## Project Structure

```
Docker-project/
├── webapp-apache/
│   ├── apache.conf       # Apache virtual host configuration
│   ├── Dockerfile        # Dockerfile for Apache image
│   ├── index.html        # Main page for Apache site
│   └── error_404.html    # Custom 404 page
├── webapp-nginx/
│   ├── Dockerfile        # Dockerfile for Nginx image
│   ├── nginx.conf        # Nginx configuration file
│   ├── index.html        # Main page for Nginx site
│   └── error_404.html    # Custom 404 page
└── docker-compose.yml    # Compose file for multi-container setup
```

## Features

* Two independent static websites (Apache + Nginx)
* Custom 404 error pages for each site
* Fully containerized for easy deployment
* Can run simultaneously on different host ports

## Prerequisites

* Docker installed on your machine
* Docker Compose (optional, for multi-container setup)

## Build and Run

### Using Docker CLI (individual services)

#### Apache WebApp

```bash
docker build -t apache-site ./webapp-apache
docker run -d -p 8082:80 --name apache-container apache-site
```

* Access Apache site: `http://localhost:8082`
* Test 404: `http://localhost:8082/nonexistentpage`

#### Nginx WebApp

```bash
docker build -t nginx-site ./webapp-nginx
docker run -d -p 8081:80 --name nginx-container nginx-site
```

* Access Nginx site: `http://localhost:8081`
* Test 404: `http://localhost:8081/nonexistentpage`

### Using Docker Compose (recommended)

1. From the root of the project:

```bash
docker-compose up --build
```

2. Access the sites in the browser:

* Apache: `http://localhost:8082`
* Nginx: `http://localhost:8081`

3. Stop the containers:

```bash
docker-compose down
```

## Inside Containers

You can inspect each container:

```bash
docker exec -it apache-container /bin/bash
docker exec -it nginx-container /bin/bash
```

Website files locations:

* Apache: `/var/www/html/`
* Nginx: `/usr/share/nginx/html/`

## Notes

* Apache and Nginx both run in foreground mode to keep containers alive
* Host ports can be changed in `docker run` or `docker-compose.yml`
* Using official images ensures lightweight and production-ready deployment

## Author

**Lalit Kumar Gautam**

* Email: [hi.lkgautam@gmail.com](mailto:hi.lkgautam@gmail.com)
* GitHub: [https://github.com/Hi-Lalit](https://github.com/Hi-Lalit)
