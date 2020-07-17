@isTest
private class ParkLocatorTest {
    @isTest
    static void TestParkLocator(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        String[] parkNames = ParkLocator.country('Germany');

        System.assertEquals(parkNames.size(), 2);
    }
}
