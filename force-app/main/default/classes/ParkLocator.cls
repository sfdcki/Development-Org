public class ParkLocator {
	public static String[] country(String name)
    {
        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();
        return parks.byCountry(name);
    }
}