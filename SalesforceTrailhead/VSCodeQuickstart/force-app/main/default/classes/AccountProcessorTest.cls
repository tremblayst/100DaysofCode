@isTest
public with sharing class AccountProcessorTest {
    @isTest
    public static void testCountContact(){
        List<Account> accts = new List<Account>();
        List<Id> accountIds = new List<Id>();
        Map<Id,Integer> expectedcounts = new Map<Id,Integer>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i);
            accts.add(acct);
        }
        insert accts;
        List<Contact> contacts = new List<Contact>();
        Integer temp = 0;
        for(Account a :accts){
            accountIds.add(a.Id);
            expectedcounts.put(a.Id,Math.mod(temp,5));
            for(Integer i=0; i < Math.mod(temp,5); i++) {
                Contact c = new Contact(FirstName='Test Contact ',LastName = temp+'', AccountId = a.Id);
                contacts.add(c);
            }
            temp++;
        }
        insert contacts;

        // Perform Test
        Test.startTest();
        AccountProcessor.countContacts(accountIds);                             
        Test.stopTest();

        List<Account> processedAccounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        for(Account a : processedAccounts){
            System.assertEquals(expectedcounts.get(a.Id), a.Number_of_Contacts__c);
        }
    }
}
