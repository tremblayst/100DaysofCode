public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accounts)
    {
        for (Account a : accounts) {
            a.ShippingState = a.BillingState;
        }
    }
}
