public class SOSLDisplay 
{
    public static void SearchKey(string str)
    {
        list<list<SObject>> lstSearchResults = [find :str IN ALL FIELDS RETURNING
                       Account(id,name,industry,type),
                       Contact(Id, firstName, lastname, title, email, phone, fax)];
        
        List<Account> lstAccounts = new List<Account>();
       	lstAccounts = (List<Account>) lstSearchResults.get(0);
        if(!lstAccounts.isEmpty())
        {
        for(Account acc:lstAccounts)
        {
            system.debug('Acc record is'+acc);
        }
        }
        List<Contact> lstContacts = new List<Contact>();
       	lstContacts = (List<Contact>) lstSearchResults.get(1);
        if(!lstContacts.isEmpty())
        {
            
        }
        for(Contact con:lstContacts)
        {
            system.debug('Acc record is'+con);
        }
    }
    
    public static void LeadTaskEvent(String str1)
    {
        list<lead> Num = [SELECT Id FROM Lead WHERE FirstName =: str1];
        for(lead le:Num)
        {
            system.debug('lead record id'+le);
             list<Task> Tsklst = [SELECT AccountId,CreatedById,Description,Priority,Status,Subject,WhatId,WhoId FROM Task where WhoId =: le.id];
        for(Task Ts:Tsklst)
        {
            system.debug('Associated Task is:'+Ts);
        }
         
         list<Event> Eve = [SELECT AccountId,ActivityDate,CreatedById,Description,Id,Subject,WhatId,WhoId FROM Event where WhoId =: le.id];
               for(Event Ev:Eve)
        {
            system.debug('Associated Event is:'+Ev);
        }
        }
       
        
    }
    }