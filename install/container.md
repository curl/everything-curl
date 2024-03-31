# Container

Both `docker` and `podman` are containerization tools. The official release container images 
are hosted at the following registries:
* [https://quay.io/repository/curl/curl?tab=info](https://quay.io/repository/curl/curl?tab=info)
* [https://hub.docker.com/r/curlimages/curl](https://hub.docker.com/r/curlimages/curl)

In addition, the the latest _bleeding edge_ containers, built by CI, are pushed constantly 
to [https://github.com/orgs/curl/packages](https://github.com/orgs/curl/packages). 

You can run the latest version of curl with the following command:

Command for `podman`:

    podman run -it --rm quay.io/curl/curl www.example.com

Command for `docker`:

    docker run -it --rm quay.io/curl/curl www.example.com

## Running curl seamlessly in container

It is possible to make an alias to seamlessly run curl inside a container as
if it is a native application installed on the host OS.

Command to define curl as an alias for your containerization tool in the Bash,
ZSH, Fish shell:

### Bash or zsh

Invoke curl with `docker`:

    alias curl='docker run -it --rm quay.io/curl/curl'

Invoke curl with `podman`:

    alias curl='podman run -it --rm quay.io/curl/curl'

### Fish

Invoke curl with `docker`:

    alias -s curl='docker run -it --rm quay.io/curl/curl'

Invoke curl with `podman`:

    alias -s curl='podman run -it --rm quay.io/curl/curl'

And simply invoke `curl www.example.com` to make a request

## Using curl-base image

The **curl-base** image should be used when one wants to create an image at [https://quay.io/repository/curl/curl-base?tab=info](https://quay.io/repository/curl/curl-base)

For example: 
```
from quay.io/curl/curl-base
RUN apk add jq
```


## Running curl in kubernetes

Sometimes it can be useful to troubleshoot k8s networking with curl, just like
:

    kubectl run -i --tty curl --image=quay.io/curl/curl --restart=Never \
      -- "-m 5" www.example.com
