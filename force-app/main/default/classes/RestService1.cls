public class RestService1
{
	
	public string clientId {set;get;}
    public string clientsecret {set;get;}
    public string userName {set;get;}
    public string password {set;get;}
    public string accessToken {set;get;}
    public string resp {set;get;}
    public string name {set;get;}
    public string industry {set;get;}
    public string body {set;get;}
    public void getToken()
    {
        string url = 'https://login.salesforce.com/services/oauth2/token';
        String body='grant_type=password&';
        body=body+'&client_id='+clientId;
        body=body+'&client_secret='+clientSecret;
        body=body+'&username='+userName;
        body=body+'&password='+password;
        
        HTTP p = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setMethod('POST');
        req.setEndpoint(url);
        req.setBody(body);
        HTTPResponse res = p.send(req);
        string result = res.getBody();
        system.JSONParser jp = JSON.createParser(result);
        while(jp.nextToken() != null)
        {
            if(jp.getText() == 'access_token')
            {
                jp.nextToken();
                accessToken = jp.getText();
            }
        }
    }
    public void insertData()
    {
        HTTP p = new HTTP();
        body = '{"name":"';
        body += name;
        body += '","industry":"';
        body += industry;
        body += '"}';
        HTTPRequest req = new HTTPRequest();
        req.setMethod('POST');
        req.setEndpoint('https://ap2.salesforce.com/services/apexrest/accountList');
        req.setHeader('Authorization','OAuth '+accessToken);
        req.setHeader('Accept','application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(body);
        HTTPResponse res = p.send(req);
        resp = res.getBody();
    }
        public void getData()
    {
        body = 'https://ap2.salesforce.com/services/apexrest/accountList?name=';
        body += name;
        HTTP p = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setMethod('GET');
        req.setEndpoint(body);
        req.setHeader('Authorization','OAuth '+accessToken);
        HTTPResponse res = p.send(req);
        resp = res.getBody();
    }
}