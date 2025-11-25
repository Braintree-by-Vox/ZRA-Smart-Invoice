## 4. <a name="_toc178688701"></a>Troubleshooting
   If you encounter any issues or errors while using the Braintree ZRA Smart Invoice Connector, refer to the troubleshooting guide below:

### 4.1 Integration Entries

- Check the Integration Entry or Job Queue Entries for error messages
- Verify that the system settings are correct
- Use the guide below to confirm what each status means and what actions can be taken.
- The different states that an entry can be in, are:
  - *New*: Newly created entry. The "Create Job Queue Entries from Integration Entries" Job Queue Entry, will pick-up these entries and schedule them for processing.
  - *Validation Error*: An entry that fails its validation checks. No Job Queue Entry has been created.
  - *Job Queue Created*: Job Queue Entry has been created and scheduled to run.
  - *Error*: An error occurred when executing the Job Queue Entry.
  - *Error Acknowledged*: An Error or Validation Error occurred, but it is an error that cannot be resolved with the integration, or the entry was created in error. Can only manually be set to this value.
  - *Success*: Job Queue Entry executed successfully.
- Actions on the Integration Entries page:
  - Home
    - *Show Source Document*: For document type entries, navigates to the source record for this entry.
    - *Run once (foreground)*: If a Job Queue Entry exists, runs it immediately.
    - *Reset Validation Error*: For selected records, where the **Status** = *Validation Error*, sets the **Status** to *New*, and clears the **Status Message**. This will allow the "Create Job Queue Entries from Integration Entries" Job Queue Entry to pick them up and schedule them for sending.
  - Troubleshooting
    - *Show Status Message*: Displays the detail of the **Status Message **in a pop-up dialog.
    - *View Request Body*: If a Job Queue Entry exists, displays the content of the that has been parsed to be sent for processing.
    - *Recreate Integation Entry*: 
      - For all **Status**, except *Success*, it sets the **Status** = *New*, clears **Status Message** and attempts to create the Job Queue Entry. May result in Status being set to Validation Error if there are issues processing the data.
      - If the **Status** = *Success*, it creates a copy of the entry, sets the **Status** = *New*, clears **Status Message** and attempts to create the Job Queue Entry. May result in Status being set to Validation Error if there are issues processing the data.
    - *Acknowledge Error*: Sets the **Status** to "*Error Acknowledged*". This will let the entry be cleaned up by the "Clear completed integration entries" job.
