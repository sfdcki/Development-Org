public class BoxDotComExample 
{
    public string clientid {set;get;}
    public string callbackurl {set;get;}
    public string code {set;get;}	
    public string clientSecret {set;get;}
    public string accesstoken {set;get;}
    public string result {set;get;}
    public PageReference getCode()
    {
        String url='https://account.box.com/api/oauth2/authorize?response_type=code&client_id='+clientid+'&redirect_uri='+callbackurl;
        PageReference pr=new PageReference(url);
        return pr;        
    }
    
    public void createCode()
    {
        code=ApexPages.currentPage().getParameters().get('code');
    }
    public void generateToken()
    {
        HTTP p=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.box.com/oauth2/token');
        String body='grant_type=authorization_code&';
        body=body+'client_id='+clientId;
        body=body+'&client_secret='+clientSecret;
        body=body+'&redirect_uri='+callbackurl;
        body=body+'&code='+code;
        req.setBody(body);
        HTTPResponse res=p.send(req);
        String resbody=res.getBody();
        System.JSONParser jp=JSON.createParser(resbody);
        while(jp.nextToken()!=null)
        {
            if(jp.getText() =='access_token')
            {
                jp.nextToken();
                accesstoken=jp.getText();
            }
        }
    }
    public void createFolder()
    {
        HTTP p=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.box.com/2.0/folders');
        String fbody='{"name":"Test", "parent": {"id": "0"}}';
        req.setBody(fbody);
        req.setHeader('Authorization','Bearer '+accesstoken);
        HTTPResponse res=p.send(req);
        result=res.getBody();
    }
}