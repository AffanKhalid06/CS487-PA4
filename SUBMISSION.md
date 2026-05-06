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
| Resource Group | `rg-sp26-27100104` |
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

Embed screenshot of the Web App overview page showing `pa4-27100104` and Running status.
![WebApp Overview](<./docs/1.2.png>)

Description: The App Service web app `pa4-27100104` is deployed in the `rg-sp26-27100104` resource group in the `ukwest` region. It runs a Node.js 20 LTS runtime on a Linux B1 plan and is publicly accessible at `https://pa4-27100104.azurewebsites.net`. The status shows Running confirming the service is healthy.

### Evidence 1.3: Deployment Center / GitHub Actions

Embed screenshot of Deployment Center or the successful GitHub Actions deployment.
![Deployment Center](<./docs/1.3.png>)

Description: The Deployment Center is connected to my GitHub fork `AffanKhalid06/CS487-PA4` on the `main` branch. Every push to main automaticaly triggers a GitHub Actions workflow that builds and deploys the Node.js frontend to the App Service, implementing continous deployment.

### Evidence 1.4: Live Web UI

Embed screenshot of the TaskFlow page loaded in a browser.
![](<./docs/1.4.png>)

Description: The TaskFlow order form is successfully being served by the App Service over HTTPS. The dark themed UI with Order ID, SKU, and Quantity fields is visible, confirming that the App Service is correctly hosting and serving the Node.js frontend.

### Evidence 1.5: Application Settings

Embed screenshot of the Application settings configured.
![](<./docs/1.5.png>)

Description: The Application Settings on the Web App include `FUNCTION_START_URL` and `FUNCTION_STATUS_URL` which point to the deployed Durable Function App. These environment variables decouple the frontend from the backend — changing the Function App URL requires only an App Settings update, not a code change or redeployment.

---

## Task 2: Azure Container Registry (15 points)

### Evidence 2.1: ACR Overview

Embed screenshot of `pa427100104` overview.
![ACR](<./docs/2.1.png>)

Description: The Azure Container Registry `pa427100104` is provisioned with the Basic SKU in the `rg-sp26-27100104` resource group in `ukwest`. Admin user is enabled which allows local docker login and allows Kubernetes pull secrets and ACI credential passing to work correctly.

### Evidence 2.2: Docker Builds

Embed screenshot showing successful local builds for `validate-api`, `report-job`, and `func-app`.
![ReportJob/Validator build](<./docs/2.2.1.png>)
![ReportJob/Validator build](<./docs/2.2.2.png>)

Description: All three images were built locally using `docker build --platform linux/amd64` to ensure amd64 compatability since the Mac used for development has an Apple Silicon (ARM) chip. The `validate-api` image was built from `./validate-api`, `report-job` from `./report-job`, and `func-app` from `./function-app`.

### Evidence 2.3: ACR Repositories

Embed screenshot of local test of validator (curl output showing valid/invalid responses).
![](<./docs/2.3.png>)

Description: The validate-api container was run locally with `docker run -p 8080:8080 validate-api:latest` and tested using curl. A valid order with `qty=2` returned `{"valid": true, "reason": "ok"}` and an invalid order with `qty=999` returned `{"valid": false, "reason": "quantity exceeds limit"}`, confirming the business logic is correct before pushing to ACR.

### Evidence 2.4: Successful Push to ACR

Embed screenshot of successfull pushes to ACR for all three images
![](<./docs/2.4.png>)

Description: All three images were tagged with the full ACR path (`pa427100104.azurecr.io/<image>:v1`) and pushed using `docker push`. The terminal output shows each layer being pushed and the final digest confirming all three images are now stored in the private registry.

### Evidence 2.5: ACR Repositories

Embed screenshot or CLI output showing all three repositories in ACR.
![](<./docs/2.5.1.png>)
![](<./docs/2.5.2.png>)
![](<./docs/2.5.3.png>)

