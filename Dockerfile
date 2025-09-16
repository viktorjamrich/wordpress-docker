FROM phpdockerio/php:8.4-fpm

# Install Apache2 + required modules
RUN apt-get update && \
    apt-get install -y apache2 apache2-bin apache2-utils && \
    a2enmod proxy_fcgi setenvif rewrite headers && \
    a2enconf php8.4-fpm && \
    a2enmod mpm_event && \
    a2dismod mpm_prefork && \
    a2enmod remoteip || true

# Enable default site (we’ll override config if needed)
RUN a2ensite 000-default.conf

# Install common WordPress PHP extensions
RUN apt-get install -y \
    php8.4-mysqli \
    php8.4-pdo \
    php8.4-pdo-mysql \
    php8.4-zip \
    php8.4-gd \
    php8.4-mbstring \
    php8.4-xml \
    php8.4-curl \
    php8.4-intl \
    php8.4-bcmath \
    php8.4-soap \
    php8.4-exif \
    php8.4-fileinfo \
    php8.4-opcache && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure Apache virtual host
COPY apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Copy WordPress files
WORKDIR /var/www/html

# Expose HTTP port
EXPOSE 80

# Start PHP-FPM and Apache
CMD service php8.4-fpm start && apachectl -D FOREGROUND

