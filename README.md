# debug-container
This is an image containing a set of popular utilities for debugging networks in containerized environments.
`kubectl` is also included, allowing for scripting and interaction with Kubernetes API.

# Usage:

## In Docker/podman/nerdctl:

## As a regular pod:
```
kubectl run my-debug-pod --rm -ti --image ghcr.io/tomekgl/debug-container:latest
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
Attach to the pod with debug image:
```
⋊> root@vpsc ⋊> ~ kubectl debug -it pod-under-test --image=ghcr.io/tomekgl/debug-container:latest --target=pod-under-test
Targeting container "pod-under-test". If you don't see processes from this container it may be because the container runtime doesn't support this feature.
Defaulting debug container name to debugger-25fv9.
If you don't see a command prompt, try pressing enter.
pod-under-test2:/# ps axuw
PID   USER     TIME  COMMAND
    1 root      0:00 sleep 1d
    7 root      0:00 /bin/bash
```

