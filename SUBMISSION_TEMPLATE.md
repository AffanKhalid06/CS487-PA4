<div align="center">

# PA4 Submission: TaskFlow Pipeline

<img alt="GitHub only" src="https://img.shields.io/badge/Submit-GitHub%20URL%20Only-10b981?style=for-the-badge">
<img alt="Total points" src="https://img.shields.io/badge/Total-100%20points-7c3aed?style=for-the-badge">

</div>

<div style="background:#f5f3ff;color:#111827;border-left:6px solid #6330bc;padding:14px 18px;border-radius:10px;margin:18px 0;">
Copy this file to <code style="color:#111827;background:#ddd6fe;padding:2px 4px;border-radius:4px;">SUBMISSION.md</code>. Put every screenshot in <code style="color:#111827;background:#ddd6fe;padding:2px 4px;border-radius:4px;">docs/</code>, embed it under the correct task, and write a short description below each image explaining what it proves. The grader should not need any file outside this repository.
</div>

## Student Information

| Field | Value |
|---|---|
| Name | Affan Khalid |
| Roll Number | 27100104 |
| GitHub Repository URL | https://github.com/AffanKhalid06/CS487-PA4.git |
| Resource Group | `rg-sp26-|
| Assigned Region | `ukwest` |

## Evidence Rules

- Use relative image paths, for example: `![AKS nodes](docs/aks-nodes.png)`.
- Every image must have a 1-3 sentence description below it.
- Azure Portal screenshots must show the resource name and enough page context to identify the service.
- CLI screenshots must show the command and output.
- Mask secrets such as function keys, ACR passwords, and storage connection strings.


## Task 1: App Service Web App (15 points)

### Evidence 1.1: Forked Repository

Embed screenshot of your forked GitHub repository.
![Forked Repo](<./docs/1.1.png>)

Description: My working fork-ed repository from github which contains the starter code for PA4 components. Check the repo's URL and 'forked from' link under the repos name to verify that this is a forked repo.

### Evidence 1.2: App Service Overview

Embed screenshot of the Web App overview page showing `webapp-<rollnum>` and Running status.
![WebApp Overview](<./docs/1.2.png>)

Description: State the resource group, region, runtime, and public URL.

### Evidence 1.3: Deployment Center / GitHub Actions

Embed screenshot of Deployment Center or the successful GitHub Actions deployment.
![Deployment Center](<./docs/1.3.png>)

Description: Explain how the Web App is connected to your GitHub fork.

### Evidence 1.4: Live Web UI

Embed screenshot of the TaskFlow page loaded in a browser.
![](<./docs/1.4.png>)

Description: Explain that the App Service is serving the frontend successfully.

### Evidence 1.5: Application Srttings

Embed screenshot of the Application settings configured.
![](<./docs/1.5.png>)

---

## Task 2: Azure Container Registry (15 points)

### Evidence 2.1: ACR Overview

Embed screenshot of `crpa4<rollnum>` overview.
![ACR](<./docs/2.1.png>)

Description: Identify the registry SKU and resource group.

### Evidence 2.2: Docker Builds

Embed screenshot showing successful local builds for `validate-api`, `report-job`, and `func-app`.
![ReportJob/Validator build](<./docs/2.2.1.png>)
![ReportJob/Validator build](<./docs/2.2.2.png>)

Description: Explain which folder produced each image.

### Evidence 2.3: ACR Repositories

Embed screenshot of local test of validator (curl output showing valid/invalid responses).
![](<./docs/2.3.png>)

### Evidence 2.4: Successful Push to ACR

Embed screenshot of successfull pushes to ACR for all three images
![](<./docs/2.4.png>)

### Evidence 2.5: ACR Repositories

Embed screenshot or CLI output showing all three repositories in ACR.
![](<./docs/2.5.1.png>)
![](<./docs/2.5.2.png>)
![](<./docs/2.5.3.png>)

Description: Confirm `validate-api:v1`, `report-job:v1`, and `func-app:v1` were pushed.


---

## Task 3: Durable Function Implementation (12 points)

### Evidence 3.1: Completed Function Code

Link to your completed file: `[function_app.py](function-app/function_app.py)`.
![](<./docs/1..png>)

Description: Summarize how your orchestrator chains validation and report generation.

### Evidence 3.2: Local Function Handler Listing

Embed screenshot of `func start` showing the HTTP starter, orchestrator, and activities.
![](<./docs/1..png>)

Description: Explain that the Durable Functions runtime discovered your handlers.

---

## Task 4: Function App Container Deployment (8 points)

### Evidence 4.1: Function App Container Configuration

Embed screenshot showing the Function App uses your `func-app:v1` image from ACR.
![](<./docs/1..png>)

Description: State the Function App name and image URI.

### Evidence 4.2: Orchestration Smoke Test

Embed screenshot of the `curl` output that starts an orchestration and returns status URLs.
![](<./docs/1..png>)

Description: Explain what the returned `id` and `statusQueryGetUri` prove.

### Evidence 4.3: Expected Failed Status Before Downstream Wiring

Embed screenshot of the status query JSON showing the expected failure before `VALIDATE_URL` is configured.
![](<./docs/1..png>)

Description: Explain why this failure is expected at this stage.

---

## Task 5: AKS Validator (15 points)

### Evidence 5.1: AKS Cluster

Embed screenshot of AKS overview showing `aks-<rollnum>` succeeded.
![](<./docs/1..png>)

Description: State node count, node size, region, and resource group.

### Evidence 5.2: Kubernetes Nodes and Pods

Embed screenshot of `kubectl get nodes` and `kubectl get pods`.
![](<./docs/1..png>)

Description: Explain that the validator pod is scheduled and running.

### Evidence 5.3: Kubernetes Service

Embed screenshot of `kubectl get service validate-service`.
![](<./docs/1..png>)

Description: Identify the external IP and port exposed by the LoadBalancer.

### Evidence 5.4: Validator API Tests

Embed screenshot of `curl /health`, a valid `curl /validate`, and an invalid `curl /validate`.
![](<./docs/1..png>)

Description: Explain the accepted path and the `qty > 100` rejection rule.

### Evidence 5.5: Function App `VALIDATE_URL`

Embed screenshot showing the Function App application setting `VALIDATE_URL`.
![](<./docs/1..png>)

Description: Explain how the Durable Function reaches the AKS validator.

### Evidence 5.6: AKS Idle Behavior

Embed AKS metrics screenshot and/or `kubectl` output after the service is idle.
![](<./docs/1..png>)

Description: Explain that the AKS node remains running even when there are no orders.

---

## Task 6: ACI Report Job (15 points)

### Evidence 6.1: Blob Container

Embed screenshot of the `reports` blob container.
![](<./docs/1..png>)

Description: Explain where generated PDFs are stored.

### Evidence 6.2: Manual ACI Run

Embed screenshot of `az container show` for `ci-report-test`.
![](<./docs/1..png>)

Description: State the final container state and why the job exits.

### Evidence 6.3: ACI Logs

Embed screenshot of `az container logs`.
![](<./docs/1..png>)

Description: Explain what the report job printed after generating and uploading the PDF.

### Evidence 6.4: Generated PDF

Embed screenshot showing `TEST-001.pdf` in Blob Storage or opened from Blob Storage.
![](<./docs/1..png>)

Description: Explain how this proves the ACI wrote to storage.

### Evidence 6.5: Function App Managed Identity and IAM

Embed screenshots of system-assigned identity enabled and Contributor role assignment on your resource group.
![](<./docs/1..png>)

Description: Explain why the Function App needs this permission to create ACIs.

### Evidence 6.6: Report App Settings

Embed screenshot of `REPORT_*`, `ACR_*`, `STORAGE_CONN`, and `SUBSCRIPTION_ID` settings.
![](<./docs/1..png>)

Description: Explain what each group of settings is used for. Mask secrets.

---

## Task 7: End-to-End Pipeline (15 points)

### Evidence 7.1: Web App Wiring

Embed screenshot showing `FUNCTION_START_URL` and `FUNCTION_STATUS_URL` configured on the Web App.
![](<./docs/1..png>)

Description: Explain how the frontend starts and polls the Durable orchestration.

### Evidence 7.2: Happy Path UI

Embed screenshots of the form before submit, Running status, and Completed status with report URL.
![](<./docs/1..png>)

Description: Explain the valid order payload and final result.

### Evidence 7.3: Backend Participation

Embed screenshots showing Function App invocation, AKS validator evidence, ACI evidence, and Blob PDF evidence.
![](<./docs/1..png>)

Description: Trace the same order ID across services.

### Evidence 7.4: Reject Path UI

Embed screenshot of an order with `qty > 100` being rejected.
![](<./docs/1..png>)

Description: Explain why no report ACI should be created for this order.

---

## Task 8: Write-up and Architecture Diagram (5 points)

### Evidence 8.1: Architecture Diagram

Embed your architecture diagram from `docs/`.
![](<./docs/1..png>)

Description: Confirm that it shows GitHub, App Service, Durable Function, AKS, ACI, Blob Storage, ACR, and IAM.

### Question 8.2: Service Selection

In 3-4 sentences each, explain why TaskFlow uses App Service, Durable Functions, AKS, and ACI for their specific roles.

### Question 8.3: ACI vs AKS

Compare idle behavior, cost behavior, and operational model for AKS and ACI using your screenshots.

### Question 8.4: Durable Functions vs Plain HTTP

Explain at least two problems that Durable Functions solves for this sequential workflow.

### Question 8.5: Cost Review

Embed Cost Management screenshot scoped to your resource group.
![](<./docs/1..png>)

Description: Identify the most expensive resource and explain why.

### Question 8.6: Challenges Faced

Describe at least two real issues you hit and how you debugged them.

---
