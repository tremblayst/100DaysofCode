@isTest
private class DailyLeadProcessorTest {

    @isTest
    static void testDailyLeadProcessor(){

        String CRON_EXP = '0 0 0 15 3 ? 2022';

        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i < 200; i++) {
            Lead l = new Lead(FirstName='Test lead ', LastName = i+'', Company = 'Test');
            leads.add(l);
        }
        insert leads;

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());

        Test.stopTest();

        List<Lead> processedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(processedLeads.size(), 200);
    }
}
