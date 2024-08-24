Public class MixedDMLExceptionTestClass
{
    Public static void DoDMLOperations()
    {
         Account acc = [select id, name, rating, annualrevenue from Account where name ='Chpet' limit 1];
        system.debug('Account Record is....: '+ acc);
        
        if(acc != null)
        {
            acc.annualrevenue = 60000;
            update acc;
            
            System.debug('Account Record Updated Successfully. : '+ acc);
        }
        
        User u = [select id, username, isActive from user where username = 'test_sf@yahoo.com' limit 1];
        
        if(u != null )
        {
            system.debug('User Record is...: '+ u);
            
            u.isActive = false;
            update u;
            
            System.debug('User Record Updated Successfully. : ' + u);
        }
        
    }
}