public class HttpExample2 
{
    public list<String> names{get;set;}
    public string response {get;set;}
	public void showResult()
    {
        HTTP p = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setMethod('GET');
        req.setEndpoint('https://ap2.salesforce.com/services/data/v36.0/sobjects/');
        req.setHeader('Authorization','OAuth '+UserInfo.getSessionId());
        HTTPResponse res = p.send(req);
        response = res.getBody();
        System.JSONParser jp = JSON.createParser(response);
        names = new list<String>();
        while(jp.nextToken() != null)
        {
            if(jp.getText() == 'label')
            {
                jp.nextToken();
                names.add(jp.getText());
            }
        }
    }
}