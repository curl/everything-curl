# container

Both `Docker` and, `Podman` are containerization tools.
The docker image is hosted at [https://hub.docker.com/r/curlimages/curl](https://hub.docker.com/r/curlimages/curl)

You can run the latest version of curl with the following command:

Command for `Docker`:
```
docker run -it --rm docker.io/curlimages/curl https://example.com
```

Command for `Podman`:
```
podman run -it --rm docker.io/curlimages/curl https://example.com
```

## Running curl seamlessly in container

It is possible to make an alias to seamlessly run curl inside a container.
Define an alias for your Bash (ZSH, Fish, ...) shell shell:

### Bash
(most distributions use bash)

`Docker`
```
echo "alias curl='docker run -it --rm curlimages/curl'" >> ~/.bashrc
```

`Podman`
```
echo "alias curl='podman run -it --rm curlimages/curl'" >> ~/.bashrc
```
Then close your terminal and, reopen it again.

### ZSH
(this is the shell used by MacOS by default)
`Docker`
```
echo "alias curl='docker run -it --rm curlimages/curl'" >> ~/.zshrc
```

`Podman`
```
echo "alias curl='podman run -it --rm curlimages/curl'" >> ~/.zshrc
```
Then close your terminal and, reopen it again.

### Fish
`Docker`
```
alias -s curl='docker run -it --rm curlimages/curl'
```

`Podman`
```
alias -s curl='podman run -it --rm curlimages/curl'
```
Then close your terminal and, reopen it again.

And simply invoke `curl www.example.com` to make a request

## Running curl in kubernetes

Sometimes it can be useful to troubleshoot k8s networking with curl, just like :

```
kubectl run -i --tty curl --image=curlimages/curl --restart=Never -- "-m 5" www.example.com
```
