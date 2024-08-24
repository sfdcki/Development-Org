@isTest(SeeAllData = True)
public class AccountManagerTest {
	@isTest public Static void getAccountTest()
    {
     	RestRequest req = new RestRequest();
        
        req.requestURI = 'https://mylightninguday-dev-ed.my.salesforce.com/services/apexrest/Accounts/0012800001WraxF/contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;
        AccountManager.getAccount();
    }
}