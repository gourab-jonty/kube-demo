module "Data" {
  source       = "../modules/data"
  vpc_tag_name = var.vpc_name
  region       = var.region
}
