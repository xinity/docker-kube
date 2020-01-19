# docker-kube:
a docker plugin to manage a kubernetes cluster with the docker CLI UX

## Goal:
While giving docker and kubernetes training i've seen people struggling switching from the Docker CLI UX to the kubernetes CLI UX.  

This docker plugin aims at offering the same UX managing either docker and/or kubernetes resources.

## How to use:
### Docker image:
A docker image is available to test the plugin without having to install it locally.  
For this image to work properly you should mount your `docker.sock` and your kubernetes config file ( most of the time  `~/.kube/config` ).  

Tags available can be found here: [docker tags](https://hub.docker.com/repository/docker/rzarouali/docker-kube/tags)

#### Examples: 
Looking at the help option:  
` docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube/config:/root/.kube/config docker-kube:0.1 help `  

Looking at sub-command help option:  
` docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube/config:/root/.kube/config docker-kube:0.1 ls --help `  

```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube/config:/root/.kube/config docker-kube:dev ls --help   

***snip***

Examples:
  # List all pods in ps output format.
  docker kube get pods
  
  # List all pods in ps output format with more information (such as node name).
  docker kube get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format.
  docker kube get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group:
  docker kube get deployments.v1.apps -o json
  
  # List a single pod in JSON output format.
  docker kube get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format.
  docker kube get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml.
  docker kube get -k dir/
  
***snip***
```

### Git clone:
#### installation:
``` 
# create if needed the cli-plugins directory in your $HOME
mkdir -p ~/.docker/cli-plugins/

# clone the repository
git clone https://github.com/xinity/docker-kube

# copie the docker plugin to the cli-plugins directory
cp -ap docker-kube ~/.docker/cli-plugins/
chmod + x ~/.docker/cli-plugins/docker-kube
```
#### Examples:
Looking at the help:  
` docker kube help `  

Looking at sub-command help:  
` docker kube up --help `  

```
docker kube up --help   

***snip***
Apply a configuration to a resource by filename or stdin. The resource name must be specified. This resource will be created if it doesn't exist yet. To use 'apply', always create the resource initially with either 'apply' or 'create --save-config'.

 JSON and YAML formats are accepted.

 Alpha Disclaimer: the --prune functionality is not yet complete. Do not use unless you are aware of what the current state is. See https://issues.k8s.io/34274.

Examples:
  # Apply the configuration in pod.json to a pod.
  docker kube apply -f ./pod.json
  
  # Apply resources from a directory containing kustomization.yaml - e.g. dir/kustomization.yaml.
  docker kube apply -k dir/
  
  # Apply the JSON passed into stdin to a pod.
  cat pod.json | docker kube apply -f -
  
  # Note: --prune is still in Alpha
  # Apply the configuration in manifest.yaml that matches label app=nginx and delete all the other resources that are not in the file and match label app=nginx.
  docker kube apply --prune -f manifest.yaml -l app=nginx
  
  # Apply the configuration in manifest.yaml and delete all the other configmaps that are not in the file.
  docker kube apply --prune -f manifest.yaml --all --prune-whitelist=core/v1/ConfigMap

***snip***
```

Describe a Kubernetes Pod:  
` docker kube:0.1 inspect po grafana-58dc7468d7-t28dj -n monitoring  `

```
Name:         grafana-58dc7468d7-t28dj
Namespace:    monitoring
Priority:     0
Node:         gilgamesh/192.168.2.229
Start Time:   Wed, 15 Jan 2020 16:32:50 +0000
Labels:       app=grafana
              pod-template-hash=58dc7468d7
Annotations:  <none>
Status:       Running
IP:           10.1.24.172
IPs:
  IP:           10.1.24.172
Controlled By:  ReplicaSet/grafana-58dc7468d7
Containers:
  grafana:
    Container ID:   containerd://cf6459157ceda404baa777855eb56a4f780f26538de9b452e43e734ee6481f65
    Image:          grafana/grafana:6.4.3
    Image ID:       docker.io/grafana/grafana@sha256:bd55ea2bad17f5016431734b42fdfc202ebdc7d08b6c4ad35ebb03d06efdff69
    Port:           3000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 19 Jan 2020 10:02:06 +0000
    Last State:     Terminated
      Reason:       Unknown
      Exit Code:    255
      Started:      Fri, 17 Jan 2020 17:49:33 +0000
      Finished:     Sun, 19 Jan 2020 10:01:09 +0000
    Ready:          True
    Restart Count:  10
    Limits:
      cpu:     200m
      memory:  200Mi
    Requests:
      cpu:        100m
      memory:     100Mi
    Readiness:    http-get http://:http/api/health delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:
***snip***
```