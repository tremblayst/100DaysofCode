@isTest
public with sharing class AccountTriggerTest {
    @isTest static void TestCreateAccount(){
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i,BillingState='CA');
            accts.add(acct);
        } 
        
        Test.startTest();
        insert accts;                               
        Test.stopTest();
        // Verify that 200 new Accounts were inserted
        List<Account> verifyAccts = [SELECT Id, BillingState, ShippingState FROM Account];
        System.assertEquals(200, verifyAccts.size());    

        for (Account a : verifyAccts) {
            System.assertEquals(a.ShippingState,'CA');  
        }                         
    }
}
