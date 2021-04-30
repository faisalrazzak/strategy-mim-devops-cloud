![Pipeline](https://github.com/faisalrazzak/strategy-mim-devops-cloud/actions/workflows/GeneratePDF.yml/badge.svg)

# Strategy to manage machine identities in DevOps & Cloud environments

This paper introduces a 3-tiered strategy for enterprises to manage machine identities as part of their digital transformation initiatives. The foundational principle is that security must be a shared concern between InfoSec, Platform, and Development/Deployment teams.
This unifying implementation strategy is needed to address requirements of all stakeholders. InfoSec teams should implement an identity service pro-actively enforcing security policies in an automated
manner. Platform teams should utilize platform native plugins or tools to integrate with the identity service provided by InfoSec teams and establish a downstream identity service that manages identities within the boundary of their managed platforms. In the end, Development/Deployment teams should use their existing workflows to request identities ensuring consistent security across the teams.

## Table of Contents  
1. [Background](Background.md)
2. [Security - A Shared Concern](Security-SharedConcern.md)
3. [Proposed Strategy](Strategy-MIM.md)
4. [Implementations](Implementations.md)
   1. [Security Strategy for Microsoft Azure KeyVault](azure-key-vault-strategy-mim.md)
   2. [Security Strategy for AWS ACM](acm-strategy-mim.md)
   3. [Security Strategy for HashiCorp Vault](hashicorp-vault-strategy-mim.md)
   4. [Security Strategy for Kubernetes](k8s-strategy-mim.md)
   5. [Security Strategy for IaC (Terraform/Ansible)](iac-strategy-mim.md)
5. [Summary](Summary.md)

