@isTest
private class LeadProcessorTest {
    @testSetup
    static void createTestLeads(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i < 200; i++) {
            Lead l = new Lead(FirstName='Test lead ', LastName = i+'', Company = 'Test');
            leads.add(l);
        }
        insert leads;
    }
    
    @isTest
    static void testLeadProcessor(){
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}
