# Container

Both `docker` and `podman` are containerization tools. The docker image is
hosted at
[https://hub.docker.com/r/curlimages/curl](https://hub.docker.com/r/curlimages/curl)

You can run the latest version of curl with the following command:

Command for `docker`:

    docker run -it --rm docker.io/curlimages/curl www.example.com

Command for `podman`:

    podman run -it --rm docker.io/curlimages/curl www.example.com

## Running curl seamlessly in container

It is possible to make an alias to seamlessly run curl inside a container as
if it is a native application installed on the host OS.

Command to define curl as an alias for your containerization tool in the Bash,
ZSH, Fish shell:

### Bash or zsh

Invoke curl with `docker`:

    alias curl='docker run -it --rm docker.io/curlimages/curl'

Invoke curl with `podman`:

    alias curl='podman run -it --rm docker.io/curlimages/curl'

### Fish

Invoke curl with `docker`:

    alias -s curl='docker run -it --rm docker.io/curlimages/curl'

Invoke curl with `podman`:

    alias -s curl='podman run -it --rm docker.io/curlimages/curl'

And simply invoke `curl www.example.com` to make a request

## Running curl in kubernetes

Sometimes it can be useful to troubleshoot k8s networking with curl, just like
:

    kubectl run -i --tty curl --image=curlimages/curl --restart=Never \
      -- "-m 5" www.example.com
