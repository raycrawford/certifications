# Implement Azure Storage blobs and Azure files
## Storage Accounts & Blobs
* Storage account name must be a globally unique, a-z string, 3-24 characters
* Container names are 3 - 63 characters:
  * Are all lower case letters, numbers or '-'
  * '-', but not consecutive, leading or terminating
* Blob names are 1-1024 characters and can not contain more that 254 "segements"
## Block blob vs Page blob vs Append blob
* [From slides](https://docs.microsoft.com/en-us/rest/api/storageservices/Understanding-Block-Blobs--Append-Blobs--and-Page-Blobs?redirectedfrom=MSDN)
* Block blobs are optimized for streaming (reads?)
  * Max size of a block blob is 5 TB
* Page blobs are optimized for random read/write and provide the capability to write to a range of bytes in a blob; these are primarily used for VHDs
  * Initialized with "Put Blob"
  * Writen to using "Put Page"
  * Max size is 8 TB
* Append blobs are optimized for appends
  * Initialized using "Put Blob"
  * Written to using "Append Block"
  * 4 MB block max/max 50,000 blocks/max blob size 200 GB
## Blob API stuff
* Blobs can be put up to 1/4 GB using "pub block"; larger, and they must be broken up into separate blocks and reassembled using "put block list"
## SAS Token
# Files
* Uses the SMB interface and RESTful API for access

# Files vs Blobs
* Files are only LRS & GRS
* Files can use SMB 2.1 (3.0 in more recent releases) & RESTful APIs like Blobs
* RESTful access works worldwide, but SMB only works within region
* Files are case insensitive but case preserving
  * Blobs are case sensitive
* Files provide true directory objects
  * Blob storage is flat but simulates heirarchy by prefix listing
* File shares can be 5 TB
  * Blob containers can be 500 TB
* File SHARES can do 60 MB/s
  * Blob storage can do 60 MB/s PER BLOB
* Files on Shares and Blobs can be upto 1 TB each
* Files are billed based upon size
  * Blobs are billed based upon bytes written (??)
* Endpoints:
  * Files:
    * http://SA.file.core.windows.net/<share>/<file>
    * \\SA.file.core.windows.net\<share>\<file>
  * Blobs:
    * http://SA.blob.core.windows.net/<share>/<file>

## Replication options (repeated from VMs page)
* LRS: 3 copies in same facility
  * Live in different fault and update domains
* ZRS: 3 copies of data in 2-3 facilities within a single region
* GRS: LRS in 2 different regions 100's of miles apart
* ROGRS: GRS, but can be read in 2nd region
  * append -secondary to the SA part of the storage URL

## Storage Service Encryption
* 256 BIT AES encryption
* ***ONLY*** for Block, Page and Append Blobs in ARM
* Only encrypts from time turned on, forward, in that Storage Account
* Set on the Storage Account in ARM templates

# Implement Azure storage tables and queues
## Table
* [Getting started with Tables using .Net](https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-how-to-use-tables)
* The Azure Table storage service stores large amounts of structured data. The service is a NoSQL datastore which accepts authenticated calls from inside and outside the Azure cloud. Azure tables are ideal for storing structured, non-relational data. 
* ODATA and Table Client interface (don't know what this means)
* Uses a SAS token

## Queues
* [Getting started with Queues using .Net](https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-how-to-use-queues)
* Uses a QueueClient interface to access

## Access differences (via RESTful API)
* Blobs: //[account].blob.core.windows.net/[container]/[ blob]
* Files: //[account].file.core.windows.net/[file]
* Tables: //[account].table.core.windows.net/[table]([paritition key],[row key])
* Queues: //[account].queue.core.windows.net/[queue]

# Manage access and monitor storage
# Creating a SAS token
* Slide 31
* [.Net example of Service and Application](https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-shared-access-signature-part-2)
## Steps:
You need to write a SAS Token Service which has access to your subscription or storage account; at the end of the day, it needs a key from your storage account

* App request SAS token from SAS Token Service
* SAS Token Service generatese and returns SAS Token
* App makes storage request to Azure Storage with SAS Token
* Azure Storage provides response to App

# Implement Azure SQL Databases
* Understand tiers
* Understand DTU
* Understand how to migrate
* Understand SQL database scaling
  * Global database that contains data about shards
  * Understand when/when you should not scale your DB

# Implement Azure DocumentDB
# Implement Redis caching
* Slide 36
* What are the tiers?
* Optimistic vs Pessimistic concurrency
* Distributed app caching
  * Shared vs Private
  * Data persistence
  * Clustering

# Implement Azure Search
* What does it mean to create an index
* How do I create a search index
* How do I add data
* Understand the results that come back (and how to paginate)