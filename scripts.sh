az policy definition create --name TaggingPolicy --rules policy.json
az policy assignment create --policy TaggingPolicy
az policy assignment list
az policy definition delete --name TaggingPolicy

az image list
packer build demo.json
az image list

terraform init
terraform plan -out solution.plan
terraform apply "solution.plan"
terraform show
terraform destroy
terraform show

az image delete -g cloud-shell-storage-centralindia -n myPackerImage
az image list