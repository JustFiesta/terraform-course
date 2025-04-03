# Terraform Learning Repository

This repository documents my journey of learning and practicing Terraform. It includes various exercises, examples, and modules to understand Infrastructure as Code (IaC) concepts and Terraform's capabilities.

---

## Project Structure

The repository is divided into multiple projects and modules, each focusing on specific Terraform concepts:

### 1. **`tf-module-final-project`**

- **Goal**: Create a scalable infrastructure with Terraform modules.
- **Features**:

  - **Compute Module**:

    - Creates a golden AMI with Apache pre-installed using `aws_ami_from_instance`.
    - Configures an Auto Scaling Group (ASG) with 3 instances using `aws_autoscaling_group`.
    - Uses `local-exec` provisioner to terminate temporary instances after AMI creation.

  - **Network Module**:

    - Sets up a VPC with public and private subnets.
    - Configures an Application Load Balancer (ALB) with health checks.
    - Implements security groups to restrict access to specific IP ranges and ports.

  - **Key Concepts**:

    - Terraform modules for resource segregation.
    - Dynamic tagging using `merge` function.
    - High availability with ASG and ALB.

### 2. **`tf-utils-lab`**

- **Goal**: Experiment with Terraform utilities and validation tools.
- **Features**:
  - Pre-commit hooks for linting and validation (`tflint`, `tfsec`, `terraform-docs`).
  - Validation blocks in variables to enforce input constraints.
  - Example EC2 instance with encrypted root volume and metadata options.
- **Key Concepts**:
  - Using `pre-commit` for code quality.
  - Validation blocks for input constraints.
  - Provisioners like `local-exec` for custom commands.

---

## Key Terraform Concepts Used

### 1. **Modules**

- Resources are segregated into modules (`compute`, `network`, etc.) for better organization and reusability.

### 2. **Provisioners**

- **`local-exec`**: Used to execute shell commands, e.g., terminating temporary EC2 instances after creating a golden AMI.
- **Example**:

    ```terraform
    resource "null_resource" "delete_tmp_instance" {
        provisioner "local-exec" {
            command = "aws ec2 terminate-instances --instance-ids ${aws_instance.tmp_golden_instance.id}"
        }
    }
    ```

### 3. **Dynamic Tagging**

- Tags are dynamically generated using the `merge` function to combine static and variable-based values.

- **Example**:

    ```terraform
    tags = merge(
        var.instance_tags,
        {
            Name = "${var.project_name}-${var.environment}-instance"
        }
    )
     ```

### 4. **Validation Blocks**

- Enforce constraints on variable inputs to ensure correctness.

- **Example**:

    ```terraform
    variable "ami" {
        validation {
            condition     = can(regex("^ami-[a-zA-Z0-9]+$", var.ami))
            error_message = "AMI ID must follow the format 'ami-xxxxxx'."
        }
    }
    ```

### 5. **Auto Scaling and Load Balancing**

- Configured an Auto Scaling Group (ASG) with a Launch Template.
- Integrated an Application Load Balancer (ALB) with health checks for high availability.

---

## Tools and Utilities

### 1. **Pre-commit Hooks**

- Tools used:

- `tflint`: Linting for Terraform code.
- `tfsec`: Security scanning for Terraform configurations.
- `terraform-docs`: Automatically generate module documentation.

- **Setup**:

    ```bash
    pre-commit install --install-hooks
    pre-commit run --all-files
    ```

### 2. **Validation Tools**

- `checkov`, `terrascan`, and `tfsec` were used to validate security and compliance.

### 3. **Golden AMI Creation**

- Used `aws_ami_from_instance` to create a reusable AMI with pre-installed software.

---

## How to Use

1. **Setup**:

   - Install Terraform: [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
   - Configure AWS CLI with credentials.

2. **Run Terraform**:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
