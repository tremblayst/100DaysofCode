@isTest
private class AnimalLocatorTest {
    @isTest
    static void testAnimalLocator(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        String name = AnimalLocator.getAnimalNameById(1);

        System.assertEquals(name, 'chicken');
    }
}
