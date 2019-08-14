# Dockerfile for ambari-server

This repository is used for creating for creating unofficial docker images of [ambari-server](https://github.com/apache/ambari).
Images are published at https://hub.docker.com/r/pgarrison/ambari-server

## Usage

```
$ docker run pgarrison/ambari-server
Unable to find image 'pgarrison/ambari-server:2.7.3.0.0' locally
2.7.3.0.0: Pulling from pgarrison/ambari-server
5893bf6f34bb: Already exists 
071ff9c2b706: Pull complete 
9c638ca54f6e: Pull complete 
031cfedb3055: Pull complete 
f51ce58b6b2a: Pull complete 
24259837aefb: Pull complete 
94105082bdfc: Pull complete 
Digest: sha256:ecc6c7b38fd88a26a18918dd2695d0a0440e53455c88dc458b02370c79050e0f
Status: Downloaded newer image for pgarrison/ambari-server:2.7.3.0.0
Using python  /usr/bin/python
Starting ambari-server
Ambari Server running with administrator privileges.
About to start PostgreSQL
Organizing resource files at /var/lib/ambari-server/resources...
Ambari database consistency check started...
Server PID at: /var/run/ambari-server/ambari-server.pid
Server out at: /var/log/ambari-server/ambari-server.out
Server log at: /var/log/ambari-server/ambari-server.log
Waiting for server start.............
```

## Contributing

This Dockerfile is not official Apache project. Pull requests welcome.

Every push to a branch matching the regex `/^[0-9.]+$/` will trigger a build on [dockerhub](https://hub.docker.com/r/pgarrison/ambari-server).