Description: The ACR portal shows three repositories — `validate-api`, `report-job`, and `func-app` — each with tag `v1`. These images are the source of truth pulled by AKS (for validate-api), ACI (for report-job), and the Function App (for func-app) at runtime.

---

## Task 3: Durable Function Implementation (12 points)

### Evidence 3.1: Completed Function Code

Link to your completed file: [Link](https://github.com/AffanKhalid06/CS487-PA4/blob/main/function-app/function_app.py)
![](<./docs/3.1.png>)

Description: The `function_app.py` implements the full Durable Functions pattern. The `http_starter` receives the POST request and starts a new orchestration. The `my_orchestrator` calls `validate_activity` first — if the order is invalid it returns `{status: rejected}` immediately without calling the report step. If valid, it calls `report_activity` which spawns an ACI container to generate the PDF and returns the blob URL. The final output is `{status: completed, report_url: ...}`.

### Evidence 3.2: Local Function Handler Listing

Embed screenshot of `func start` showing the HTTP starter, orchestrator, and activities.
![](<./docs/3.2.png>)

Description: Azurite running in one terminal window provides the local storage emulator required by the Durable Functions runtime. In the second terminal, `func start` (with the `.venv` activated) shows all four function handlers registered: `http_starter`, `my_orchestrator`, `report_activity`, and `validate_activity`, confirming the function app initializes correctly.

---

## Task 4: Function App Container Deployment (8 points)

### Evidence 4.1: Function App Container Configuration

Embed screenshot showing the Function App uses your `func-app:v1` image from ACR.
![Function App using func-app:v1 container](<./docs/4.1.png>)

Description: The Function App `pa4-27100104-fn` is configured with `DOCKER|pa427100104.azurecr.io/func-app:v1` as its Linux FX Version, confirming it pulls and runs the containerized Azure Functions image from our private ACR rather than using a code-based deployment.

### Evidence 4.2: All four Functions deployed

Embed Screenshot of the Functions list in the Portal showing http_starter, my_orchestrator, validate_activity, report_activity
![4 functions](<./docs/4.2.png>)

Description: All four functions in our `function_app.py` are listed here — `http_starter` (HTTP trigger), `my_orchestrator` (orchestration trigger), `validate_activity` (activity trigger), and `report_activity` (activity trigger). This confirms the container started successfully and the Functions host indexed all function definitions.

### Evidence 4.3: Orchestration Smoke Test

Embed screenshot of the `curl` output that starts an orchestration and returns status URLs.
![SmokeTest](<./docs/4.3.png>)

Description: A `curl` POST to the `http_starter` endpoint returns HTTP 202 with an `id` (instance ID) and a `statusQueryGetUri`. This proves the orchestration has started and the Durable Task Framework has accepted the work item. The status URL can be polled to track progress.

### Evidence 4.4: Expected Failed Status Before Downstream Wiring

Embed screenshot of the status query JSON showing the expected failure before `VALIDATE_URL` is configured.
![Failed Status](<./docs/4.4.png>)

Description: The orchestrator tries to call validate activity, which reads VALIDATE URL from environment variables. Since VALIDATE URL is not set yet, it throws a KeyError exception, causing the activity to fail, which causes the orchestration to fail. This failure proves my deployment works. The orchestrator started, checkpointed, called the activity, and the activity ran (enough to attempt reading the environment variable). Once I set VALIDATE URL in Task 5 and the function app settings in Task 6, the full pipeline will work.

---

## Task 5: AKS Validator (15 points)

### Evidence 5.1: AKS Cluster

Embed screenshot of AKS overview showing `pa4-27100104` running.
![aks-27100104](<./docs/5.1.png>)

Description: The AKS cluster `pa4-27100104` is running in the `rg-sp26-27100104` resource group in `ukwest` region. It has one node of size `Standard_B2s`. The cluster status shows Running and the Kubernetes version is stable, confirming the cluster is healthy and ready to serve workloads.

### Evidence 5.2: Kubernetes Nodes and Pods

Embed screenshot of `kubectl get nodes` and `kubectl get pods`.
![get node/pod](<./docs/5.2.png>)

Description: `kubectl get nodes` shows one node in `Ready` status. `kubectl get pods` shows the `validate-deployment` pod in `Running` state with all containers ready (1/1). This confirms the validator microservice is scheduled and actively running on the cluster.

### Evidence 5.3: Kubernetes Service

Embed screenshot of `kubectl get service validate-service`.
![get Service](<./docs/5.3.png>)

Description: The `validate-service` of type `LoadBalancer` has an external IP of `51.140.216.48` on port `8080`. This stable external IP is what gets configured as the `VALIDATE_URL` in the Function App settings, allowing the Durable Function to reach the AKS validator over the public internet.

### Evidence 5.4: Validator API Tests

Embed screenshot of `curl /health`, a valid `curl /validate`, and an invalid `curl /validate`.
![](<./docs/5.4.png>)

Description: Three curl commands confirm the validator works correctly. `/health` returns `{"status":"ok"}`. A valid order with `qty=2` returns `{"valid":true,"reason":"ok"}`. An invalid order with `qty=999` returns `{"valid":false,"reason":"quantity exceeds limit"}` — proving the rejection rule (`qty > 100`) is enforced correctly by the FastAPI app running inside the AKS pod.

### Evidence 5.5: Function App `VALIDATE_URL`

Embed screenshot showing the Function App application setting `VALIDATE_URL`.
![](<./docs/5.5.png>)

Description: The Function App setting `VALIDATE_URL` is set to `http://51.140.216.48:8080/validate` which is the AKS LoadBalancer external IP and port. The `validate_activity` reads this environment variable at runtime and makes a POST request to it with the order payload, connecting the Durable Function orchestrator to the AKS validator microservice.

### Evidence 5.6: AKS Idle Behavior

Embed AKS metrics screenshot and/or `kubectl` output after the service is idle.
![pod](<./docs/5.6.png>)

Description: Even when no orders are being submitted, the AKS node remains in `Ready` state and the validator pod stays `Running`. This is the key architectural tradeoff — AKS bills continuously for the node even at idle, but provides instant response times with no cold start. This makes it the correct choice for the validator which is called on every single order.

---

## Task 6: ACI Report Job (15 points)

### Evidence 6.1: Blob Container

Embed screenshot of the `reports` blob container.
![](<./docs/6.1.png>)

Description: The `reports` blob container was created inside the `pa427100104` storage account. This is where the `report-job` ACI container uploads the generated PDF files after each successfull order. The container uses the default Hot access tier since PDFs are accessed immediately after creation.

### Evidence 6.2: Manual ACI Run

Embed screenshot of `az container show` for `ci-report-test`.
![](<./docs/6.2.png>)

Description: The manual ACI run created a container group named `ci-report-test` which progressed from `Running` to `Succeeded` state. The `--restart-policy Never` flag ensured the container ran exactly once and stopped — this is the correct lifecycle for a batch job that writes a file and exits.

### Evidence 6.3: ACI Logs

Embed screenshot of `az container logs`.
![](<./docs/6.3.png>)

Description: The `az container logs` output for `ci-report-test` shows the report-job's stdout, including the message confirming the PDF was generated and uploaded to the `reports` blob container. This proves the container successfully authenticated to blob storage using the Managed Identity and wrote the file.

### Evidence 6.4: Generated PDF

Embed screenshot showing `TEST-001.pdf` in Blob Storage or opened from Blob Storage.
![](<./docs/6.4.png>)

Description: The `TEST-001.pdf` file appears in the `reports` blob container in the Azure Portal, confirming the ACI report job successfully wrote the PDF to blob storage. The file size and content type (`application/pdf`) are visible, proving the upload completed without errors.

### Evidence 6.5: Function App Managed Identity and IAM

Embed screenshots of user-assigned identity enabled and role assignment on your resource group.
![](<./docs/6.5.png>)

Description: The user-assigned managed identity `mi-pa4-27100104` has been attached to the Function App `pa4-27100104-fn`. This identity has `Contributor` role on the resource group, which allows the Function App's `report_activity` to call the Azure Container Instance management API and create/delete ACI container groups without storing any passwords or service principal credentials in code.

### Evidence 6.6: Report App Settings

Embed screenshot of `REPORT_*`, `ACR_*`, `STORAGE_CONN`, and `SUBSCRIPTION_ID` settings.
![APP Settings](<./docs/6.6.png>)

Description: The Function App is configured with four groups of settings. `REPORT_IMAGE`, `REPORT_RG`, `REPORT_LOCATION` tell the orchestrator where and how to create the ACI container. `ACR_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD` provide registry credentials so ACI can pull the `report-job` image. `STORAGE_ACCOUNT_URL` tells the report job where to upload the PDF. `SUBSCRIPTION_ID` and `AZURE_CLIENT_ID` enable the managed identity authentication chain. All secret values are masked in this submission.

---

## Task 7: End-to-End Pipeline (15 points)

### Evidence 7.1: Web App Wiring

Embed screenshot showing `FUNCTION_START_URL` and `FUNCTION_STATUS_URL` configured on the Web App.
![App settings](<./docs/7.1.png>)

Description: The Web App `pa4-27100104` has two Application Settings that wire the frontend to the backend. `FUNCTION_START_URL` points to the Durable HTTP starter endpoint on `pa4-27100104-fn`, which the frontend POSTs the order payload to. `FUNCTION_STATUS_URL` points to the Durable Task runtime status endpoint, which the frontend polls every 3 seconds to check orchestration progress. Using App Settings instead of hardcoding means the URLs can be updated without touching or redeploying the frontend code.

### Evidence 7.2: Happy Path UI

Embed screenshots of the form before submit, Running status, and Completed status with report URL.
![idle](<./docs/7.2a.png>)
![running](<./docs/7.2b.png>)
![complete](<./docs/7.2c.png>)
![pdf](<./docs/7.2d.png>)

Description: A valid order was submitted with Order ID `ORD-E2E-003`, SKU `WIDGET-X`, and Quantity `2`. After clicking Submit, the status panel showed `Running` with a live instance ID within seconds, confirming the HTTP starter successfully triggered the Durable orchestration. After approximately 90 seconds the status changed to `Completed` with a report URL link. Clicking the link opened the generated PDF from blob storage at `https://pa427100104.blob.core.windows.net/reports/ORD-E2E-003.pdf`, confirming the full end-to-end pipeline completed successfully.

### Evidence 7.3: Backend Participation

Embed screenshots showing orchestration status and Blob PDF evidence.
![](<./docs/7.3c.png>)

Description: Due to subscription-level restrictions, the Application Insights invocation logs and the Function App Monitor were not accessible in this Azure subscription — attempting to view them returned an authorization error. As an alternative, the orchestration status was queried directly via the Durable Task REST API (`/runtime/webhooks/durabletask/instances`), which returned `runtimeStatus: Completed` with `output: {status: completed, report_url: https://pa427100104.blob.core.windows.net/reports/ORD-E2E-003.pdf}`, confirming both `validate_activity` and `report_activity` executed successfully. The blob storage screenshot shows `ORD-E2E-003.pdf` present in the `reports` container, further proving the ACI ran and the report was written to storage. The log stream via `az webapp log tail` was attempted but produced only Kudu-level HTTP access logs rather than application-level function execution logs, which is a known limitation of containerized Function Apps when application logging is not pre-configured.

### Evidence 7.4: Reject Path UI

Embed screenshot of an order with `qty > 100` being rejected.
![rejected](<./docs/7.3a.png>)
![no ci report](<./docs/7.3b.png>)

Description: An invalid order was submitted with Order ID `ORD-BAD-001`, SKU `WIDGET-X`, and Quantity `999`. The orchestrator called `validate_activity`, which POSTed to the AKS validator and received `{valid: false, reason: "quantity exceeds limit"}`. The orchestrator immediately returned `{status: rejected}` without calling `report_activity` — this short-circuit pattern means no ACI was ever spawned. The `az container list` CLI output confirms no `ci-report-ord-bad-001` container was created, proving the orchestrator correctly skipped the expensive ACI provisioning step for invalid orders.

---

## Task 8: Write-up and Architecture Diagram (5 points)

### Evidence 8.1: Architecture Diagram

Embed your architecture diagram from `docs/`.
![Architecture](<./docs/arch.png>)

Description: The diagram shows all six Azure services and their interconnections. GitHub pushes to the App Service via CI/CD. The user browser sends HTTPS requests to the App Service, which proxies orders to the Durable Function HTTP starter. The orchestrator calls the AKS validate-api via HTTP, and if valid, creates an ACI report-job container via the Azure Container Instance SDK. The ACI writes the PDF to Blob Storage using the Managed Identity. ACR supplies container images to AKS, ACI, and the Function App. The Managed Identity (`mi-pa4-27100104`) bridges the IAM relationship between the Function App and the resources it manages.

### Question 8.2: Service Selection

In 3-4 sentences each, explain why TaskFlow uses App Service, Durable Functions, AKS, and ACI for their specific roles.

Azure App Service is the right compute platform for the TaskFlow web frontend because it provides a fully managed Linux runtime for Node.js with guaranteed uptime, built-in HTTPS via *.azurewebsites.net, and native GitHub CI/CD integration that triggers automatic redeployments on every push to main. The B1 Basic plan keeps the process warm at all times, which is essential because the frontend polls the Durable Function status endpoint every 3 seconds — a cold-start penalty on every poll would degrade the user experience significantly.

Durable Functions are the correct orchestration layer because the TaskFlow pipeline is a multi-step, stateful workflow that can take 60–120 seconds end-to-end and must not lose state if any step fails. The framework's checkpoint-and-replay model ensures that if report activity fails after validate activity has already succeeded, only the report step is retried — the validation result is read from Azure Storage cache, not re-executed. A plain HTTP-triggered function would require holding an open HTTP connection for the entire 60–120 seconds, which would time out on the Consumption plan (5-minute limit) and provide no retry semantics on partial failure.

AKS is the appropriate host for the validate-api microservice because it is a long-lived HTTP service that must be permanently reachable at a stable endpoint. Kubernetes Deployments ensure the pod is automaticaly restarted if it crashes, and the LoadBalancer Service provides a stable public IP. The validator is called synchronously during every order's orchestration — if it were on ACI, each invocation would incur a 20–60 second cold-start while waiting for the container to provision, making the pipeline unacceptably slow.

ACI is ideal for the report-job because it is a one-shot batch task with no incoming HTTP traffic — it starts, generates a PDF, uploads to blob storage, and exits. ACI bills per second of actual execution (approximately 20–30 seconds per report), costing a fraction of a cent per run with zero idle cost. Running this same job as a persistent AKS pod would incur continuous node charges even between orders, making ACI the clearly cheaper and architecturally cleaner choice for this workload.

### Question 8.3: ACI vs AKS

Compare idle behavior, cost behavior, and operational model for AKS and ACI using your screenshots.

AKS idle behaviour (10 minutes of no requests): The AKS node continues running and billing normally. The validate-deployment pod remains in Running state, consuming its reserved 250m CPU and 500Mi RAM on the node, but executing no user code. The kubelet sends periodic health checks to the pod, and the pod responds. From the cluster's perspective, "idle" simply means no HTTP requests are being handled — the infrastructure state is unchanged.

Each of the 1000 submissions triggers: (a) one AKS validator call — the single pod handles all 1000 sequentially (no autoscaling configured), becoming a bottleneck but not increasing in cost; (b) one ACI instance per valid order — if all 1000 are valid, 1000 ACI instances are created, each running for 30 seconds at 1 vCPU. Cost: 1000×30×$0.000014 = $0.42 in ACI compute, plus image pull bandwidth. The AKS node stays at a fixed $0.042/hour regardless of the flood. ACI is the variable cost driver under load. Mitigation: add rate limiting at the App Service or Function App layer (requests per user per minute) before they reach the orchestrator.

### Question 8.4: Durable Functions vs Plain HTTP

Explain at least two problems that Durable Functions solves for this sequential workflow.

Function timeout and blocking: A plain Azure Function on the Consumption or Flex Consumption plan has a configurable maximum execution time of 5–10 minutes. The report activity alone can take 60–90 seconds (create ACI, wait for it to reach Succeeded, delete it). Combined with validate activity and network overhead, the total exceeds safe limits for a long-lived plain function. More critically, a plain HTTP function blocks a thread for the entire duration — during those 90 seconds, that function instance is tied up waiting on time.sleep(5) polling loops. Durable Functions avoid this because the orchestrator exits between activities and is replayed only when the next activity completes, consuming zero compute while waiting.

State persistence on failure: If a plain function chain crashes halfway (server restart, transient network error, ACI timeout), all in-flight state is lost. The user's order would silently fail with no record of whether validation passed. The user would have to resubmit, potentially causing duplicate orders. Durable Functions persist every activity result to Azure Storage as it completes. If the host crashes after validate activity succeeds, the orchestrator replays from that checkpoint on recovery — it reads the cached validation result and proceeds directly to report activity without re-validating. This gives exactly-once activity execution semantics without any custom retry logic.

### Question 8.5: Cost Review

Embed Cost Management screenshot scoped to your resource group.
![](<./docs/8.5.png>)

Description: The most expensive resource in the resource group is the AKS node (`Standard_B2s`), which runs continuously 24/7 at approximately $0.042/hour regardless of traffic — roughly $1/day or $7/week. The App Service B1 plan is the second largest cost. The Function App shares the same App Service Plan so it adds no extra compute cost. ACR Basic, ACI (per-second execution), and Blob Storage together cost less than the AKS node for typical assignment usage levels. This confirms the architectural decision: AKS is worth the fixed cost for the always-on validator, while ACI's per-second billing keeps report generation costs negligible.

### Question 8.6: Challenges Faced

**Authorization Issues:** There were multiple instances where i faced difficulties due to strict role-based access control policies in the shared subscription. The managed identity `mi-pa4-27100104` was not automatically attached to the Function App even though it existed in the resource group — i had to explicitly run `az functionapp identity assign` to attach it. Additionally, Application Insights invocation logs were inaccessible due to subscription-level restrictions, so i used the Durable Task REST API directly to verify orchestration results instead.

**Running the Function locally:** I was using a broken `.venv` folder inside the `function-app/` directory which had no Python binary. When running `func start`, it fell back to the system Python 3.14 (installed via Homebrew) which didn't have any of the packages from `requirements.txt` installed. This caused `ModuleNotFoundError: No module named 'azure.durable_functions'` crash at startup. The fix was to delete the broken `.venv`, recreate it with `python3.11 -m venv .venv`, and install the requirements using the new venv's pip before activating it and running `func start`.

**Conflicting AzureWebJobsStorage settings:** The Function App had both `AzureWebJobsStorage` (a full connection string) and `AzureWebJobsStorage__accountName` + `AzureWebJobsStorage__credential` (managed identity style) set simultaneously. The Functions host crashed on every startup because it couldn't reconcile both authentication methods at once. Removing the plain `AzureWebJobsStorage` connection string and keeping only the managed identity settings resolved the 503 errors.

**Invalid REPORT_LOCATION value:** The `REPORT_LOCATION` application setting on the Function App was set to the literal placeholder text `<uaenorth-or-ukwest>` instead of the actual region `ukwest`. This caused the `report_activity` to fail with `InvalidResourceLocation` when trying to create the ACI container group. Updating the setting to `ukwest` fixed the issue.

---
