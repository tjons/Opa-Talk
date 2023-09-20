package kubernetes.admission

# These rules are treated as an OR, so if any of them match, the resource will be deemed invalid.

deny[msg] {
    # ensure that we are dealing with a deployment
    input.request.kind.kind == "Deployment" # will quit if not a deployment
    container := input.request.object.spec.template.spec.containers[_] # iterate through all containers in the deployment spec template
    not container.resources # check to see if the container.resources field is empty
    msg := sprintf("No resources specified for container %s", [container.name])
}

deny[msg] {
    container := input.request.object.spec.template.spec.containers[_] # iterate through all containers in the deployment spec template
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