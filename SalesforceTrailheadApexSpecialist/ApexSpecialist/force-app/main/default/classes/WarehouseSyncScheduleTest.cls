@isTest
private class WarehouseSyncScheduleTest {
    @isTest
    static void testWarehouseSyncSchedule(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

        String CRON_EXP = '0 0 0 15 3 ? 2022';

        Test.startTest();

        String jobId = System.schedule('ScheduledApexTest',CRON_EXP, new WarehouseSyncSchedule());

        Test.stopTest();

    }
}
