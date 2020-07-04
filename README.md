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
$ cd terraform/apps/shortlink && terraform apply 

```

### Updating Application
1. Rebild docker 
2. Apply terraform defenition 
Example:
```sh
docker build -t reversaidx/jetbrains:v0.3 . && docker push reversaidx/jetbrains:v0.3
cd terraform/apps/shortlink && terraform apply 
```
### To do
1. Add cdn
2. Use uwsgi instead python as frontend
....