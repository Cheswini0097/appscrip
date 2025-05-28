resource "aws_key_pair" "eks" {
  key_name   = "eks"
  #you can paste the public key directly like this
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8WdEavd+3kWr1rfHW+cLQ9uOTXQIt9aw3Py0WXSfa0BduaSnD2a9TeuelfKVWP6dN0piJTNTLcuPmvWiHI1WpuosE1ambw1xA2naYOCfOUzmIhPdHzIkSTWqUpnp/MH8sZlHDOhSJyZUYJnO8Do/iD+vhm5xMf8ousF2QxYaN0Euc5gRIKEJoWNi1JAGx3p3vdnNDOOmSDAIpW4ay+JGjF7KKAw9SVP9f0eV3PcgeTacGhsFMo8hl8D7z7qEybfAxQ6Ofg0foo4SrbEOZnhCU2kJEoKVQgXv3JTnZBxIJY8R4BjW5EZVziNtkCpbER6BiDPfhX9sewt/weCj0VJheE8/Z5tRJLc7TOKx+gQqUzKboYb/FpxXcRtPx8C6hKlFlC9fn+vdW0B/SPONjaVmacn7CH7kMCll6B3nYXb2OUm03GvEPYtxmTaVCGuxYJLeXh9EQXQAJ96EBIowIyD4Zn2GZ3vzG1jD7WsLwBqzHydCq/haYhnMRvS7w3TQZZ8MqEVWwlpK3NqkFLczldh8pvsr17e3FOMP2KYdst+2Ym701OfbGdppp3B0lSjoyfccM1Cr4g2Al2t0cZlRGxej0BKrm7ScjCCcxUTgRNyLQgg07vkmGtIDb7rcIagnn1vF6id4nYrAf9GZQA305izfMXtaWvlHXfmeoNTFwnyQ1Mw== coding-challange"
#   public_key = file("~/.ssh/eks.pub")
 
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"


  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = "1.31"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = "vpc-056cc33b9ab2530c6"
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.private_subnets

  create_cluster_security_group = false
  cluster_security_group_id     = "sg-00acd1a6a04d124ca"

  create_node_security_group = false
  node_security_group_id     = "sg-08e841782ad95ae5c"

 
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      min_size      = 2
      max_size      = 10
      desired_size  = 2
      #capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
      
      key_name = aws_key_pair.eks.key_name
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = var.common_tags
}