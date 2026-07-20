# Sterling Digital Solutions: Cloud Migration Project

## Project Overview
This project involves the architectural overhaul of Sterling Digital Solutions' legacy infrastructure. As the Lead Cloudification Officer, I am migrating the firm to a decoupled, resilient AWS environment.

## Architecture
- **Web Layer:** Decoupled static frontend (S3) and dynamic API backend (Node.js on EC2 Auto Scaling).
- **Data Layer:** Multi-AZ RDS (SQL Server) and DynamoDB (NoSQL).
- **Identity/Security:** AWS Simple AD and hardened Bastion Host.

## Documentation
- `/docs`: Service Management Strategy & Architecture Diagrams.
- `/evidence`: Step-by-step screenshots proving the build process.
- `/user-data`: Automation scripts for EC2 instances.

## Status
- [x] Phase 1: Network Foundation (VPC)
**Objective:** Establish a secure, isolated, and highly available network infrastructure for Sterling Digital Solutions.

**Results & Evidence:**
The foundational Virtual Private Cloud (VPC) has been successfully provisioned. The architecture utilizes a strict Multi-AZ deployment strategy to ensure high availability, fault tolerance, and network isolation for the backend databases.

**Creation Logs & Verification:**
The automated deployment successfully generated the VPC, enabled DNS resolution, and provisioned the required network gateways.

![VPC Creation Logs](Evidence/Networking_VPC_1%20.png)

**Architectural Resource Map:**
The visual mapping confirms the strict separation of public and private subnets across two Availability Zones (`us-east-1a` and `us-east-1b`).

![VPC Resource Map](Evidence/Networkin_VPC_2.png)

**Deployment Summary:**
*   **VPC Allocation:** Created isolated virtual network `vpc-001de067afb5c3923` with DNS hostnames and resolution enabled.
*   **Multi-AZ Subnetting:** Deployed 4 distinct subnets (2 public, 2 private) across the `us-east-1a` and `us-east-1b` availability zones.
*   **Internet Gateway (IGW):** Attached `igw-0e737a172b6226a33` to the public route table to allow external traffic to the presentation layer.
*   **NAT Gateway:** Allocated Elastic IP `eipalloc-0775653b2d5a91a71` and deployed NAT Gateway `nat-08f82f9082bdac62b` within the public subnet, allowing private database instances to securely download updates without public internet exposure.
*   **Routing:** Configured specific route tables (`Starling-Digital-rtb-public`, `Starling-Digital-rtb-private1-us-east-1a`, and `Starling-Digital-rtb-private2-us-east-1b`) to strictly control internal and external traffic flow.



- [x] Phase 2: Security Groups
**Objective:** Implement a defense-in-depth security strategy by configuring strict, stateful firewall rules to enforce least-privilege access across all architectural tiers.

**Results & Evidence:**
Four distinct security groups have been successfully provisioned within the VPC (`vpc-001de067afb5c3923`). These groups strictly control inbound and outbound traffic flow between the load balancer, bastion host, backend application servers, and the database cluster, ensuring critical internal resources remain completely shielded from public internet exposure.

**Security Group Allocations & Rules:**

![Security Groups Configuration](Evidence/security_project.png)

**Deployment Summary:**
*   **Starling-ALB-SG** (`sg-0e499c433b99d4e43`): Exposes only the Application Load Balancer to the public internet, acting as the secure entry point for external web traffic.
*   **Starling-Bastion-SG** (`sg-0ba875c8661f660a6`): Provides a highly restricted, secure administration point for SSH access into the private subnets.
*   **Starling-Backend-SG** (`sg-06d9e63e538b680df`): Keeps application servers strictly private. This group is configured to accept incoming traffic *only* from the Application Load Balancer and administrative commands via the Bastion Host.
*   **Starling-DB-SG** (`sg-0a5c2c8493112b122`): Keeps the database completely isolated. It allows inbound database connections *only* from the verified backend application servers.

  
- [x]  Phase 3: Identity & Bastion
      
**Objective:** Establish secure identity management for internal resources and create a hardened administrative entry point into the private network.

**Results & Evidence:**
A managed AWS Simple AD directory was successfully provisioned to handle identity and access management. Additionally, a secure Bastion Host (jump box) was deployed within the public subnet, providing administrators a secure, monitored bottleneck for SSH access into the private application and database layers.

**Identity & Access Configuration:**

![Identity and Bastion Configuration](Evidence/AWS_Simple_AD.png)
![Identity and Bastion Configuration](Evidence/Bastion_Host.png)

**Deployment Summary:**
*   **Directory Service (Simple AD):** Deployed a standalone managed directory (`d-90667477da`) configured with the DNS name `Starling.Digital` and NetBIOS name `Starling`.
*   **Bastion Host Provisioning:** Launched an EC2 instance (`i-0276177c00467ad82`) named `Starling-Bastion` utilizing a `t2.micro` instance type.
*   **Network Placement:** The bastion is strategically placed in the public subnet (`subnet-04f8345bee0ead881` in `us-east-1a`) to allow secure external ingress.
*   **Access Routing:** The bastion is reachable externally via Public IPv4 `98.94.40.94` and interfaces with the private network via Private IPv4 `10.0.8.244`.
- [ ] Phase 4: Storage & Databases
- [ ] Phase 5: Frontend Deployment
- [ ] Phase 6: Backend Deployment
