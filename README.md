# 🚀 Automate Domain Onboarding to F5 Distributed Cloud (XC) with Terraform

## 📘 Situation

Manual onboarding of domains, load balancers, WAF policies, and Bot Defense to F5 Distributed Cloud (XC) can be **time-consuming** and **prone to errors**. This project aims to **streamline the process using Terraform** for greater efficiency and accuracy.

---

## 🧱 Environment

- **Terraform**
- **F5 Distributed Cloud (XC) SaaS**
- **XC API**
- **GitHub**

---

## 🎯 Goal

Automate onboarding of:
- Single or multiple **load balancers**
- Single or multiple **domains**
- **WAF policies**
- **Bot Defense**
- Other **security configurations**

---

## ⚠️ Prerequisites

> A basic understanding of **F5 Distributed Cloud (XC)** and **Terraform** is recommended.

---

## ✅ Recommended Actions

### 1. **Install Terraform**

Ensure Terraform is installed. [Download Terraform](https://www.terraform.io/downloads.html).

---

### 2. **Obtain XC API Credentials**

To authenticate Terraform with XC:

- Log in to your **XC Console**.
- Navigate to: `Administration` → `Personal Management`.
- If no API certificate exists:
  - Generate one using the instructions under **"Generate API Certificate"** in the official docs.
- Download the API certificate from **Credentials** or **Service Credentials**.

---

### 3. **Download and Configure the Terraform Script**

- Clone or download this GitHub repository:
  
  ```bash
  git clone https://github.com/your-org/xc-domain-onboarding.git
  cd xc-domain-onboarding
Edit variables.tf or equivalent:

Add domain names

Specify load balancer names

Set WAF policy names

Configure any other relevant values

### 4. Run the Terraform Script

terraform init
terraform plan
terraform apply

This will trigger the onboarding process.

🔐 Security Note
Never commit your API certificate or private keys to the repository.

Use .gitignore to exclude sensitive files.

Consider using environment variables or secret managers for credentials.

📚 Additional Resources
F5 XC API Documentation

Terraform Documentation

F5 Distributed Cloud Documentation

✅ Outcome
By following these steps, you can efficiently automate and standardize the onboarding of domains into F5 Distributed Cloud using Terraform.
