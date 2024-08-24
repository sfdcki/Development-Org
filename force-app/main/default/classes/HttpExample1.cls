public class HttpExample1
{
    public string accName {set;get;}
   // public string result {set;get;}
    public Map<String,Object> mapres {set;get;}
	public void getData()
    {
        Account acc = [select id,name from Account where name=:accName];
        HTTP p = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setMethod('GET');
        req.setEndPoint('https://ap2.salesforce.com/services/data/v36.0/sobjects/Account/'+acc.id);
        req.setHeader('Authorization','OAuth '+UserInfo.getSessionId());
        HTTPResponse res = p.send(req);
        String result = res.getBody();
        mapres = (Map<String,Object>)JSON.deserializeUntyped(result);
    }
}