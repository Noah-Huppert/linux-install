# Install Terraform
terraform_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.terraform.pkgs }}
