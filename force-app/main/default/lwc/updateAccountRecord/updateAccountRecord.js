import { LightningElement,track,api,wire } from 'lwc';
import { getRecord  } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_ID from '@salesforce/schema/Account.Id';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_SITE from '@salesforce/schema/Account.Site';
import ACCOUNT_OWNER from '@salesforce/schema/Account.Owner.Name';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class UpdateAccountRecord extends LightningElement {
@api recordId;
@track accName;
@track accSite;
inputLabel;
inputValue;
//Fetch Account details
@wire(getRecord,{recordId: '$recordId', fields: [ACCOUNT_NAME,ACCOUNT_SITE], optionalFields:[ACCOUNT_OWNER]})
AccountRecord({data,error}){
if(data){
    this.accName = data.fields.Name.value;
    this.accSite = data.fields.Site.value;
} else if(error){
    console.log("error === "+error);
}
}
handleChanges(event){
    this.inputLabel = event.target.label;
    this.inputValue = event.target.value;
    if(this.inputLabel === 'Account Name' && this.inputValue !== null && this.inputValue !== '' && this.inputValue !== undefined ){
        this.accName = event.target.value;
    }
    if(this.inputLabel === 'Account Site' && this.inputValue !== null && this.inputValue !== '' && this.inputValue !== undefined ){
        this.accSite = event.target.value;
    }
}
updateAccountRecord(event){
const fields = {};
fields[ACCOUNT_ID.fieldApiName] = this.recordId;
fields[ACCOUNT_NAME.fieldApiName] = this.accName;
fields[ACCOUNT_SITE.fieldApiName] = this.accSite;
const recordInput = {fields};
updateRecord(recordInput)
.then(()=>{this.dispatchEvent(
    new ShowToastEvent({
        title: 'Success',
        message: 'Account Id ' + this.recordId + ' has been updated successfully.',
        variant: 'success',
    }),
);}).catch(error=>{  this.dispatchEvent(
    new ShowToastEvent({
        title: 'Updating error',
        message: error.body.message,
        variant: 'error',
    }),
);});
}
}