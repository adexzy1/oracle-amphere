# Oracle Ampere Hunter

This project automatically and continuously hunts for the Oracle Cloud "Always Free" Ampere A1 Compute Instance. Because Oracle frequently runs out of resource capacity for the free tier, it can be extremely frustrating to click "Create" only to get an "Out of capacity" error.

This repository solves that by using GitHub Actions and Terraform to poll for availability every 5 minutes.

## How it Works (Stateless Hunter Design)

This project has been uniquely architected to be **100% serverless and stateless**:

- **No Remote State Needed**: You do not have to create an OCI Object Storage bucket or set up Terraform Cloud just to store the `.tfstate` file.
- **Smart Data Check**: Before attempting to provision the instance, Terraform queries OCI to check if an instance named `ampere-free-hunter` already exists in your compartment.
- **Auto-Bypass**: If the instance exists, it skips the creation phase. If it doesn't, it attempts to provision it.

## Instructions

1. **Fork this repository.**
2. **Go to your fork's Settings -> Secrets and variables -> Actions**
3. Create the following **Repository Secrets**:

### Oracle Account Authentication Secrets

You need to create an API Key in your Oracle Cloud account (Profile -> API Keys -> Add API Key). This will generate the following:

- `OCI_TENANCY`: The OCID of your Tenancy.
- `OCI_USER`: The OCID of your User account.
- `OCI_FINGERPRINT`: The Fingerprint of the API Key you generated.
- `OCI_PRIVATE_KEY`: The **raw contents** of the Private Key `.pem` file generated with your API key.
- `OCI_REGION`: Your Oracle Home Region (e.g., `us-ashburn-1` or `uk-london-1`).

### Terraform Infrastructure Secrets

You need to provide the OCIDs for where the instance will be placed.

- `TF_VAR_COMPARTMENT_OCID`: The OCID of the compartment to build in.
- `TF_VAR_AVAILABILITY_DOMAIN`: The exact string name of your Availability Domain (e.g., `XbZQ:US-ASHBURN-AD-1`).
- `TF_VAR_SUBNET_ID`: The OCID of the Subnet within your Virtual Cloud Network (VCN). _You must manually create a VCN and Subnet first in the OCI Console._
- `TF_VAR_IMAGE_ID`: The OCID of the OS Image you want (e.g., Ubuntu 22.04 Aarch64). You can find OS Image OCIDs in the OCI documentation for your specific region.
- `TF_VAR_SSH_PUBLIC_KEY`: Your SSH Public Key string (e.g., `ssh-rsa AAAA...`) so you can access the machine once it is created.

---

### Start the Hunt

Once all your secrets are configured, go to the **Actions** tab in GitHub.

- Enable Workflows if prompted.
- You can manually trigger the workflow by clicking **"Run workflow"** under the "Oracle Ampere Hunter" action, or simply wait for it to run on schedule (every 5 minutes).

It will run continuously until it secures your instance!
