public class JSONParser1 {
  public String  jsonString;
    public String   result {set;get;}
    public JSONParser1(){
        jsonString='{"Name":"","Age":32}';
        System.JSONParser jp=JSON.createParser(jsonString);
        while(jp.nextToken()!=null){
           // result=result+'==>>'+jp.getText();
            //result=result+'==>>'+jp.getCurrentName();
           //result=result+'===>>'+jp.getCurrentToken();
            if(jp.getCurrentToken()==System.JSONToken.FIELD_NAME ) {
                result=result+'==>'+jp.getText();
            }
            if(jp.getCurrentToken()==System.JSONToken.VALUE_NUMBER_INT){
                result=result+'==>'+jp.getIntegerValue();
            }
        }
    }
}