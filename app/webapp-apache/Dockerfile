# Use the official Ubuntu image as the base image

FROM ubuntu:22.04

# Install Apache web server and clean up apt cache to reduce image size

RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy the custom index.html and error_404.html files to the Apache web server's document root, and copy the custom Apache configuration file

COPY index.html /var/www/html/
COPY error_404.html /var/www/html/
COPY apache.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

# Run Apache in the foreground

CMD ["apachectl", "-D", "FOREGROUND"]