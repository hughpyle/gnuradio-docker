### Dockerfile

This Dockerfile builds an Ubuntu 16.04 container with a working GNU Radio install. There are a number of other GNU Radio Dockerfiles that work fine for most people, but I couldn't seem to make any of them work on OSX.

Build the container:
```
docker build . -t gnuradio:basic
```

Ensure that X11 forwarding is allowed from localhost,
```
xhost + 127.0.0.1
```

Running the container with a bunch of magic parameters that make X applications work in OSX.
```
docker run -i -t -e XAUTHORITY=/tmp/xauth -v ~/.Xauthority:/tmp/xauth -v /tmp/.X11-unix/:/tmp/ -e DISPLAY=host.docker.internal:0 --net host gnuradio:basic
```

In order for X to work on MacOS, you need to have XQuartz installed.
