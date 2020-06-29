# Shortlink Runbook
The role will install:
  - Dynamodb(multyregional)
  - ECS cluster
  - Shortlink app
### Requirements
1. aws_access_key_id and aws_secret_access_key for infrasture deployment
2. aws_access_key_id and aws_secret_access_key for access to dynamodb

### Installation

```sh
$ docker build -t reversaidx/jetbrains:v0.3 .
$ docker push reversaidx/jetbrains:v0.3
$ cd terraform/dynamodb && terraform apply 
$ cd ../ecs && terraform apply 
```
It's better to use s3 as terraform backend: 
1. Create s3 bucket
2. rename backend-s3.tf_disabled to backend-s3.tf_disabled with fixed name

### Updating Application
1. Rebild docker 
2. Apply terraform defenition 
Example:
```sh
docker build -t reversaidx/jetbrains:v0.3 . && docker push reversaidx/jetbrains:v0.3
cd terraform/ecs && terraform apply
```