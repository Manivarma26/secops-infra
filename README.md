# SecOps Infrastructure
This repository provisions the foundational AWS infrastructure for the Enterprise SecOps Platform:
- S3 for compliance reports
- KMS for encryption
- IAM OIDC for GitHub Actions
- Glue + Athena for analytics
- ECR for image registry
- OpenSearch for dashboards

## Structure
- `modules/` → reusable Terraform modules for each AWS resource type
- `envs/` → environment-level configurations (`prod`, `stage`)
- `.github/workflows/` → automation workflows
