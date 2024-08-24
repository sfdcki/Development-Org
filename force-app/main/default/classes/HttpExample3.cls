public class HttpExample3 
{
    public string clientId {set;get;}
    public string clientsecret {set;get;}
    public string userName {set;get;}
    public string password {set;get;}
    public string accessToken {set;get;}
    public list<String> names {set;get;}
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
    public void getData()
    {
        HTTP p = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setMethod('GET');
        req.setEndpoint('https://ap2.salesforce.com/services/data/v36.0/sobjects/');
        req.setHeader('Authorization','OAuth ' +accessToken);
        HTTPResponse res = p.send(req);
        String resp = res.getBody();
        system.JSONParser jp = JSON.createParser(resp);
        names = new list<String>();
        while(jp.nextToken() !=null)
        {
            if(jp.getText() == 'label')
            {
                jp.nextToken();
                names.add(jp.getText());
            }
        }
    }
}