#!/usr/bin/env bats

@test "accept: score level below blast radius" {
  run kwctl run -e opa annotated-policy.wasm -r test_data/tfplan.json -s test_data/settings.json

  # this prints the output when one the checks below fails
  echo "output = ${output}"

  # request accepted
  [ "$status" -eq 0 ]
  [ $(expr "$output" : '.*allowed.*true') -ne 0 ]
}

@test "reject: plan is too large" {
  run kwctl run -e opa annotated-policy.wasm -r test_data/tfplan_large.json -s test_data/settings.json

  # this prints the output when one the checks below fails
  echo "output = ${output}"

  # request accepted
  [ "$status" -eq 0 ]
  [ $(expr "$output" : '.*allowed.*false') -ne 0 ]
  [ $(expr "$output" : '.*Score 31 > blast radius 30.*') -ne 0 ]
}
