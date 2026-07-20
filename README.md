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
- [ ] Phase 1: Network Foundation (VPC)
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


- [ ] Phase 2: Security Groups
- [ ] Phase 3: Identity & Bastion
- [ ] Phase 4: Storage & Databases
- [ ] Phase 5: Frontend Deployment
- [ ] Phase 6: Backend Deployment
