# Automation runtime environments

## Supported runtimes

There are two supported runtimes where the automation is expected to be executed inside of:

1. [Docker Desktop](#docker-desktop) (Container engine)
2. [Multipass](#multipass) (VM)

The Terraform automation can be run from the local operating system, but it is recommended to use either of the runtimes listed above, which provide a consistent and controlled environment, with all dependencies preinstalled.

### Docker Desktop

[Docker Desktop](https://docs.docker.com/desktop/) is an easy-to-use application that enables you to build and share containerized applications.

It provides a simple interface that enables you to manage your containers, applications, and images directly from your machine without having to use the CLI to perform core actions.

Docker Desktop is supported across Mac, Windows, and Linux, and can be downloaded and installed directly from: <https://www.docker.com/products/docker-desktop/>

Once installed, use the automation template's `launch.sh` script to launch an interactive shell where the Terraform automation can be executed.

### Multipass

[Multipass](https://multipass.run/) is a simplified Ubuntu Linux Virtual Machine that you can spin up with a single command.   With this option you spin up a virtual machine with a predefined configuration that is ready to run the Terraform automation.

You can download and install Multipass from <https://multipass.run/install>

Once you have installed Multipass, open up a command line terminal and `cd` into the *parent* directory where you cloned the automation repo.

Download the [cloud-init](https://github.com/cloud-native-toolkit/sre-utilities/blob/main/cloud-init/cli-tools.yaml) script for use by the virtual machine using:

```text
curl https://raw.githubusercontent.com/cloud-native-toolkit/sre-utilities/main/cloud-init/cli-tools.yaml --output cli-tools.yaml
```

The `cli-tools` cloud init script prepares a VM with the same tools available in the quay.io/cloudnativetoolkit/cli-tools-ibmcloud container image. Particularly:

- `terraform`
- `terragrunt`
- `git`
- `jq`
- `yq`
- `oc`
- `kubectl`
- `helm`
- `ibmcloud cli`

Launch the Multipass virtual machine using the following command:

```text
multipass launch --name cli-tools --cloud-init ./cli-tools.yaml
```

This will take several minutes to start the virtual machine and apply the configuration.

Once the virtual machine is started, you need to mount the local  file system for use within the virtual machine.

Then mount the file system using the following command:

```text
multipass mount $PWD cli-tools:/automation
```

This will mount the parent directory to the `/automation` directory inside of the virtual machine.

> ⚠️ MacOS users may encounter the following error if Multipass has not been granted file system access.
>
> ```text
> mount failed: source "{current directory}" is not readable
> ```
>
> If you encounter this error, then you need to enable full disk access in the operating system before you can successfully mount the volume.  Go to `System Preferences`, then go to `Security and Privacy`, and select the `Privacy` tab.  Scroll the list on the left and select "Full Disk Access" and allow access for `multipassd`.
>
> ![Multipass security settings](https://github.com/cloud-native-toolkit/automation-solutions/raw/main/common-files/multipass-security.png)
>
> After granting access to `multipassd`, then re-run the `multipass mount $PWD cli-tools:/automation` command.

Once the virtual machine has started, run the following command to enter an interactive shell:

```text
multipass shell cli-tools
```

Once in the shell, `cd` into the `/automation/{template}` folder, where `{template}` is the Terraform template you configured.  Then you need to load credentials into environment variables using the following command:

```text
source credentials.properties
```

Once complete, you will be in an interactive shell that is pre-configured with all dependencies necessary to execute the Terraform automation.

> ⚠️ Some MacOS users have reported network connectivity issues with Multipass when Cisco Anyconnect VPN is running at the same time.  If you encounter this issue, please quit Cisco Anyconnect and restart the Multipass VM. AnyConnect cannot be restarted while Multipass is running or the network will be killed, which will break any in progress deployments.

----

## Unsupported runtimes

Additional container engines, such as podman or colima may be used at your own risk. They may work, however, there are known issues using these environments, and the development team does not provide support for these environments.

Known issues include:

1. Network/DNS failures under load
2. Read/write permissions to local storage volumes
3. Issues running binary executables from volumes mounted from the host
4. Time drift issues when hosts are suspended/resumed

### Permissions errors

When using the `launch.sh` script to launch the container used for this automation, you need to add the `-u` parameter to include the user id of the current user.  This will prevent file permission errors on mounted volumes.

Modify the `docker run` command to include the `-u` parameter as shown below:

```bash
echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   --device /dev/net/tun --cap-add=NET_ADMIN \
   -u "${UID}" \
   -v "${SRC_DIR}:/terraform" \
   -v "workspace-${AUTOMATION_BASE}:/workspaces" \
   ${ENV_VARS} \
   -w /terraform \
   ${DOCKER_IMAGE}
```

The `-u` parameter is not added by default because it introduces other permission errors when running in Docker Desktop with this configuration.


### Colima instructions

- Install [Brew](https://brew.sh/)
- Install [Colima](https://github.com/abiosoft/colima) (a replacement for Docker Desktop ) and the **docker** cli

   ```shell
   brew install colima docker
   ```

- More information available at: <https://github.com/abiosoft/colima#installation>

### Podman instructions

Unlike Docker which traditionally has separated a cli from a daemon-based container engine, [Podman](https://podman.io) is a daemon-less container engine originally developed for [Linux](#getting-started-with-podman-for-linux) systems. There is a [MacOS](#getting-started-with-podman-for-macos) port which has sufficient features to support running the automation based on container images. Podman can run containers in root or rootless mode. Current permissions setup in the `launch.sh` script will require rootless mode.

#### Getting started with Podman for MacOS

- Install [Brew](https://brew.sh/)
- Install [Podman](https://podman.io) (a replacement for Docker Desktop ) and the **docker** cli

   ```shell
   brew install podman docker
   ```

- Create a podman machine

   ```shell
   podman machine init
   podman machine start
   ```

Once the podman vm is started, use the `launch.sh` script to launch an interactive shell where the Terraform automation can be executed:

   ```shell
   ./launch.sh podman
   ```

##### Dealing with known issues for Podman on MacOS

- When resuming from suspend, if the podman machine is left running, it will not automatically synchronize to the host clock. This will cause the podman machine to lose time. Either stop/restart the podman machine or define an alias like this in your startup scripts:

    ```shell
    alias fpt="podman machine ssh \"sudo chronyc -m 'burst 4/4' makestep; date -u\""
    ```

  then fix podman time with the `fpt` command.

- There is currently an QEMU bug which prevents binary files that should be executable by the podman machine vm from operating from inside a mounted volume path. This is most common when using the host automation directory, vs a container volume like `/workspaces` for running the automation. Generally the cli-tools image will have any binary needed and the `utils-cli` module will symbolically link, vs. download a new binary into this path. However there can be drift between binaries in `cli-tools` image used by `launch.sh` and those requested to the `utils-cli` module.

#### Getting started with Podman for Linux

- Visit and follow the [installation instructions](https://podman.io/getting-started/installation#installing-on-linux) for your distribution

Once the podman application is installed provide `podman` as the first argument to the automation template's `launch.sh` script to launch an interactive shell where the Terraform automation can be executed:

   ```shell
   ./launch.sh 'podman'
   ```

- More information available at: <https://podman.io/getting-started/installation>
