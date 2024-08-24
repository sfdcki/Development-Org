@isTest
private class AnimalLocatorTest {
    @isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        //StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        //mock.setStaticResource('TrailheadResource');
        //mock.setStatusCode(200);
        //mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        System.Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test	
        String result = AnimalLocator.getAnimalNameById(1);
        // Verify mock response is not null
        //String animals = (String)result.get('animals');
        //System.assertEquals('TestAnimal', result);          
    }

}