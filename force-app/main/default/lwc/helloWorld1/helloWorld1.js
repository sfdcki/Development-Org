import { LightningElement, track, wire } from 'lwc';
import sayHello from '@salesforce/apex/HelloWorld.sayHello';

export default class HelloWorld1 extends LightningElement {
   @wire(sayHello) greeting;
}