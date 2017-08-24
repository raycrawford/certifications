# Azure AD
* Interface to the Azure AD is the Graph API (rather than LDAP)
* How do we intergrate in a hybrid configuration
  * Single Sign On
  * Need to understand that it can synchronize with On Prem AD
  * For 70-533, need to know how to synchronize
  * For 70-532, you assume everything is working and need to know how to do SSO

## Features of the AAD offerings

## Graph API

## OAuth

## OpenID Connect

## Pricing 
* Free is limited to 500,000 directory objects
* Free an basic limit users to 10 SSO apps
* Dynamic groups and self service is opened up at Premium
* Beleive B2B is part of this, but you're just inviting people from other tenants to play a role in your tenant

# Azure AD B2C
* How does B2C fit in
* Uses OpenID (OIDC) and OAuth to other social services
* Uses Azure AD Open API

## Pricing
* Priced by Stored Users/Authentications/Multifactor authenticaitons
* 50,000 free users; $11/10,000 there after
* 50,000 free Authentications; $28/10,000 there after
* MFA is $0.03/authentication

# Azure AD B2B
* Integrate with other organizations
* Understand why you would need it

# B2B vs B2C

|  | Azure AD B2B Collaboration | Azure AD B2C|
| -- |--|--|
| What is it for? | IT Pros providing access to their organization's data and applications to partner organizations and collaborators. | Deveopers working on Consumer and Citizen facing mobile and web apps that reach out to the customer and citizens directly. |
| Who is it for? | Partner users that are acting "on behalf of", i.e., as representatives or employees of their organizaiton | Consumers and citizens that are acting as themselves |
| Manageability | Access reviews, e-mail verification, allowlist/denylist, etc...  govern access to host application and resources. | Self-serve.  Users manage their own profiles. |
|Discoverability| Partner users are discoverable and can see other users from their own organization (subject to policy). |  Consumers and citizens are invisible to other consumers and citizens.  Privacy and consent are paramount. |

# When to use B2B/B2C/Multi-tenant AD
| Consider this product | Azure AD Multi-tenant SaaS app | Azure AD B2B | Azure AD B2C |
| --- | --- | --- | --- |
| If I need to provide | A service to businesses | Partner access to my apps | A service to consumers |
| And I am similar to | Pharm Distribution | Imaging company | Sports Franchise |
| Deploying an app for... | Practice Management | Supplier Extranet | Soccer Fans |
| Targeting | Doctor's offices | Approved business partners | Anyone with e-mail |
| Accessible when | Customer admin consents | My admin invites | The consumer signs up |


# Communication
# Messaging
## Azure Service Bus
* How does it fit into the overall service?
## Queues
## Topics
## Relay
## Notification Hubs
## Service Bus VS Storage Queue

| Service bus queues | Storage queues |
| --- | --- |
| FIFO guaranteed | Order NOT guaranteed |
| Delivery once and only once | Delivery at least once, maybe multipole times | 
| 60 second default locks can be renewed | 30 second default locks, extendable to 7 days |
| Messages are finalized once consumed | In-place updates of content |
| Native integration with WCF and WF | Can integarate with WF through custom activity |