public class JSONParser3 {
    public Student std {set;get;}
    public JSONParser3(){
        String jsonString='{"Status":"Success","Std":{"StudentAddress":"satish","StudentID":1234,"StudentNae":"uday"}}';
      System.JSONParser jp=JSON.createParser(jsonString);
        jp.nextToken();
                jp.nextToken();
                        jp.nextToken();
        while(jp.nextToken()!=null){
           if(jp.getCurrentToken()==System.JSONToken.START_OBJECT){
                std=(Student)jp.readValueAs(Student.class);
            }
        }
   }
}