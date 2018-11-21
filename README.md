# sentry-ecs-fargate-assessment-2


# Pre-Requests: 
A. Access Key and Secret Key. ( with required permissions)
B. Terraform should be installed. 
 
 # Deployment 
1. Clone the repository. 
2. Move to the sentry-ecs-fargate-assessment-2 directory. 
3. initalize the terraform to download modules.                                                                                 # terraform init
4. Modifiy the variables as per your naming and values in variables.tf file.
5. To build the stack run below terraform command.
  #terraform workspace new assessment2
  #terraform workspace select assessment2
6.  Now you can provision the resourecs using terraform.
    #terraform plan
    #terraform apply
    
   The above commands creates the stack and deployment it bring the site up. 
   
  7 . To destroy the stack which we created use below command.
    #terraform destroy
