A minimal EC2 server would need the following:  
   * AutoScale 1:1 - so that if it crashs, it should be able to spawn a new instance again.
   * EIP - so that its IP address doesnt change if the instance is terminated.  If your organization is very strict on allowing servers on AWS back into the organization data center.  
   * EBS -  Most server will need a persistent storage so that there is no data lost if the instance crashed
   
Here are the steps:
1.  push the ec2-scripts files to your gitlab or github as ec2-scripts project.
2.  Update the vars.env with appropriate values based on your AWS information.
3.    run gen-vars.sh to generate the main.tf, ebs,tf, eip.tf and userdata.sh
4.  Run terraform apply.  This will create an EC2 instance with AutoScale, EIP, EBS persistent storage.

Note: the script can also handle nvme devices on Instance Type such as C5, M5, etc.
At the end you will have an EC2 instance with awscli, vault, gomplate, terraform,
python, nodejs tools.
