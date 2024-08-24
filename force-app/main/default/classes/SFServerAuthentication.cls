public class SFServerAuthentication 
{
    public string clientId {set;get;}
    public string clientSecret {set;get;}
    public string callbackurl {set;get;}
    public string code {set;get;}
    public string accesstoken {set;get;}
    public SFServerAuthentication()
    {
        callbackurl='';
    }
    public PageReference getMyCode()
    {
        String url='https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id='+clientId+'&redirect_uri='+callbackurl;
        PageReference p=new PageReference(url);
        return p;
    }
    public void generatecode()
    {
        code=apexpages.currentPage().getParameters().get('code');
    }
    public void getAccessToken()
    {
        HTTP tp=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
         String body='grant_type=authorization_code&';
        body=body+'client_id='+clientId;
        body=body+'&client_secret='+clientSecret;
        body=body+'&redirect_uri='+callbackurl;
        body=body+'&code='+code;
        req.setBody(body);
        HTTPResponse res=tp.send(req);
        system.JSONParser jp=JSON.createParser(res.getBody());
        while(jp.nextToken() !=null)
        {
            if(jp.getText() == 'access_token')
            {
                jp.nextToken();
                accesstoken=jp.getText();
            }
        }
    }
}