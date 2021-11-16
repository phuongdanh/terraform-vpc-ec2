# Welcome to the board
This project is purpose to understand more about the Terraform
## Structure
I used aws provider to create 3 modules
  - vpc
  - ec2
  - ssh_key
## Setup and run

  > Create aws profile in ~/.aws/credentials

  **Run command line**
  ```
  terraform init
  terraform plan -v "profile=YOUR_PROFILE_NAME"
  terraform apply -v "profile=YOUR_PROFILE_NAME"
  ```
