@IsTest
private class WarehouseCalloutServiceTest {
    @isTest
    static void testWarehouseCalloutService(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());


        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
    }
}
