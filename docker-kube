#!/usr/bin/env bash

docker_cli_plugin_metadata() {
	local vendor="xinity"
	local version="v0.0.1"
	local url="https://github.com/xinity/docker-kube"
	local description="Manage your Kubernetes Cluster with Docker CLI UX"
	cat <<-EOF
	{"SchemaVersion":"0.1.0","Vendor":"${vendor}","Version":"${version}","ShortDescription":"${description}","URL":"${url}"}
EOF
}

#################
#Help  function #
#################
khelp()
{
   # Display Help
   echo "Usage: docker kube COMMAND"
   echo
   echo "A docker plugin to manage your kubernetes using docker CLI UX"
   echo
   echo "Commands:"
   echo "run         Create and run a pod"
   echo "up          Apply one or more kubernetes manifests"
   echo "ls          List given resource kind (i.e: pod or services ...)"
   echo "inspect     Inspect a Given resource kind (i.e describe pod ...) "
   echo "logs        Output given pod logs"
   echo "help        Print this Help."
   echo
}

remap_help() {
    if [[ "${2}" == "-h" || "${2}" == "--help" ]]
    then
    kubectl "${1}" -h | sed 's/kubectl/docker kube/g'
    exit 0
    fi
}
# kubectl run
krun() {
    remap_help run "${@}"
    kubectl run "${@}"
}

# kubectl apply 
kapply() {
    remap_help apply "${@}"
    kubectl apply "${@}"
}

# kubectl get
kget() {
    remap_help get "${@}"
    kubectl get "${@}"
}

# kubectl get
kdescribe() {
    remap_help describe "${@}"
    kubectl describe "${@}"
}

# kubectl log
klogs() {
    remap_help logs "${@}"
    kubectl logs "${@}"
}

case "${1}" in
        docker-cli-plugin-metadata)
                docker_cli_plugin_metadata
                ;;
        *)
		shift
        case "${1}" in
            run)

                krun "${@:2}"
                ;;
            up)
                kapply "${@:2}"
                ;;
            ls)
                kget "${@:2}"
                ;;
            inspect)
                kdescribe "${@:2}"
                ;;
            logs)
                klogs "${@:2}"
                ;;
            *)
                khelp
                ;;
        esac
        ;;
esac