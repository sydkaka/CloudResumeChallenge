# Yongding Sun - Cloud Web App Challenge

# About
This is a web app about me that is being hosted on Azure's storage account. It tracks the visitor count via Azure function as the API and Azure Cosmos DB as the database.

![architecture] (assets/image/architecture.png)

## Demo

[View it live here](https://ydsunstorageaccount.z5.web.core.windows.net/frontend/index.html)

## Structure

- `.github/workflows/`: Folder contains CI/CD workflow configurations.
- `frontend/`: Folder contains Html, CSS, JavaScript code for the website
- `Infrastructure/`: Folder contains Terraform code (Infrastructure as code) to deploy my cloud resources.
- `backend/`: Folder contains Azure function(API) source code
- `resume/`:  Folder contains my resume in PDF format

## Azure Services Used
- Azure Storage Account
- Azure Storage Account container 
- Azure Storage Account blob
- Azure Cosmos DB Table API
- Azure Function App Isolated Function
- Azure EntraId

## Tools used
- Terraform
- Gihub Action
- Vs Code

## Blog
- https://naveend3v.medium.com/my-cloud-resume-challenge-project-6f726ed58d60