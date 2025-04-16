

1. `main.tf`
2. `variable.tf`
3. `terraform.tfvars`
4. `output.tf`
  
---

## ✅ **Project Title:** Terraform Backend Setup with S3 and DynamoDB

### 🧾 **Project Overview**
This Terraform configuration sets up a remote backend using **AWS S3** for storing the Terraform state file securely, and **DynamoDB** for managing state file locking and consistency during deployments. This is a **best-practice infrastructure setup** for any team working with Terraform in AWS.

---

## 📁 **File Breakdown**

### `main.tf`
Creates the necessary AWS resources:
- **S3 Bucket**: Stores Terraform state securely.
  - Versioning enabled to keep track of state changes.
  - Server-side encryption enabled (`AES256`).
  - Deletion is protected via `prevent_destroy`.

- **DynamoDB Table**: Used for **Terraform state locking** to avoid concurrent modifications.
  - Uses `LockID` as the partition key.
  - On-demand billing (`PAY_PER_REQUEST`).

---

### `variable.tf`
Defines four input variables required by the configuration:
- `aws_region` – AWS region to deploy resources.
- `s3_bucket_name` – Unique name for the Terraform state bucket.
- `dynamodb_table_name` – Name of the DynamoDB lock table.
- `environment` – To tag resources by environment (`dev`, `staging`, etc.).

---

### `terraform.tfvars`
Provides actual values to the variables:
```hcl
aws_region          = "ap-south-1"
s3_bucket_name      = "terraform-state-bucket-kapilanramesh-20250408"
dynamodb_table_name = "terraform-locks"
environment         = "dev"
```

---

### `output.tf`
Outputs:
- The name of the S3 bucket created.
- The name of the DynamoDB table created.

This helps confirm the resources after running `terraform apply`.

---

## ⚙️ **How to Use**

### 1. **Initialize Terraform**
```bash
terraform init
```

### 2. **Preview the Changes**
```bash
terraform plan
```

### 3. **Apply the Configuration**
```bash
terraform apply
```

### 4. **View Outputs**
After apply, you’ll see:
- `s3_bucket_name`
- `dynamodb_table_name`

These confirm the backend infra is provisioned correctly.

---

## 🛡️ **Security & Best Practices**
- **Versioning Enabled** on the S3 bucket to recover older states.
- **Server-Side Encryption (AES256)** ensures the state file is encrypted at rest.
- **Locking with DynamoDB** prevents race conditions during `apply` by multiple users.
- **`prevent_destroy` Lifecycle Rule** protects accidental S3 bucket deletion.

---

## 📌 **Use Case**
This setup is typically used **before any Terraform project** so that your actual infrastructure code can safely use:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-kapilanramesh-20250408"
    key            = "project-name/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```
