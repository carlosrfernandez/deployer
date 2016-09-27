# Quick setup for developers
### You need to install docker
Install the linux version of docker on your machine.
- [windows user](https://www.docker.com/products/docker#windows)
- [linux user](https://www.docker.com/products/docker#linux)
- [mac user](https://www.docker.com/products/docker#mac)

### Setup, build and run
First, prepare your `AWS ACCESS KEY ID` and `AWS ACCESS SECRET KEY`.

Then start a bash terminal and run:

```console
# from project root
$ cd inits
$ ./main

SETUP SECRETS
Please enter your AWS Access Key Id:
XXXXXXXXXXXXXXXXXXXXXX
Please enter your AWS Secret Access Key:
XXXXXXXXXXXXXXXXXXXXXX

BUILD AND TEST
Sending build context to Docker daemon 19.97 kB
Step 1 : FROM golang
 ---> 002b233310bb
Step 2 : MAINTAINER tdeheurles@gmail.com
 ---> Using cache
 ---> 59281b4d772c
Step 3 : ENV GOPATH /go
 ---> Using cache
 ---> c5c4a9080dda
Step 4 : RUN go get github.com/aws/aws-sdk-go/...
 ---> Using cache
 ---> 6a883ec4edfe
Step 5 : RUN go get gopkg.in/yaml.v2
 ---> Using cache
 ---> eb755e415186
Step 6 : COPY deployer /go/src/deployer
 ---> Using cache
 ---> 445d5fafef9b
Step 7 : WORKDIR /go/src/deployer
 ---> Using cache
 ---> a7328a59a3de
Step 8 : RUN go build -v
 ---> Using cache
 ---> 85b8e6f98b62
Step 9 : RUN go install -v
 ---> Using cache
 ---> 481fb414b648
Step 10 : RUN go test
 ---> Using cache
 ---> 047dd0177bd1
Step 11 : ENV DEPLOYER_VERSION "0.0.0"
 ---> Using cache
 ---> fe6d492e2d93
Step 12 : ENTRYPOINT deployer
 ---> Using cache
 ---> a813c2420ebf
Successfully built a813c2420ebf

RUN
NAME:
   deployer - Manage cloud environment

USAGE:
    deployer [global options] command [command options] [arguments...]

VERSION:
    0.0.0

COMMANDS:
      help, h  Shows a list of commands or help for one command
      describe  give details on an environment and its current status

GLOBAL OPTIONS:
    --help, -h     show help
    --version, -v  print the version

Exit code: 0

```

The `inits/main` script:
- ask for your `AWS ACCESS KEY ID` and `AWS ACCESS SECRET KEY`
- setup these secrets in a docker volume
- use `hive` to `build` and `test` the project
- run the `deployer` container

### hive
The project use [hive](https://github.com/tdeheurles/hive) to build its container.

See [documentation](https://tdeheurles.gitbooks.io/hive/content/index.html) for further informations.

This command will build, test and run the deployer (it can be used as code iteration):
```console
# from project root
$ ./deployer

BUILD AND TEST
Sending build context to Docker daemon 19.97 kB
[...]
Successfully built a813c2420ebf

RUN
NAME:
   deployer - Manage cloud environment

USAGE:
    deployer [global options] command [command options] [arguments...]

VERSION:
    0.0.0

COMMANDS:
      help, h  Shows a list of commands or help for one command
      describe  give details on an environment and its current status

GLOBAL OPTIONS:
    --help, -h     show help
    --version, -v  print the version

Exit code: 0

```

You will be able to test the different commands by running `deployer` with any parameters:
```console
# from project root
$ ./deployer describe

BUILD AND TEST
Sending build context to Docker daemon 19.97 kB
[...]
Successfully built a813c2420ebf

RUN
USAGE:
 .\devops.ps1 describe -i|id NAME [options]

 Mandatory:
   -i|id     A string id to distinct your unit, it must only contains alphanumeric characters

 Examples:
   - .\devops.ps1 describe -id environment


Exit code: 1

```

### Intellij and Go
The project use a go container to build but you need to [install golang](https://golang.org/dl/) for intellij to understand your code.

Install the project dependencies:
```console
# from project root
$ cd inits
$ ./init_go_libs
```

Then, you need to setup your GOBIN and GOPATH in order that Intellij find your sources.

`GOBIN` is totally depend on your installation path. As an example:
```console
$ echo $GOBIN
C:\Go\bin
```

Intellij require some additions to your `GOPATH`:
```console
$ echo $GOPATH
C:\Go\src;C:\Go\src\src
```
