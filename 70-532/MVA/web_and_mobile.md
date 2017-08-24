# App Service
* Auto-patching and auto-scale
* .NET, Java, Node.js, PHP, Python
* Integrate with SaaS and on-premises
* Continuous integration with Visual Studio Team Services (VSTS), GitHub, BitBucket and more

## Web Apps
### Deployment
* One or more App Service Plans lives in a Resource Group
* Individual Sites live in an App Service Plan
* Sites can be made up of one or more Slots

### Diagnostics
* Azure Application Insights is used to capture telemetry data
* Build into the web app
* Can be build into just about anything
* The data is used by DevOps to monitor the applications

### What is a Web Job
* Can be run using on-demand or scheduled initiation
* Runs within the web-app process; it's in the Web App
* Upload some code in a zip file (Python, Batch, PowerShell, Java, .Net)
* settings.job at the root of the zip file sets schedule or just use the UI

### How to Scale
* Azure Traffic Manager to route traffic

### Build in Resiliency

## Mobile Apps
## API Apps

## Logic Apps
* Workflow - graphically model processes and integrate decision trees
* Managed Connectors - prebuilt things to do stuff (i.e., HTTP/FTP/Azure Storage, etc)
* Triggers - start instances of a workflow
* Actions - steps in a workflow after it is triggered
* Has 'Enterprise Integration Pack' for more advanced scenarios like BizTalk integrations
* Not sure of how much stuff a logic app can do; it's only billed per action...  What if you said, "When this happens, copy 265 GB across the backbone"; how does it keep the connection open that long?
  * I think logic apps are just the "API Gateway" and then you would use something like Azure Functions to do things...

# API Management
* Slide 54
* Funny...  Useful features like Unlimited AD User Accounts and VPN integration are available in Developer and Premium, but not Standard.  I guess they want you to be driven out of Devleoper because of bandwidth and Standard because of features.  :)
* I think the VPN is so you can drop the API gateway on a non-routable VNet and connect to it via VPN... but not sure.
* [Key concepts](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts)
* Create managed API's
* API Gateway
* Developer portal
* Publisher portal
* Can customize the devloper portal
* Can add caching
* Can use API Inspector to trace calls
* Can provide rate limiting

## Products
* One or more APIs with:
  * A title
  * A description
  * Optional Terms of Use
  * Rate Limits/Quotas
* Products can be open or protected; protected products must be subscribed and can either be admin approved or auto-approved
* Think of it as a usage plan from a Cell provider
* Products can be assigned to zero or more Groups
* Policies are how Rate Limites and Quotas are defined (backed upon a Product)

## Groups
* Groups of individuals (e.g. Developers/Admins/etc) that can see various products
* Starts with "Guests", "Developers" and "Administrators"
* Administrators can add other groups or the system can be interfaced with an Azure AD tenant
* As an FYI, "Devlepers" are considered consumers of the API services, not DEVELOPERS of the API services

# Cloud Services
* PaaS with VM control
* Simple .NET runtime
* Health, discovery, updates
* OS Patching
* The original PaaS offering from 2010 and still useful when low-level OS access is needed
* The home of Web and Worker roles

# Service Fabric
* Modernization with microservices
* CD/CI pipeline endpoint
* Stateful service
* Can host docker containers
* Service Fabric can be run on premise
* Understand the Actor Programming Model
* Understand interfaces to Visual Studio

# Functions
* Serverless experience in response to events
* Responds to events in other Azure services, SaaS products
* Only pay while running
* How does it fit into the overall app?
* How do I catch events?
* How do I use? 
## Pricing
* 1 Million free executions/month
* 400,000 GB-s free
  * GB-s is memory consumed x seconds run
## OOB Triggers
* Http
* Timer
* Queue
* Blob
* Service Bus Queue
* Generic Web Hook
* GitHyb Webhook
* Http With Parameters
* Manual


