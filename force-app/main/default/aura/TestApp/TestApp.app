<aura:application extends="force:slds">
  <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
 
<!--  <c:CustomLookupComponent objectAPIName="Hiring_Manager__c" IconName="standard:account" selectedRecord="{!v.selectedLookUpRecord}" label="Account Name"/>-->
    <c:DynamicIterationCustomLookup/>
 <!-- here c: is org. namespace prefix-->
</aura:application>