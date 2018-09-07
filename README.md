# docker-php72-swoole
Docker for PHP7.2 With Swoole



### Usage

```
docker run -d --name=DockerAppName -v /workdir:/workdir -p 9501:9501 php /workdir/app_server.php start
```

* Install PHP Extensions
  * GD 
  * mcrypt
  * iconv
  * pdo_mysql
  * xml
  * swool
  * sockets
  * opcache
  * redis
  * bz2
  * bcmath
  * zip
* Install php-composer in `/usr/local/bin/composer`
* `apt-get` use 163.com mirrors

