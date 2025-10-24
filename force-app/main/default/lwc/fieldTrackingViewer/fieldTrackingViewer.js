import { LightningElement, api, wire, track } from 'lwc';
import getTrackingData from '@salesforce/apex/FieldTrackingController.getTrackingData';

export default class FieldTrackingViewer extends LightningElement {
    @api recordId;
    @track trackingData = [];
    @track columns = [
        { label: 'Field', fieldName: 'Field_Name__c' },
        { label: 'Old Value', fieldName: 'Old_Value__c' },
        { label: 'New Value', fieldName: 'New_Value__c' },
        { label: 'Changed By', fieldName: 'Change_By_Name' },
        { label: 'Date', fieldName: 'Change_Date__c'}
    ];

    @wire(getTrackingData, { recordId: '$recordId' })
    wiredTracking({ data, error }) {
        if (data) {
            this.trackingData = data.map(record => ({
                ...record,
                Change_By_Name: record.Change_By__r ? record.Change_By__r.Name : ''
            }));
        } else if (error) {
            console.error(error);
        }
    }

}
