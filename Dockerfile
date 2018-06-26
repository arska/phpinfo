# use the centos php image, originally used in source-to-image (s2i)
FROM centos/php-70-centos7

# This image provides an Apache+PHP environment for running PHP
# applications.

# Apache will listen on port 8080
EXPOSE 8080

# set environment variables for apache configuration at runtime
ENV PHP_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/php/ \
    APP_DATA=${APP_ROOT}/src \
    PHP_DEFAULT_INCLUDE_PATH=/opt/rh/rh-php70/root/usr/share/pear \
    PHP_SYSCONF_PATH=/etc/opt/rh/rh-php70 \
    PHP_HTTPD_CONF_FILE=rh-php70-php.conf \
    HTTPD_CONFIGURATION_PATH=${APP_ROOT}/etc/conf.d \
    HTTPD_MAIN_CONF_PATH=/etc/httpd/conf \
    HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d \
    HTTPD_VAR_RUN=/var/run/httpd \
    HTTPD_DATA_PATH=/var/www \
    HTTPD_DATA_ORIG_PATH=/opt/rh/httpd24/root/var/www \
    HTTPD_VAR_PATH=/opt/rh/httpd24/root/var \
    SCL_ENABLED=rh-php70

# include our application in the image
COPY index.php /opt/app-root/src/

# drop root privileges when running
USER 1001

# call the startup script of the parent image
CMD sh /usr/libexec/s2i/run
