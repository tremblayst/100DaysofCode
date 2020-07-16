@isTest
private class AddPrimaryContactTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i < 50; i++) {
            Account a = new Account(Name='Test NY '+i, BillingState='NY');
            accounts.add(a);
        }
        for(Integer i=0; i < 50; i++) {
            Account a = new Account(Name='Test CA '+i, BillingState='CA');
            accounts.add(a);
        }
        insert accounts;
    }
    @isTest
    static void testAddPrimaryContact(){
        AddPrimaryContact apc = new AddPrimaryContact(new Contact(FirstName='test',LastName='contact'),'CA');
        Test.startTest();        
        System.enqueueJob(apc);
        Test.stopTest();  
    }
}
