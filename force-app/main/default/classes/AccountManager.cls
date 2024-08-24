@RestResource(urlmapping='/Accounts/*/contacts')
Global class AccountManager {
	@HttpGet	
    Global static Account getAccount()
        {
            RestRequest request = RestContext.request;
            Id accId = request.requestURI.substringBetween('Accounts/','/contacts');
            Account acc = [select id, Name,(select Id, Name from Contacts) from Account where Id =: accId];
            return acc;
        }
}