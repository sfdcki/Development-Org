import { LightningElement, api } from "lwc";
import LightningConfirm from 'lightning/confirm';
export default
class recordCardQuickFiles extends LightningElement {
 @api
 recordId;
 onDeleteAllFilesButtonClick() {
    const result = LightningConfirm.open({
        message: 'Are you sure you want to delete all files?',
        variant: 'headerless',
        label: 'Are you sure you want to delete all files?',
        // setting theme would have no effect
    });
  }
}