output "sg_id" {
  value = module.network.sec_group_id
}
output "subnet_id" {
  value = module.network.subnet_id
}
output "vpc_id" {
    value = module.network.vpc_id
}
output "target_group" {
  value = module.application_load.target_group
}