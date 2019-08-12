### Dockerfile

This Dockerfile builds an Ubuntu 18.04 container with a working GNU Radio version 3.8 install. 
For now it uses the pre-built UHD, not a custom build.

Note: building gnuradio needs more memory than the 2GB default allocated by Docker on MacOS.  You can increase the available memory from the Docker Desktop icon --> Preferences --> Advanced.

Build the container:
```
docker build . -t gnuradio:basic
```

In order for X to work on MacOS, you need to have XQuartz installed.
Start XQuartz, then ensure that X11 forwarding is allowed via localhost,
```
xhost + 127.0.0.1
```

Make a FIFO pipe so that we can easily send binary data into the container,
```
mkfifo /tmp/grfifo
```

Run the container with a bunch of magic parameters that make X applications work in OSX, and connect the FIFO
```
docker run -i -t -e XAUTHORITY=/tmp/xauth -v ~/.Xauthority:/tmp/xauth -v /tmp/.X11-unix/:/tmp/ -e DISPLAY=host.docker.internal:0 --volume /tmp/grfifo:/tmp/grfifo:rw --net host gnuradio:basic
```

Then you're ready to run, e.g.
```
gnuradio-companion
```

