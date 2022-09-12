module "Network" {
  source          = "../modules/private-subnet"
  name            = var.name
  vpc_id          = module.Data.vpc_id
  public_subnet_b = var.public_subnet_b
  public_subnet_a = var.public_subnet_a
  private_b_cidr  = var.private_b_cidr
  private_a_cidr  = var.private_a_cidr
}