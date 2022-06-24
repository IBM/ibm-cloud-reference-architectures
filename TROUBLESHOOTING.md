
# Uninstalling

To uninstall this solution:

- Use the `./launch.sh` script to enter the docker container that was used to install this software package as described in [README.md](./README.md)
- Navigate to the `/workspaces/current` folder:
  ```
  cd /workspaces/current
  ```
- There are 2 ways you can uninstall this solution:
  - Use the `/destroy-all.sh` script to uninstall all layers of the solution
  - Navigate into the specific subdirectories of the solution and remove specific layers.  These steps should be applied for all layers, in reverse order, starting with the highest-numbered layer first.  Repeat for all layers/subfolders in your solution.
    ```
    cd 200-openshift-gitops 
    terraform init
    terraform destroy --auto-approve
    ```

# Troubleshooting

## Credentials not working

If you encounter unexpected behavior on login or see error message similar to the following, then its likely that your credentials are invalid.
```
The ApiKey property is invalid.  Please remove any surrounding {, }, or \" characters.
```

This normally happens if the credentials inside of the `credentials.properties` file are wrapped with quotes.   All values inside the `credentials.properties` should *not* be wrapped in quotes.

To remedy this scenario:

- If you are inside the container that is created using the `launch.sh` script, exit by using the `exit` command.
- Modify the contents of the `credentials.properties` file and ensure that values are *not* wrapped in quotes.
  - `TF_VAR_ibmcloud_api_key="ABCXYZ"` is **incorrect**
  - `TF_VAR_ibmcloud_api_key=ABCXYZ` is **correct** 
- Re-launch the `launch.sh` script.
- Navigate to the `/workspaces/current` folder and continue the task where you encountered issues.

## Variables may not be used here.

You may encounter an error message containing `Variables may not be used here.` during `terraform` execution, similar to the following:

```
│ Error: Variables not allowed
│
│   on terraform.tfvars line 1:
│    1: cluster_login_token=asdf
│
│ Variables may not be used here.
```

This error happens when values in a `tfvars` file are not wrapped in quotes.  In this case `terraform` interprets the value as a variable reference, which does not exist.  

To remedy this situation, wrap the value in your `terraform.tfvars` in quotes.

For example:
- `cluster_login_token=ABCXYZ` is **incorrect**
- `cluster_login_token="ABCXYZ"` is **correct**



## Intermittent network failures when using Colima

If you are using the `colima` container engine (replacement for Docker Desktop), you may see random network failures when the container is put under heavy network load.  This happens when the internal DNS resolver can't keep up with the container's network requests.  The workaround is to switch colima to use external DNS instead of it's own internal DNS.

Steps to fix this solution:

1. Stop Colima using `colima stop`
2. Create a file `~/.lima/_config/override.yaml` containing the following:
  ```
  useHostResolver: false
  dns:
  - 8.8.8.8
  ```
3. Restart Colima using `colima start`
4. Resume your activities where you encountered networking failures.  It may be required to execute a `terraform destroy` command to cleanup invalid/bad state due to network failures.


## Resources stuck in `Terminating` state

When deleting resources, the namespaces used by the solution occasionally will get stuck in a `terminating` or inconsistent state.  Use the following steps to recover from these conditions:

Follow these steps:
- run `oc get namespace <namespace> -o yaml` on the CLI  to get the details for the namespace.  Within the yaml output, you can see if resources are stuck in a `finalizing` state.
- Get the details of the remaining resource `oc get <type> <instance> -n <namespace> -o yaml` to see details on the resources that are stuck and have not been cleaned up.  The `<type>` and `<instance>` can be found in the output of the previous `oc get namespace <namespace> -o yaml` command.
- Patch the instances to remove the stuck finalizer: `oc patch <type> <instance> -n <namespace> -p '{"metadata": {"finalizers": []}}' --type merge`
- Delete the resource that was stuck: `oc delete <type> <instance> -n <namespace>`
- Go into **ArgoCD** instance and delete the remaining argo applications

## Workspace permission issues

### Root user on Linux

If you are running on a linux machine as `root` user, the `terraform` directory is locked down so that only root had write permissions.  When the `launch.sh` script puts you into the docker container, you are no longer root, and you encounter `permission denied` errors when executing `setupWorkspace.sh`. 

If the user on the host operating system is `root`, then you have to run `chmod g+w -R .` before running `launch.sh` to allow the terraform directory to be group writeable.   Once you do this, the permission errors go away, and you can follow the installation instructions.   

### Legacy launch.sh script

IF you are not encountering the root user issue described above, and You may encounter permission errors if you have previously executed this terraform automation using an older `launch.sh` script (prior to June 2022).  If you had previously executed the older `launch.sh` script, it mounted the `workspace` volume with `root` as the owner.  The current `launch.sh` script mounts the `workspace` volume as the user `devops`.  When trying to execute commands, you will encounter permission errors, and `terraform` or `setupWorkspace.sh` commands will only work if you use the `sudo` command.  

If this is the case, the workaround is to remove the `workspace` volume on your system, so that it can be recreated with the proper ownership.

To do this:

- Exit the container using the `exit` command
- Verify that you have the `workspace` volume by executing `docker volume list`
- Delete the `workspace` volume using `docker volume rm workspace`
  - If this command fails, you may first have to remove containers that reference the volume.   User `docker ps` to list containers and `docker rm <container>` to remove a container.  After you delete the container, re-run `docker volume rm workspace` to delete the `workspace` volume.
- Use the `launch.sh` script reenter the container.
- Use the `setupWorkspace.sh` script as described in the [README.md](./README.md) to reconfigure your workspace and continue with the installation process.

You should *never* use the `sudo` command to execute this automation.  If you have to use `sudo`, then something is wrong with your configuration.

# That didn't work, what next?

If you continue to experience issues with this automation, please [file an issue](https://github.com/IBM/automation-solutions/issues) or reach out on our [public Dischord server](https://discord.com/channels/955514069815808010/955514069815808013).

