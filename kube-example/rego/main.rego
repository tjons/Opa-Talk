package system

# import the kubernetes admission package
import data.kubernetes.admission

# create a kubernetes admission review object as our response
# opa will return data.system.main
main := {
	"apiVersion": "admission.k8s.io/v1",
	"kind": "AdmissionReview",
	"response": response,
}

default uid := ""

# copy the request uid that k8s sends us
uid := input.request.uid

# set response to this object if the rule matches
response := {
	"allowed": false,
	"uid": uid,
	"status": {"message": reason},
} {
	# combine all the response reasons 
	reason = concat(", ", admission.deny)

	# if the reason isn't empty, we'll use this response
	reason != ""
}

else := {"allowed": true, "uid": uid}
