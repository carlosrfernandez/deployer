# deployer
container to manage environment in cloud

### hive
The project use [hive](https://github.com/tdeheurles/hive) to build its container. 

See [documentation](https://tdeheurles.gitbooks.io/hive/content/index.html) for further informations.

This command will build, run and output the logs:

```bash
id=0; ./hive do build devops deployer id $id; ./hive do run devops deployer id $id; docker logs deployer
```
