# Overview
* Pushed on Hyper-scale and Hybrid

# Web Apps
* Azure Website: https://aka.ms/edx-DEV233x-az04
* Supported frameworks OOB: ASP.NET, Java, PHP, Node.js, or Python

# Virtual Machines

# Storage
## Blobs
## Queues
## Tables
## Files

# SQL Database

# Virtual Networks
* You can have multiple NICs, but all NICs need to be on the same VNet; this is a limitation of the platform.

## Auto scaling by metric
* ***Average CPU usage***: If the average percentage of CPU usage goes above or below specified thresholds, role instances are created or deleted, or virtual machines are turned on or turned off from an availability set.
* ***Queue messages***: If the number of messages in a queue goes above or below a specified threshold, role instances are created or deleted, or virtual machines are turned on or turned off from an availability set.

When you define rules, you must speficify:
* ***Schedule***: when the rules apply
* ***Instance Range***: min and max number of instances
* ***Metrics***: Target CPU or Queue Target per machine (total/number of VMs)
* ***Scale Up/Down By***
* ***Scale Up/Down Wait***

# Azure Resource Manager RESTful API
* Resource Manager API Reference: https://msdn.microsoft.com/en-us/library/azure/ee460799.aspx

## Authenticating
### Azure AD for custom Apps
* Azure AD Authentication Library for .NET: http://go.microsoft.com/fwlink/?LinkID=525680

### Management Certs for other clients
* The Service Management API does not verify if a certificate is still valid and therefore it can be used with an expired or invalid certificate.
* Role-based authentication is not supported for certificate-based authentication.

## Site connectivity
* Via IPSec/VPN

## Direct connectivity
* Via SSTP (Secure Sockets Tunneling Protocol) or VPN

# DNS 
* DNS Service: https://aka.ms/edx-dev233x-az15

# Portal
* Classic Portal was introduced at TechEd 2012
* Current Portal was introduced at //build 2014

# DSC

As `webserver.ps1`:

```
Configure ConfigureWeb {
    Node localhost {
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }
    }
}
```

Load the configuration with `. .\webserver.ps1`

Execute the configuration with `ConfigureWeb`

# Configuration Management

Nothing new here...

# Module 3: Hosting Web Applications

## What is Azure App Service
* PaaS service for Web Apps, Mobile Apps, Logic Apps and API apps
* "Low-friction" way to get we apps out there

Interesting thought...  API Apps, Logic Apps and Mobile Apps are just Web Apps with "convenience" services

* Web Apps live within one App Service Plan
* Service tier characteristics are defined at the App Service Plan level and apply to all Web Apps in that App Service Plan

## Web App Tiers

### Free
* "Charged" per hour for each instance of the Web App
* Free offers 10 Web App instances that can, in aggregate, run for 60 minutes per day
* 165 MB outbound daily limit

### Shared
* Charged per hour for each instance of the Web App
* 100 Web App instances each of which can run for 240 minutes per day (time is not pooled)
* Unlimited outbound data

### Basic
* Not a shared environment; charged for time compute instance is up
* Unlimited Web App instances
* AlwaysOn
* SSL 
* Custom domains
* 350 WebSocket connections per Web App
* Scales to a maximum of 3 dedicated instances

### Standard
* Publishing slots
* Backups
* Autoscaling

## Kudu
Kudu is the engine behind most of the enhanced features that are offered by Web Apps. Kudu can also be used with your local web application projects. The Kudu project is an open-source project that is available on GitHub, and it supports many features such as:

* Web application publishing from a source control system
* Deployment hooks
* Web hooks
* Web Jobs

*** You can access the Kudu console for your  Web App by using the following URL format: https://[Web App Name].scm.azureWeb Apps.net ***

## Logic Apps
* Have a drag and drop UI, but it's just JSON in the background

## Azure Functions
Azure functions can be created as an extension of an App Service or be set up on a consumption basis.

## AlwaysOn
* Basically, the platform continously pings your Web App to make sure the IIS pools don't recycle.
* It is only available in the Basic And Standard tiers

## Domain Names
* By default, you get a `[http|https]://<sitename>.azureWeb Apps.net` domain name
* Custom domains are available, but not in the Free tier of service
* The Manage custom domains configuration dialog box allows you to associate an external domain with your Web App instance.
* Dialog box includes instructions on how to use a custom domain along with the virtual IP address for your Web App. If you are using multiple instances within a single Web App, the virtual IP address will be load-balanced across those instances. At this point, you can use your domain registrar’s Web App to configure a canonical name (CNAME) record and an address (A) records:
* IP: from Portal
* CNAME: [Web App Name].azureWeb Apps.net
* If you want a multi-region site, use Traffic Manager

To map an *** A record *** (root of domain) to an Azure App Service, two DNS records are needed:
* A record pointing the domain at the IP of your App Service
* A TXT record with <app_name>.azurewebsites.net; this acts as a domain validator

Wild cards don't need this.  You're just saying to the DNS, anything that doesn't match, send to Azure App Service IP...  then, in Azure, you map any given subdomain to the Web App.

