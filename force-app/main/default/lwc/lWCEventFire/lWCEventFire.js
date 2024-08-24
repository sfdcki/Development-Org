import { LightningElement,track,api } from 'lwc';

export default class FirstLWC extends LightningElement {
    @track greeting = 'World';
    
    changeHandler(event){
        this.greeting = event.target.value;
        const value = event.target.value;
        const eventFire = new CustomEvent('selected', {
            detail: { value },
        });
        this.dispatchEvent(eventFire);
    }
    
 
}