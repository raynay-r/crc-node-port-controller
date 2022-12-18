# Node Port Controller

This controller allows to access NodePort Services running inside CodeReady Containers from the host when in vsock network mode.

The controller listens to change events on services inside the cluster and exposes/unexposes the ports utilizing the 
gvisor-tap-vsock (see: https://github.com/containers/gvisor-tap-vsock/) API. 

# Prerequisites

1. Running CRC Cluster. See: https://github.com/crc-org/crc
2. oc command line tool. See: https://docs.openshift.com/container-platform/4.8/cli_reference/openshift_cli/getting-started-cli.html

# Usage

1. Clone the repository

    `git clone https://github.com/raynay-r/crc-node-port-controller.git`

2. Switch to the cloned repository
    
    `cd node-port-controller`

3. Create the Openshift project where the controller will run

    `oc apply -f manifests/project.yaml`

4. Create ServiceAccount with appropriate rights which will be used to run the controller

   `oc apply -f manifests/serviceaccount.yaml`

5. Create BuildConfig for building the Image inside Openshift

    `oc apply -f manifests/buildconfig.yaml`

6. Run the build to create the image

    ```
    oc project node-port-controller
    oc start-build node-port-controller-build --from-dir . --follow
    ```

7. Create the deployment

    `oc apply -f manifests/deployment.yaml`
