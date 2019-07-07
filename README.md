# Wireguard Route53 Integration

This module extends integration to the `terraform-aws-wireguard` module.

The integration provides automatic DNS registration of the Wireguard instances' public ip to your domain.
The registered subdomain will be region segregated such as `vpn.<aws_region>.<your_domain>.`.

The rationale behind this module is that if you own a domain, there is no need to pay for an elastic IP
while it is not being used. The instances' default public IP can be dynamically associated with the DNS.

## Usage

```hcl
module "wireguard_dns_eu-west-1" {
  source = "./terraform-aws-wireguard-route53"
  
  hosted_zone_id         = "ADSA7268JLNN"
  domain_name            = "mydomain.com"
  name                   = "<should match the one in the wireguard module>"
  autoscaling_group_name = "<wireguard_asg_name>"
  public_ip              = null
}
```

Note that the `public_ip` variable should be set to null. A future release will make this work with
the associated Wireguard elastic IP.
