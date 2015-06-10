# Docker-Unison
A docker volume container using [Unison](http://www.cis.upenn.edu/~bcpierce/unison/) for fast two-way folder sync. Created as an alternative to [slow boot2docker volumes on OS X](https://github.com/boot2docker/boot2docker/issues/593).

The docker image is available on Docker Hub: 
[registry.hub.docker.com/u/leighmcculloch/unison/](https://registry.hub.docker.com/u/leighmcculloch/unison/)

## Usage

### Docker

First, you can launch a volume container exposing a volume with Unison.

```bash
$ CID=$(docker run -d -p 5000:5000 -e UNISON_VERSION=2.48.3 leighmcculloch/unison)
```

You can then sync a local folder to `/unison` in the container with:

```bash
$ unison . socket://<docker>:5000/ -auto -batch
```

Next, you can launch a container connected with the volume under `/unison`.

```bash
$ docker run -it --volumes-from $CID ubuntu /bin/sh
```

### Docker Compose

If you are using Docker Compose to manage a dev environment, use the `volumes_from` directive.

The following `docker-compose.yml` would mount the `/unison` folder from the `unison` container inside your `mywebserver` container.

```yaml
mywebserver:  
  build: .  
  volumes_from:  
    - unison  
unison:  
  image: leighmcculloch/unison  
  environment:  
    - UNISON_VERSION=2.48.3  
  ports:  
    - "5000:5000"
```

You can then sync a local folder, using the unison client, to `/unison` in the container with:

```bash
$ unison . socket://<docker>:5000/ -ignore 'Path .git' -auto -batch
```

You could combine it with fswatch to sync automatically when files change:

```bash
$ fswatch -o . | xargs -n1 -I{} unison . socket://<docker>:5000/ -ignore 'Path .git' -auto -batch
```

## Installing Unison Locally
Unison requires the version of the client (running on the host) and server (running in the container) to match. This docker image includes common versions of Unison server which can be selected with the `UNISON_VERSION` environment variable.

* 2.40.102 (available via `apt-get install unison` on Ubuntu 14.04, 14.10, 15.04)
* 2.48.3 (available via `brew install unison` on Mac OS X) [default]

Additional versions can be added easily on request. Open an Issue if you need another version.

## Installing fswatch Locally
Get fswatch using `brew install fswatch` on Mac OS X otherwise [download and compile from a release build](http://emcrisostomo.github.io/fswatch/).

## License
This docker image is licensed under GPLv3 because Unison is licensed under GPLv3 and is included in the image. See LICENSE.
