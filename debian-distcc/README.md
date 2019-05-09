<!--
Copyright (c) 2019 Jakob Meng, <jakobmeng@web.de>
-->
# jm1337/debian-distcc


## Usage:

Get docker image:
```
docker pull jm1337/debian-distcc
```

Run interactive (exit with <kbd>CTRL</kbd>+<kbd>C</kbd>):
```
docker run --rm          --publish 3632:3632 --interactive --tty --name jm1337-debian-distcc jm1337/debian-distcc
```

**:warning:
 IP-based access control is not secure against attackers able to spoof TCP connections,
 and cannot discriminate different users on a client.

 TCP connections are not secure against attackers able to observe or modify network traffic.
:warning:**
[Quoted from `man distccd`](https://manpages.debian.org/unstable/distcc/distccd.1.en.html)


## Advanced Usage

Run as deamon:
```
docker run --rm --detach --publish 3632:3632 --interactive --tty --name jm1337-debian-distcc jm1337/debian-distcc
docker stop jm1337-debian-distcc
```

Login to a daemonized container:
```
docker exec -ti jm1337-debian-distcc
```

Run interactively and login:
```
docker run -ti --rm jm1337/debian-distcc bash
```


## References:

 1. https://hub.docker.com/_/httpd/
 2. https://docs.docker.com/engine/userguide/networking/
 3. https://manpages.debian.org/unstable/distcc/distcc.1.en.html
 4. https://manpages.debian.org/unstable/distcc/distccd.1.en.html