# Traffic Manager
* Only works with Standard App Service Web Apps
* You create a CName for the root or subdomain of interest from your registrar to <MyApp>.trafficmanager.net
* This is DNS trickery...  it is not servicing as a proxy or gateway; users are still connecting with your endpoint
* Routes based upon 
  * Priority: use primary unless it's not available, failing over to secondary
  * Weighted: distribute traffic across a set of endpoints, either evenly or according to weights, which you define.
  * Performance: route user to the "closest" endpoint in terms of the lowest network latency
  * Geographic: direct user to specific endpoints (Azure, External, or Nested) based on which geographic location their DNS query originates from

# Autoscaling Web Apps
You must specify a scaling schedule. You can use schedules to specify different autoscale rules for different date and time periods. By default, a schedule is created for all time. After you create or select a schedule, you can define a metric to measure configuration values.

* Metrics:
  * CPU
  * Memory
  * HTTP Queue
  * Disk Queue
  * Data In
  * Data Out
* Must set schedule

# App Service Environments
* Middle road between App Services and IaaS
* Allows more configuration options
  * VNets/Networking

# Publishing a Web App
## Web Deploy Protocol
Web Deploy (msdeploy) is a combination of a package format and an IIS add-in that gives administrators and developers incredible flexibility to manage and deploy container applications.

A Web Deploy package is a simple representation of an IIS Web App. The package can contain the following data about your Web application:

* Binaries
* Content
* XML configuration
* Databases
* Registry modifications
* Assemblies and Globally Assembly Cache (GAC) references

# Deploy and Configure Web App
* Pretty bad ass...
* In *.cs: `this.EventCount = Int32.Parse(ConfigurationManager.AppSettings["EventsListViewModel.EventCount"]);`
* In web.config: `<add key="EventsListViewModel.EventCount" value="5" />`
* Then in the Portal Web App => Application Settings => App Settings, set the Key Value = EventListVewModel.EventCount = 2... and it shows up automagically on the web UI!!! Pretty cool!

# Azure SQL
SQL Database is a relational database as-a-service offering that provides predictable performance and a high degree of compatibility with existing management tools.
* Database Throughput Units (DTU)
* It is NOT mSQL, but it does mimic it through providing a TDS (tabular data string protocol) endpoint
* 90% feature parity with mSQL

One of the most common reasons for hosting SQL Server standalone in Azure is for lift and shift scenarios. Lift and shift workloads are applications that are migrated from one platform to another with minimum changes to the application’s source code or configuration. Migrating an existing SQL workload to Azure IaaS is much easier to accomplish than migrating your application to SQL Database. After you migrate, you can analyze your existing SQL workload and determine the degree of compatibility with SQL Database. For new (greenfield) applications, SQL Database provides a near-zero maintenance experience that can accelerate the time to market for the newly created applications.

## Supported tech
* Dynamic database data masking
* Transparent Data Encryption
* Always Encrypted; in-memory data encryption (needs a change to your app)

## Creating
* Database Servers must have a globally unique name (the TDS endpoint)
  * Windows Auth is not currently supported
* Database Instances do not need to be unique beyond the Database Server
* Remember the bullshit about DB jump boxes we talked at P&G... 
  * Toggle allows Azure services
  * Have to explicitly allow developer IPs
  * To accomodate this, create a jumpbox at azure and whitelist the IP...

## Migration tools
* Export a data-tier application
* SQL Server Integration Services (SSIS)
* Look at my Azure SQL bacpac story to figure this out...

## Data recovery
* Point-in-time restore
  * Basic: 7 days
  * Standard: 14 days
  * Premium: 35 days
* Database Copy: One-time copy of your database to a new instance in another datacenter
* Geo-restore: point-in-time restore to another region
* Standard Geo-Replication: all transactions replicated asynchronously; in even of outage, primary is marked as degraded and 2ndary takes over
  * Secondary is not a TDS enpoint until primary is degraded
  * Not included in basic
* Import/Export
  * Using BACPAC which includes data and schema

# Queues

## Azure Storage Queues
Storage queues provide a consistent and reliable way to store messages that can be consumed by multiple workers.

## Azure Service Bus
* Must have a Service Bus Namespace first

### Queues
* Typical queue
* FIFO; Storage Account Queues are not guaranteed to be specifically FIFO
* Can guarantee that a message is recieved and processed both at least and at most once by the message consumers
* Batch Send
* Transaction support with roll back
* Long Polling; can block the queue

What are the cost differences?

In .NET, use the BrokeredMessage class
* There is also an IDictionary<string, object> called properties that can contain anything
* Message body is serialized so it can be a complex object if that's what you want to send to your receiver applications
* Each message has two parts, a set of properties, representing a key/value pair, and a binary message body.

* Storage Queues provide REST-based Get/Put/Peek interface

### Topics
Publish/Subscribe model

## Relay
* Services talk without being connected

## Event Hub
* Let's you queue up messages in a high-volume way
* Used for IoT

## Notification Hubs
* Used for mobile pushes
* Seek to solve:
  * Platform dependencies
  * Scale
  * Routing
* Notification hubs are pretty cool.
* Either Device or App back end can register the user with Notification Hubs... this enables you to add other user metadata for segmented sends.
* Tags and Templates help you target your messaging

## Registrations
* Sub-service of notification hubs
* I don't understand this...

