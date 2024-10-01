# LAB DBeaver-Vault - Credential injection and database discovery

## Overview

In this lab, you will learn how to inject credentials from DBeaver-vault and how to automate the production of DBeaver configuration using consul-template.

## Run the lab

**Pre-requisites:** You'll need to have Docker and Docker Compose installed on your machine.
This docker compose stack will start the following services:
- PostgreSQL (10 individual databases)
- Vault dev-mode server (with a pre-configured secret engine and databases onboarded)
- A configuration file for DBeaver (you may need to copy the configuration file to your DBeaver installation directory)

```bash
docker compose up -d
```
