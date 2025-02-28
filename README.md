# **Terraform AWS ALB (Application Load Balancer) with Auto-Scaling EC2** 🚀

## **Overview**
This Terraform project provisions an **AWS Application Load Balancer (ALB)** that distributes traffic across multiple **auto-scaled EC2 instances** deployed in public subnets. The infrastructure is fully automated and uses **`for_each`** for dynamic subnet and instance creation.

### **How It Works**
- A **VPC** is created with **public subnets** across **multiple Availability Zones**.
- An **Internet Gateway** is attached to the VPC for external access.
- A **Route Table** ensures public subnets can communicate with the Internet.
- An **Application Load Balancer (ALB)** directs incoming traffic to the EC2 instances.
- EC2 instances are dynamically created using **`for_each`** and are registered with a **Target Group**.
- The **User Data script (`userdata.sh`)** installs a web server and serves a basic webpage.

## **AWS Application Load Balancer (ALB)**
The **Application Load Balancer (ALB)** is an AWS service that automatically distributes incoming application traffic across multiple **targets** (EC2 instances). ALB improves fault tolerance, security, and availability by:
✅ **Distributing load across multiple instances**
✅ **Automatically handling failed/unhealthy instances**
✅ **Supporting HTTP/HTTPS protocols**

## **Project Structure**
```
terraform-aws-alb/
│── provider.tf        # AWS provider configuration
│── variables.tf       # Input variables for flexibility
│── vpc.tf             # VPC creation
│── subnets.tf         # Dynamic subnet creation with for_each
│── network.tf         # Internet Gateway & Routing
│── security.tf        # Security Groups for ALB and EC2
│── alb.tf             # Application Load Balancer configuration
│── target_group.tf    # Target Group for ALB
│── listener.tf        # ALB Listener configuration
│── ec2.tf             # Auto-scaling EC2 instances with for_each
│── output.tf          # Output values for easy access
│── userdata.sh        # User Data script for automatic web server setup
│── README.md          # Project documentation
```

## **Using `for_each` in Terraform**
Instead of manually defining multiple resources, **`for_each`** allows Terraform to **loop over a list of values** and dynamically create multiple resources.

### **Example: Dynamic Subnet Creation**
```hcl
resource "aws_subnet" "public_subnets" {
  for_each                = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zones[each.key]
  map_public_ip_on_launch = true
  tags = { Name = "PublicSubnet-${each.key + 1}" }
}
```
✅ **Why `for_each`?**
- **Scalable:** Easily add/remove subnets without changing Terraform code.
- **Efficient:** No need to manually define multiple `aws_subnet` resources.
- **Flexible:** Works well for multi-region deployments.

## **User Data Script (`userdata.sh`)**
The `userdata.sh` file is used to **automate EC2 setup** during launch.
```sh
#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Welcome to My Application - $(hostname)</h1>" | sudo tee /var/www/html/index.html
```
✅ **What It Does:**
- Installs **Apache Web Server** on EC2.
- Starts and enables Apache to run on boot.
- Creates a simple **index.html** file displaying the instance name.

## **Terraform Setup & Deployment**
Run the following commands to deploy the infrastructure:

1️⃣ **Initialize Terraform**
```sh
terraform init
```

2️⃣ **Preview the Changes**
```sh
terraform plan
```

3️⃣ **Apply the Configuration**
```sh
terraform apply -auto-approve
```

4️⃣ **View Outputs (ALB DNS Name, EC2 IPs, etc.)**
```sh
terraform output
```

5️⃣ **Destroy the Infrastructure (if needed)**
```sh
terraform destroy -auto-approve
```

## **Testing the ALB**
1️⃣ Run:
```sh
terraform output alb_dns_name
```
2️⃣ Open the **ALB URL** in your browser:
```sh
http://your-alb-dns-name
```
🚀 You should see a **web page served by one of the EC2 instances**.

## **Security Considerations**
⚠ **Restrict SSH Access** → Change `"0.0.0.0/0"` to your IP in `security.tf` for better security.
⚠ **Ensure Private Key Security** → Do not expose the key pair in logs or public repositories.
⚠ **Use HTTPS Instead of HTTP** → Improve security by adding an SSL certificate.

## **Next Steps**
- **Enhance security** by using private subnets and a Bastion Host.
- **Auto-scale EC2 instances** based on CPU usage.
- **Deploy a real application (e.g., Flask, Node.js) instead of a static page.**

---
### **Contributing**
Feel free to fork this repo and enhance the project! 😊