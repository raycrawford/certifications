# 70-532 - Developing Microsoft Azure Solutions
* See: https://www.microsoft.com/en-us/learning/exam-70-532.aspx
* Exam scheduled for 8/23/17
* Last update: 11/22/2016

# Sections
* Create and Manage Azure Resource Manager Virtual Machines (30 - 35%)
  * Deploy workloads on Azure Resource Manager (ARM) Virtual Machines (VMs)
  * Perform configuration management
  * Configure ARM VM networking
  * Scale ARM VMs
  * Design and implement ARM VM storage
  * Monitor ARM VMs
  * Manage ARM VM availability
* Design and implement a store and data strategy (25-30%)
  * Implement Azure Storage blobs and Azure files
    * Interesting: Any updates made to a blob are atomic. While an update is in progress, requests to the blob URL will always return the previously committed version of the blob until the update is complete. 
  * Implement Azure storage tables and queues
  * Manage access and monitor storage
  * Implement Azure SQL Databases
  * Implement Azure DocumentDB
    * Now CosmoDB
    * Globally distributed with single-digit latencies
    * Self indexing; schema agnostic
    * Allow any datamodel
    * Multiple consistency models to enable app-specific tuning
  * Implement Redis caching
    * Basic: Single node, multiple sizes, ideal for development/test and non-critical workloads. The Basic tier has no SLA.
    * Standard: A replicated cache in a two-node primary/secondary configuration managed by Microsoft, with a high-availability SLA.
      * Basic and Standard caches are available in sizes up to 53 GB
    * Premium: All of the Standard tier features, including a high-availability SLA, as well as better performance over Basic and Standard-tier caches, bigger workloads, disaster recovery, enhanced security, and more.
      * Redis persistence allows you to persist data stored in Redis cache. You can also take snapshots and back up the data which you can load in case of a failure.
      * Redis cluster automatically shards data across multiple Redis nodes, so you can create workloads of bigger memory sizes (greater than 53 GB) and get better performance.
      * Microsoft Azure Virtual Network deployment gives you enhanced security and isolation for your Azure Redis Cache, as well as subnets, access control policies, and other features to further restrict access.
      * Premium caches are available in sizes up to 530 GB.
  * Implement Azure Search
* Manage identity, application and network services (15-20%)
  * Integrate an app with Azure Active Directory (Azure AD)
  * Design and implement a communication strategy
  * Design and implement a messaging strategy
  * Develop apps that use Azure AD B2C and Azure AD B2B
* Design and implement Azure PaaS compuate and web and mobile services (25-30%)
  * Design Azure App Service Web Apps
    * You can have up to five slots
      * All slots exist on the same VM; beware of load testing
    * When you flip slots
      * Swap
        * Connection strings
        * Handler mappings
        * App and Site diagnostic settings
        * Monitoring settings
        * General settings (i.e., AlwaysOn, etc.)
      * Don't swap
        * Publishing endpoints
        * Custom domains
        * SSL certs
        * Scale settings
    * To migrate a Web App between App Service Plans, the plans must be in the same region and resource group
  * Implement Azure Functions
  * Implement API management
  * Design Azure App Service API Apps
  * Develop Azure App Service Logic Apps
  * Develop Azure App Service Mobile Apps
  * Design and implement Azure Service Fabric Apps

# Resources
[Certification Exam Overview: 70-532: Developing Microsoft Azure Solutions](https://mva.microsoft.com/en-US/training-courses/certification-exam-overview-70532-developing-microsoft-azure-solutions-17404?l=YmdM8DmjD_506218965)
* This one is good; was release in March of 2017
* PPT Deck can be found on the local FS as 70-532_exam_prep_Brian_Swiger.pptx

# Study Strategies
* MVA resource: https://mva.microsoft.com/en-US/training-courses/certification-exam-overview-70532-developing-microsoft-azure-solutions-17404
* EdX course: https://www.edx.org/course/developing-microsoft-azure-solutions-microsoft-dev233 
* Resource Manager API Reference: https://msdn.microsoft.com/en-us/library/azure/ee460799.aspx
* A site where some guy built a seemingly comprehesive list of 532 stuff: https://www.ajitpals.com/
* Old(ish) 70-532 book: https://ptgmedia.pearsoncmg.com/images/9780735697041/samplepages/9780735697041.pdf
* Someone's Trello search board: https://trello.com/b/tRaujay3/70-532
* http://pietschsoft.com/post/2015/06/06/How-I-passed-the-70-532-Developing-Microsoft-Azure-Solutions-certification-exam
