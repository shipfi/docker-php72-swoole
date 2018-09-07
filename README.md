# docker-php72-swoole
Docker for PHP7.2 With Swoole



### Usage

```
docker run  --name=swooleRun -it --rm -v E:\SourceCode\TestCode\PHP\swoole:/opt/ -p 9501:9501 shipfi/docker-php72-swoole php /opt/server.php start
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

