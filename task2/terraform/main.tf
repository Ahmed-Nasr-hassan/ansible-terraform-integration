module "creating-public-ec2-instances" {
  source = "./ec2-instances-config"
  count = 1
  key-name = var.key-name
  path-to-pem-file = var.path-to-pem-file
  is_public = true
  item-count = count.index + 1
}
