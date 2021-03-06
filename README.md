# docker-debian-sftp

**!UPDATE!** docker-debian-sftp now has support for other architectures <br/> <br/>
**docker-debian-sftp** has support for: `amd64`, `i386`, `arm64` and `armv7`. <br/>
**Filestash** still only has support for `amd64` (not up to me, because it's not my project). If you work on arm port of Filestash, please let me know. <br/> <br/>
GitHub: https://github.com/Cimlah/docker-debian-sftp <br/>
DockerHub: https://hub.docker.com/repository/docker/cimlah/docker-debian-sftp

# What is it?
Docker-debian-sftp is a Docker container running sftp server.
Not only you get isolation from the side of Docker, but also there is chroot in sshd_config set-up. <br/>
It is meant to run alongside with [Filestash](https://github.com/mickael-kerjean/filestash), but can very simply edit *docker-compose.yml* not to use Filestash.

# How to use it?
**First of all, choose proper *docker-compose.yml* file for your architecture (either *docker-compose_amd64.yml* or *docker-compose_other-architectures.yml*) and rename it to *docker-compose.yml*.** <br/>
While in main directory of this repo, you can simply execute command: `docker-compose up -d` or copy content of my *docker-compose.yml*:

``` yml
version: '3.3'

services:
    debian-sftp:
        image: cimlah/docker-debian-sftp:latest
        restart: unless-stopped
        hostname: debian-sftp
        container_name: debian-sftp
        ports:
            - "2800:22"
        stdin_open: true
        tty: true
        volumes: 
            - /path/you/want/to/use:/home

    filestash:
        image: machines/filestash
        restart: unless-stopped
        hostname: filestash
        container_name: filestash
        ports:
            - "8334:8334"
        environment: 
            - APPLICATION_URL=
            - GDRIVE_CLIENT_ID=<gdrive_client>
            - GDRIVE_CLIENT_SECRET=<gdrive_secret>
            - DROPBOX_CLIENT_ID=<dropbox_key>
            - ONLYOFFICE_URL=http://onlyoffice
```

## Don't want to use filestash or don't use amd64 architecture?
If you don't want to use Filestash just delete lines of code associated with filestash service or copy:

``` yml
version: '3.3'

services:
    debian-sftp:
        image: cimlah/docker-debian-sftp:latest
        restart: unless-stopped
        hostname: debian-sftp
        container_name: debian-sftp
        ports:
            - "2800:22"
        stdin_open: true
        tty: true
        volumes: 
            - /path/you/want/to/use:/home
```

## Remember, change mount point, or delete it completely if you don't want to mount anything

Remember to change line: ` - /path/you/want/to/use:/home`, so the files from *debian-sftp* container get mounted in a place you want. It is good to mount in case something happens to container, if so you still have access to all files located in this container.

## How to create users?
I wrote a simple script called *user_add.sh*, which creates users and sets proper permission for their files. <br/>
If you want to use it, you can execute command from your host OS: `docker exec -it debian-sftp user_add`, write user name and password when asked to do so. Another way is to get inside container (e. g. `docker exec -it debian-sftp bash`) and there execute `user_add`. <br/>
Please, read my script to know what permissions are set by it.

# Can I customise it for my needs?
Of course, if you want to change something, for example in *sshd_config*, do it and then build the image yourself. In directory *build_it_yourself* you have everything needed to customise and build the image. <br/>
To build the image, execute command: `docker build -t *name of your image* .` while you're inside *build_it_yourself* directory.