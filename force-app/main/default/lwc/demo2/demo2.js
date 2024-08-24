import { LightningElement } from 'lwc';

export default class Demo2 extends LightningElement {
    handleSubmit(){
        var inputCmp = this.template.querySelector('.inpCmp');
        const abc = inputCmp.value;
        const filterChangeEvent = new CustomEvent('entertext', {
            detail: { abc },
        });
        this.dispatchEvent(filterChangeEvent);
    }
}