# Nginx WebApp Docker Project

This project demonstrates a containerized Nginx web application using Docker. It serves a simple HTML website with a custom 404 error page.

## Project Structure

```
webapp-nginx/
├── Dockerfile          # Dockerfile to build the Nginx image
├── nginx.conf          # Nginx configuration file
├── index.html          # Main HTML page
├── error_404.html      # Custom 404 error page
└── README.md           # Project documentation
```

## Features

* Serves a simple static website via Nginx
* Custom 404 error page
* Fully Dockerized for easy deployment
* Can run alongside other containerized services (e.g., Apache)

## Prerequisites

* Docker installed on your machine
* Docker Compose (optional, for multi-container setup)

## Build and Run

### Using Docker CLI

1. Build the Nginx image:

```bash
docker build -t nginx-site ./webapp-nginx
```

2. Run the container:

```bash
docker run -d -p 8081:80 --name nginx-container nginx-site
```

3. Access the website in your browser:

```
http://localhost:8081
```

4. Test the custom 404 page:

```
http://localhost:8081/nonexistentpage
```

### Using Docker Compose (optional)

1. Navigate to the project root where `docker-compose.yml` exists.
2. Run:

```bash
docker-compose up --build
```

3. Access the Nginx site via the mapped host port (e.g., `http://localhost:8081`).

## Inside the Container

You can inspect the container:

```bash
docker exec -it nginx-container /bin/bash
```

Website files are located at:

```
/usr/share/nginx/html/
```

* `index.html` → main page
* `error_404.html` → custom error page

## Notes

* Nginx runs in the foreground by default in the official Docker image
* Host port can be changed in `docker run` or `docker-compose.yml`
* Using the official `nginx:latest` image ensures lightweight, production-ready deployment

## Author

**Lalit Kumar Gautam**

* Email: [hi.lkgautam@gmail.com](mailto:hi.lkgautam@gmail.com)
* GitHub: [https://github.com/Hi-Lalit](https://github.com/Hi-Lalit)
