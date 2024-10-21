﻿# ZRA SMART INVOICE CONNECTOR USER GUIDE


- [ZRA SMART INVOICE CONNECTOR USER GUIDE](#zra-smart-invoice-connector-user-guide)
  - [1. Introduction](#1-introduction)
  - [2. Setup and Configuration](#2-setup-and-configuration)
    - [2.1 Integration Setup](#21-integration-setup)
    - [2.2 Commodity Codes](#22-commodity-codes)
    - [2.3 ZRA VAT Types](#23-zra-vat-types)
    - [2.4 VAT Product Posting Groups](#24-vat-product-posting-groups)
    - [2.5 VAT Posting Setups](#25-vat-posting-setups)
    - [2.6 Reason Codes](#26-reason-codes)
    - [2.7 Payment Methods](#27-payment-methods)
    - [2.8 User Management](#28-user-management)
  - [3. Integration with ZRA](#3-integration-with-zra)
    - [3.1 Invoices \& Credit Memos (Sales \& Purchases)](#31-invoices--credit-memos-sales--purchases)
    - [3.2 Item Worksheet](#32-item-worksheet)
    - [3.3 Job Queue](#33-job-queue)
    - [3.4 Customs Imports](#34-customs-imports)
  - [4. **Troubleshooting**](#4-troubleshooting)


## 1. <a name="_toc178688686"></a>Introduction

   The Braintree ZRA Smart Invoice Connector is a software solution designed to integrate with the Zambia Revenue Authority (ZRA) system, enabling businesses to automate their tax compliance and submission processes. This user guide provides an overview of the system's features and functionality, as well as step-by-step instructions on how to use the system.

## 2. <a name="_toc178688687"></a>Setup and Configuration

   Before using the Braintree ZRA Smart Invoice Connector, you need to set up and configure the system. This involves:

- Installing the extension in your Business Central environment
- Configuring the system settings, such as the ZRA tax code and integration setup
- Setting up user accounts and permissions

>The following system settings need to be configured.

### 2.1 <a name="_toc178688688"></a>Integration Setup
<ol>
<li>Open the ZRA Integration Setup menu.</li>
<li>Select the **Integration Service Provider**</li>
<li>Confirm that the **Target API URL** is correct for the Service Provider</li>
<li>Enter the following fields 
<ol>
  <li>**API Key**</li>
  <li>**SDC ID**</li>
</ol>
</li>
<li>Lastly, **Enable** the integration</li>
<li>If you want to host the list of commodity codes locally in the database, you can leave the **Use Web Service for commodity lookup** field disabled. Not all service providers do, but if the chosen Service Provider does support commodity code lookup, you can enable this feature.</li>
</ol>

![image002](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image002.png)

>The user can download a copy of ZRA Codes used for mapping in the system as described in this document.

### 2.2 <a name="_toc178688689"></a>Commodity Codes
If service providers do not provide an API endpoint for the commodities, download and import the commodities list from the ZRA Item Category List.
![image003](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image003.png)

### 2.3 <a name="_toc178688690"></a>ZRA VAT Types
A predefined list is created when the extension is installed. This list can be modified as required. 

Description of fields:

- **Code**: Unique identifier, used by most Service Providers
- **Value**: A secondary identifier, used by some Service Providers.
- **Blocked**: *Not used yet, reserved for future use.* 
- **Requires recommended Retail Price**: When enabled, requires items to be registered with a recommended retail price when this code is used on a transaction.

![image004](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image004.png)

### 2.4 <a name="_toc178688691"></a>VAT Product Posting Groups
Link Zambian Tax Codes to VAT Product Posting Groups. This is the code used for Items when registering them with ZRA.

![image005](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image005.png)

### 2.5 <a name="_toc178688692"></a>VAT Posting Setups
Link Zambian Tax Codes to VAT Posting Setup. These are the Tax codes used on document lines when the document is submitted to ZRA.

![image006](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image006.png)

### 2.6 <a name="_toc178688693"></a>Reason Codes
Link the predefined service provider reason codes to the Reason Codes in Business Central.

![image007](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image007.png)

### 2.7 <a name="_toc178688694"></a>Payment Methods
Link supplier defined codes to the existing Payment Methods in Business Central.

![image008](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image008.png)

### 2.8 <a name="_toc178688695"></a>User Management 
Two Permission Sets have been added:

<ol>
<li>ZRA ALL BTR – For administrators of the integration, that are allowed to change the configuration.</li>
<li>ZRA BASIC BTR – For all other users, so that the integration can happen in the background.</li>
</ol>

>The system also maintains a list of users and assigns a unique integer to each user as required by the ZRA interface. This should not require any maintenance by an administrator.


![image009](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image009.png)


## 3. <a name="_toc178688696"></a>Integration with ZRA
   The Braintree ZRA Smart Invoice Connector enables you to automate your tax compliance and submission processes with the ZRA system.

   Integration happens in the background and without user interaction. On posting of Sales and Purchase documents, the system creates:
   <ol>
   <li>Integration Entries. Serves as a log for what has or has not been submitted. 
   <ol>
      <li>Also carries status codes and messages for troubleshooting.</li>
      <li>User can resubmit entries for processing from here.</li>
   </ol>
   </li>
   <li>Job Queue Entries. Background process that is responsible for processing the requests.</li>
   </ol>

![image010](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image010.png)

### 3.1 <a name="_toc178688697"></a>Invoices & Credit Memos (Sales & Purchases)
ZRA requires certain information on the documents. Checks have been put in place to ensure that they are captured before a document can be released and posted.

>Note: Posted Sales Documents (Invoices and Credit Memos) need to be submitted to the ZRA before they can be printed. The ZRA mandates that certain information is printed on all invoices, but this information is only returned from ZRA after submission. A custom automated job could be configured to print or send invoices by email after reply is received from the ZRA Smart Invoice system.

>If a credit note is for an invoice that has not been fiscalized, the **Apply to Non-Fiscalized Invoice** field on the Credit Memo or Return Order can be set to *Yes*. This will allow the user to post and print non-fiscalized documents.

Requirements:

1. Payment Method Code – Required field on header
2. If Credit Memo or Return Order (only if **Apply to Non-Fiscalized Invoice** = *No*)
   1. Applies-to Doc. Type
   2. Applies-to Doc. No.
3. VAT Posting Setup combination must have a linked ZRA VAT Type
4. ZRA Smart Invoice No. (Purchase only)

Checks during integration:

1. Item must be registered from the ZRA Item Worksheet.
2. **Recommended Retail Price**, if required by the setup on the ZRA VAT Type (this is usually for Tax Code "B")

### 3.2 <a name="_toc178688698"></a>Item Worksheet
The ZRA Item Worksheet is used to register items with ZRA. It is a required step for document to be submitted.

1. Search for and open the ZRA Item Worksheet.
2. Select a Batch Name to work in.
3. On the ribbon menu, click Home | Get Lines
4. Select the entities you want to pull into the worksheet
5. The filters for each entity will only apply if the entity is selected to be processed.
6. Click OK. The worksheet is now populated with the default information for the entity. If the entity has been registered previously, the user will be able to update the record.

    ![image011](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image011.png)

    ![image012](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image012.png)

7. Required fields:
   1. **New Description**
   2. **Item Category Code (ZRA)**
   3. **New Product Type**
   4. **New VAT Category**
   5. **New Recommended Retail Price** (mandatory if required by VAT Type)
   6. **Quantity Unit of Measure Code (ZRA)** – see Integration Setup. This must be a code as defined by the ZRA.
   7. **Packaging Unit of Measure Code (ZRA)** – see Integration Setup. This must be a code as defined by the ZRA.
   8. **Country Code of Origin**

8. Click Home | Register Items. This will process the entries in a background process and the progress can be monitored on the Integration Entries page.

### 3.3 <a name="_toc178688699"></a>Job Queue
There are 5 Job Queue Entries that are created automatically when the extension is installed. Each of them performs different tasks for the integration to run smoothly.

By default,

1. *Create Job Queue Entries from Integration Entries*: Finds Integration Log Entries with **Status** = *New* and creates a Scheduled Task for them to be processed.
1. *Export Stock Data*: Submits registered ZRA Items (only linked to the Item table) to the Service Provider to satisfy the stock adjustment requirement. (Only applies when using Fiscal Edge as Service Provider)
1. *Clear completed integration entries*: Uses a parameter in the parameter string of the Job Queue Entry to specify the frequency at which it must check for and remove completed records out of the Integration Entries table.
1. *Import Purchase Orders*: If the service provider supports importing of purchase orders from other Smart Invoice customers, this will import the documents into a staging table.
1. *Create BC Purchase Invoices*: If the service provider supports importing of purchase orders from other Smart Invoice customers, this will create purchase documents from the staging tables.

![image013](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image013.png)

### 3.4 <a name="_toc178688700"></a>Customs Imports
The ZRA Smart Invoice system allows users to accept or reject goods sitting at customs. This can be done on the Service Provider’s portal, or in Business Central.

1. Search for and open the ZRA Customs Imports page
2. Click Actions | Get All Imports
3. This will fetch any pending imports
4. Open the Customs Import card for an import entry
5. For each line, update the **PLU Code** (a.k.a. ZRA Item No.)
6. Set the **Import Action** to either Approved or Rejected.
7. When all lines are updated, click Approve Lines action on the header.
1. This will submit your selection to the ZRA.

![image014](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image014.png)

![image015](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image015.png)


## 4. <a name="_toc178688701"></a>**Troubleshooting**
   If you encounter any issues or errors while using the Braintree ZRA Smart Invoice Connector, refer to the troubleshooting guide below:

- Check the Integration Entry or Job Queue Entries for error messages
- Verify that the system settings are correct
- Contact the Braintree support team for assistance. 

Email: <bcsupport@braintree.co.za>


![Logo](./docs/Braintree%20ZRA%20Smart%20Invoice%20Connector%20User%20Guide_files/image001.jpg)