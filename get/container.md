# container

The docker image is hosted at [https://hub.docker.com/r/curlimages/curl](https://hub.docker.com/r/curlimages/curl)

You can run the latest version of curl with the following command:

```
docker run -it --rm curlimages/curl www.example.com
```

## Running curl seamlessly in docker

It is possible to make an alias to seamlessly run curl inside a container. Define an alias like the following:

```
# Bash alias example
alias curl='docker run -it --rm curlimages/curl'
```

And simply invoke `curl www.example.com` to make a request

## Running curl in kubernetes

Sometimes it can be useful to troubleshoot k8s networking with curl, just like :

```
kubectl run -i --tty curl --image=curlimages/curl --restart=Never -- "-m 5" www.example.com
```
