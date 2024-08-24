public class AnimalLocator {
	
	public static String getAnimalNameById(Integer id) {
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		List<Object> animals = new List<Object>();
		String name = NULL;
		if (response.getStatusCode() == 200) {
			//Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
			//animals = (List<Object>) result.get('animals');
			string result = response.getBody(); 
            system.JSONParser jp = JSON.createParser(result); 
            while(jp.nextToken() != null) 
            { 
                if(jp.getText() == 'name') 
                { 
                    jp.nextToken(); 
                    name = jp.getText(); 
                } 
			}
		}
		return name;
	} // end getAnimalNameById method
    
} // end AnimalLocator class