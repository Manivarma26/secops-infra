terraform {
  backend "s3" {
    bucket         = "manivarma-secops-terraform-state"
    key            = "global/secops-infra/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "compliance_s3" {
  source      = "./modules/s3"
  bucket_name = "manivarma-secops-compliance-reports"
  tags = {
    Environment = "dev"
    Owner       = "SecOps"
  }
}

module "secops_kms" {
  source     = "./modules/kms"
  alias_name = "secops-master-key"
  tags = {
    Environment = "dev"
    Owner       = "SecOps"
  }
}

module "secops_ecr" {
  source          = "./modules/ecr"
  repository_name = "secops-hardened-images"
  kms_key_arn     = module.secops_kms.kms_key_arn
  tags = {
    Environment = "dev"
    Owner       = "SecOps"
  }
}

module "glue_athena" {
  source                = "./modules/glue-athena"
  database_name         = "secops_compliance_db"
  workgroup_name        = "secops_athena_wg"
  glue_iam_role_arn     = "arn:aws:iam::661539128717:role/AWSGlueServiceRole-SecOps"
  s3_data_path          = "s3://manivarma-secops-compliance-reports/"
  query_output_location = "s3://manivarma-secops-compliance-reports/query-results/"
  kms_key_arn           = module.secops_kms.kms_key_arn
  tags = {
    Environment = "dev"
    Owner       = "SecOps"
  }
}

module "opensearch_secops" {
  source      = "./modules/opensearch"
  domain_name = "secops-analytics"
  kms_key_arn = module.secops_kms.kms_key_arn
  allowed_ip  = "49.207.209.96/32" # Replace with your IP
  tags = {
    Environment = "dev"
    Owner       = "SecOps"
  }
}

module "athena_to_opensearch" {
  source                      = "./modules/athena-to-opensearch"
  lambda_package              = "${path.module}/lambda_package.zip"
  lambda_role_arn             = "arn:aws:iam::661539128717:role/SecOpsLambdaRole"
  opensearch_endpoint         = module.opensearch_secops.opensearch_endpoint
  s3_query_output_bucket_name = "manivarma-secops-compliance-reports"
  s3_query_output_bucket_arn  = "arn:aws:s3:::manivarma-secops-compliance-reports"
  region                      = "ap-south-1"
}


resource "null_resource" "init_check" {
  provisioner "local-exec" {
    command = "echo Terraform initialized successfully for SecOps Infra!"
  }
}
