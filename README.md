# terraform-plan-analysis-policy

This is a raw policy that can be used to analyze Terraform plans.
It's a port of this [OPA Terraform policy](https://www.openpolicyagent.org/docs/latest/terraform/#getting-started).

## Usage

Save the terraform plan to JSON:

```bash
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
```

The policy accepts a request in this format:

```json
{
    "request": <your terraform plan in JSON format>
    "settings": {
        "threshold": 30
    }
}
```

## Score

The policy computes a score for a Terraform that combines

- The number of deletions of each resource type
- The number of creations of each resource type
- The number of modifications of each resource type

The policy authorizes the plan when the score for the plan is below a threshold and there are no changes made to any IAM resources.

The threshold is configurable via the `threshold` setting.
