# debug-container
This is an image containing a set of popular utilities for debugging networks in containerized environments.
`kubectl` is also included, allowing for scripting and interaction with the Kubernetes API.

# Usage:

## In Docker/podman/nerdctl

Interactive session with a default shell [Fish](https://fishshell.com/docs/current/tutorial.html):
```
docker run --rm -ti ghcr.io/tomekgl/debug-container:latest
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
root@949a8d396c81 /#
```

With a given command:
```
> docker run --rm -ti ghcr.io/tomekgl/debug-container:1.2.0 ping -c1 google.com
PING google.com (2a00:1450:4001:831::200e): 56 data bytes
64 bytes from 2a00:1450:4001:831::200e: seq=0 ttl=121 time=29.298 ms
```

With Bash shell:
```
docker run --rm -ti ghcr.io/tomekgl/debug-container:1.2.0 /bin/bash
5a9eed15816a:/#
```

Running a Bash one-liner:
```
docker run --rm -ti ghcr.io/tomekgl/debug-container:1.2.0 /bin/bash -c 'echo $HOSTNAME && echo ${HOSTNAME^^}'
0776f193a7b9
0776F193A7B9
```

## As a regular pod
```
kubectl run my-debug-pod --rm -ti --image ghcr.io/tomekgl/debug-container:latest
```

## Accessing Kubernetes node's root filesystem/network/PID namespaces
```
kubectl debug node/ip-172-16-1-2.eu-west-1.compute.internal -it --image=ghcr.io/tomekgl/debug-container:1.1.1
```

## As a debug container attaching to a running pod (shares the same PID & net namespace and mounted filesystems)
This requires Kubernetes 1.25+
```
⋊> root@vpsc ⋊> ~ kubectl run pod-under-test --image bash -- sleep 1d
pod/pod-under-test created
⋊> root@vpsc ⋊> ~ kubectl get pods --show-labels -A
NAMESPACE     NAME                                       READY   STATUS    RESTARTS        AGE     LABELS
default       pod-under-test                            1/1     Running   0               6s      run=pod-under-test
```
Attach to the pod with the debug image:
```
⋊> root@vpsc ⋊> ~ kubectl debug -it pod-under-test --image=ghcr.io/tomekgl/debug-container:latest --target=pod-under-test
Targeting container "pod-under-test". If you don't see processes from this container it may be because the container runtime doesn't support this feature.
Defaulting debug container name to debugger-25fv9.
If you don't see a command prompt, try pressing enter.
pod-under-test:/# ps axuw
PID   USER     TIME  COMMAND
    1 root      0:00 sleep 1d
    7 root      0:00 /bin/bash
```
