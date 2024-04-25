vpc_cidr                 = "172.31.0.0/16" # Default
private_subnet1_cidr     = "172.31.100.0/24"
private_subnet2_cidr     = "172.31.101.0/24"
public_subnet1_cidr      = "172.31.200.0/24"
public_subnet2_cidr      = "172.31.201.0/24"

# RDS
database_name            = "petclinic"
database_master_username = "petclinic"

# Task
container_cpu = 256
container_memory_hard = 1024

# ASG
database_instance_class  = "db.t3.medium"
asg_min_size = 1
asg_max_size = 3

# Capacity Provider
cp_min_scaling_step_size = 1
cp_max_scaling_step_size = 2
cp_target_capacity = 100