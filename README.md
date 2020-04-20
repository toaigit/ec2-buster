Create an EC2 instance with the following characteristics:   
   you want to create an ec2 with additional filesystems
   autoscale 1.1 and EIP   
   create ebs filesystem   
   
Here are the steps:
1.  push the ec2-scripts files to your gitlab or github as ec2-scripts project.
    (if you want to use different name, you also need to update vars.env)
2.  Update the vars.env with appropriate values based on your AWS information.
3.    run gen-vars.sh to generate the main.tf, ebs,tf, eip.tf and userdata.sh
4.  Run terraform apply

Note: the script can also handle nvme devices.
At the end you will have an EC2 instance with awscli, vault, gomplate, terraform,
python, nodejs tools.

