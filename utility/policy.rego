package policy

import data.terraform.analysis

main = {
	"apiVersion": "admission.k8s.io/v1",
	"kind": "AdmissionReview",
	"response": response,
}

default uid = ""
uid = input.request.uid

response = {
	"uid": uid,
	"allowed": false,
	"status": {"message": reason},
} {
	reason = concat(", ", analysis.deny)
	reason != ""
} else = {
	"uid": uid,
	"allowed": true,
} {
	true
}
