# Docker-Unison
A docker volume container using [Unison](http://www.cis.upenn.edu/~bcpierce/unison/) for fast two-way folder sync. Created as an alternative to [slow boot2docker volumes on OS X](https://github.com/boot2docker/boot2docker/issues/593).

The docker image is available on Docker Hub: 
[registry.hub.docker.com/u/leighmcculloch/unison/](https://registry.hub.docker.com/u/leighmcculloch/unison/)

## Usage

### Docker

First, you can launch a volume container exposing a volume with Unison.

```bash
$ CID=$(docker run -d -p 5000:5000 -e UNISON_WORKING_DIR=/unison -v /unison leighmcculloch/unison:latest)
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
  image: leighmcculloch/unison:latest  
  environment:  
    - UNISON_WORKING_DIR=/unison  
  volumes:
    - /unison
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
Unison requires the version of the client (running on the host) and server (running in the container) to match. 

 * 2.40.102 (available via `apt-get install unison` on Ubuntu 14.04, 14.10, 15.04) [compiled with ocaml 4.01]
 * 2.48.4 (available via `brew install unison` on Mac OS X) [compiled with ocaml 4.03]

If you are installing unison by source, you can Check what version of ocaml that will be used during compilation by running `ocaml --version`.

## Available Unison Images
This docker repository includes common versions of Unison server compiled with different versions of OCaml. The version you need can be selected by choosing the appropriately tagged image from the docker hub repository. Images are tagged in the format:

```
VERSION-[unisonUNISON_VERSION[-OCAML_VERSION]]
```

Supported versions are any combination of the following:  

 * Unison 2.40.102, 2.48.3, 2.48.4
 * OCaml 4.01, 4.02, 4.03

Additional versions can be added easily on request. Open an Issue if you need another version.

### Examples
| Docker Image Tag                                        | Unison     | OCaml   |
| ------------------------------------------------------- | ---------- | ------- |
| `leighmcculloch/unison:latest`                          | `2.48.4`   | `4.03`  |
| `leighmcculloch/unison:latest-unison2.48.4-ocaml4.03`   | `2.48.4`   | `4.03`  |
| `leighmcculloch/unison:latest-unison2.48.4-ocaml4.02`   | `2.48.4`   | `4.02`  |
| `leighmcculloch/unison:latest-unison2.48.4-ocaml4.01`   | `2.48.4`   | `4.01`  |
| `leighmcculloch/unison:latest-unison2.48.3-ocaml4.03`   | `2.48.3`   | `4.03`  |
| `leighmcculloch/unison:latest-unison2.48.3-ocaml4.02`   | `2.48.3`   | `4.02`  |
| `leighmcculloch/unison:latest-unison2.48.3-ocaml4.01`   | `2.48.3`   | `4.01`  |
| `leighmcculloch/unison:latest-unison2.40.102-ocaml4.03` | `2.40.102` | `4.03`  |
| `leighmcculloch/unison:latest-unison2.40.102-ocaml4.02` | `2.40.102` | `4.02`  |
| `leighmcculloch/unison:latest-unison2.40.102-ocaml4.01` | `2.40.102` | `4.01`  |

## Installing fswatch Locally
Get fswatch using `brew install fswatch` on Mac OS X otherwise [download and compile from a release build](http://emcrisostomo.github.io/fswatch/).

## License
This docker image is licensed under GPLv3 because Unison is licensed under GPLv3 and is included in the image. See LICENSE.
