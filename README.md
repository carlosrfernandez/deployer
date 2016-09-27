# deployer

### What is the deployer
This project proposes a tool to deploy environment on Cloud platform like AWS or GCloud.

`Infrastructure tools` like `Terraform`/`CloudFormation` propose a simplified API to setup cloud infrastructure.
These projects are great but here, the intent is to have an additional layer where we simplify the process of regrouping these resources.

As an example, if you want to use blue/green deployment with your project.
The concept is well known, but when you start working on the implementation,
you quickly understand that infrastructure is not enough.
You will need to define how your node bootstrap, write your proxy logic, define how your autoscaling groups work together etc.

With `deployer`, we try to simplify this. You define how your nodes work together in a description file
and write only the code to setup your services on your virtual machines. A simple check of `alb: true` in the description file will define
the security rules and generate the proxy for you.

### Requirements
Only [docker](https://www.docker.com/products/docker) is needed to run the deployer (Linux version on Linux/Windows/MAC)

### How to use it
##### As a CLI
This command will start your environment, wait for its start and finally run smoke tests on it.
```
./hive deployer e2e -id environmentName
```

Here we start a backend in parallel and gives the time for it to be ready. After some test on it, if you decide to integrate it, you run:
```
./hive deployer stage -id environmentName -service backend -version 2.0
```

At this point, the proxy will redirect traffic from backend_v1.0 to backend_v2.0.
If anything goes wrong, you can run the `switch` command again to use the backend_v1.0 again.
```
./hive deployer switch -id environmentName -service backend
```

And finally, when you think it's time, you `clean` the nodes that are not used anymore.
```
./hive deployer clean -id environmentName -service backend
```

##### As a service
First start the service:
```
./hive deployer serve
```

Then run your commands like with the CLI API:
```
curl https://deployer_address/e2e?id=environmentName
```

### Users
The project is at its first steps and the implementation is in progress.

### Developers
You will find informations [here](documentation/developers_entry_point.md) on how to setup your environment for the project
