import { LightningElement } from 'lwc';

export default class Demo1 extends LightningElement {
    accountName='abc';
    accountName1;
    handleClick(event){
        console.log(event.detail.value);
        var inputCmp = this.template.querySelector('.inputCmp');
        this.accountName1 = inputCmp.value + 'abc';
    }
}