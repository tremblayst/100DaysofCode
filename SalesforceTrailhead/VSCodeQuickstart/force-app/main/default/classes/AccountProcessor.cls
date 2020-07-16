public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> accounts = [Select Id, Number_of_Contacts__c FROM Account WHERE Id in :accountIds];
        List<Contact> contacts = [Select Id, AccountId FROM Contact WHERE AccountId in :accountIds];
        for(Account a : accounts){
            Set<Id> contactsForAccount = new Set<Id>();
            for(Contact c : contacts){
                if(c.accountId == a.Id){
                    contactsForAccount.add(c.Id);
                }
            }
            a.Number_of_Contacts__c = contactsForAccount.size();
        }
        update accounts;
    }

}
