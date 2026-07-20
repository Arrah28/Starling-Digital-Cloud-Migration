# Sterling Digital Solutions: Service Management Strategy & Architecture

## 1. Executive Summary
This document outlines the strategic and architectural blueprint for the cloud migration of Sterling Digital Solutions. The primary objective is to transition from legacy, monolithic hardware to a highly available, fault-tolerant, and secure multi-tier AWS infrastructure adhering to the AWS Well-Architected Framework.

## 2. Network Design & High Availability (Phase 1)
- **VPC Isolation:** A dedicated Virtual Private Cloud (`vpc-001de067afb5c3923`) was constructed with DNS resolution and hostnames enabled.
- **Multi-AZ Subnetting:** Workloads are distributed across two Availability Zones (`us-east-1a` and `us-east-1b`) to eliminate single points of failure.
- **Traffic Segregation:** Public subnets house ingress resources (Internet Gateway, Application Load Balancer, Bastion), while private subnets isolate backend application nodes and databases from direct public exposure. Outbound internet access for private resources is channeled securely via a managed NAT Gateway.

## 3. Defense-in-Depth Security Strategy (Phase 2 & 3)
- **Stateful Security Groups:** Least-privilege firewall boundaries are strictly enforced. The frontend ALB accepts public traffic, passing it exclusively to the backend security group (`Starling-Backend-SG`), which in turn permits database communication only to `Starling-DB-SG`.
- **Identity & Access Management:** AWS Simple AD (`Starling.Digital`) handles centralized directory services, while an isolated Bastion Host in the public tier regulates secure, logged administrative entry.

## 4. Scalable Data and Storage Tiers (Phase 4)
- **Relational & NoSQL Datastores:** Designed for high availability with an RDS multi-AZ subnet group alongside a DynamoDB table (`Starling-Market-Data`) optimized for high-speed session tracking.
- **Persistent & Object Storage:** Amazon EFS provides shared file storage across compute instances, while version-controlled Amazon S3 buckets ensure regulatory data durability and safe web asset delivery.

## 5. Resilient Compute & Automation (Phase 5 & 6)
- **Auto Scaling Architecture:** Backend API compute nodes execute behind an Application Load Balancer via an Auto Scaling Group (scaling limits: 2–4 instances) to dynamically adjust to traffic loads.
- **Automated Bootstrapping:** EC2 instances use customized User Data scripts to self-configure DNS, bind to the Active Directory domain, mount EFS storage asynchronously, and enforce strict Linux RBAC permissions on local audit logs.
