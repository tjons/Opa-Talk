package kubernetes.admission

deny [msg] {
    # ensure that we are dealing with a deployment
    input.request.kind.kind == "Deployment"
    container := input.request.object.spec.template.spec.containers[_]
    not container.resources
    msg := sprintf("No resources specified for container %s", [container.name])
}

deny[msg] {
    container := input.request.object.spec.template.spec.containers[_]
    not container.resources.limits
    msg := sprintf("No resource limits specified for container %s", [container.name])
}

deny[msg] {
    container := input.request.object.spec.template.spec.containers[_]
    not container.resources.limits.cpu
    msg := sprintf("No CPU limit specified for container %s", [container.name])
}

deny[msg] {
    container := input.request.object.spec.template.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf("No memory limit specified for container %s", [container.name])
}