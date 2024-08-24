@isTest
public class ParkLocatorTest {
@isTest static void testPark()
{
	 
        System.Test.setMock(WebServiceMock.class, new ParkServiceMock());
     
        String Country = 'United States';
        List<String> result = ParkLocator.country(Country);
        System.assertEquals(new List<String>{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'}, result);     
}
}