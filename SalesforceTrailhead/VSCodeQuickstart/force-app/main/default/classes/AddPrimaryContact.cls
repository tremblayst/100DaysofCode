public class AddPrimaryContact implements Queueable{

    private List<Account> accounts;
    private Contact contact;

    public AddPrimaryContact(Contact c, String stateAbbr){
        accounts = [Select Id FROM Account WHERE BillingState = :stateAbbr LIMIT 200];
        contact = c;
    }

    public void execute(QueueableContext context) {
        List<Contact> contacts = new List<Contact>();
        for (Account a : accounts){
            Contact clone = contact.clone();
            clone.AccountId = a.Id;
            contacts.add(clone);
        }
        insert contacts;
    }
}
