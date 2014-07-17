# docker-armagetronad

A nice and easy way to get a Armagetronad server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on Armagetronad and check out it's [website][1].


## Building docker-armagetronad

Running this will build you a docker image with the latest version of both
docker-armagetronad and Armagetronad-0.2.9-sty+ct+ap itself.

    git clone https://github.com/izissise/docker-armagetronad
    cd docker-armagetronad
    sudo docker.io build -t izissise/armagetronad-0.2.9-sty-ct-ap .


## Running docker-armagetronad

Running the first time will set your port to a static port of your choice so
that you can easily map a proxy to. If this is the only thing running on your
system you can map the port to 4534 and no proxy is needed. i.e.
`-p=4534:4534/udp` Also be sure your mounted directory on your host machine is
already created before running `mkdir -p /mnt/armagetronad`. And to put in that
directory configuaration files of the server:
`
examples
network.cfg
server_info.cfg
settings_authentication.cfg
settings_custom.cfg
`
You need TRUST_LAN 1

    docker run -d -p 4534:4534/udp -v="/mnt/armagetronad:/home/armagetronad/settings/settings" --name="armagetronad" izissise/armagetronad-0.2.9-sty-ct-ap

From now on when you start/stop docker-armagetronad you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker.io ps` and it will show up on the left side followed by the
image name which is `izissise/armagetronad-0.2.9-sty-ct-ap:latest`.

    sudo docker.io start <container_id>
    sudo docker.io stop <container_id>

### Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `izissise/armagetronad-0.2.9-sty-ct-ap` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: http://armagetronad.org/

