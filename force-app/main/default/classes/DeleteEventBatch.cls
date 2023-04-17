public with sharing class DeleteEventBatch implements Database.Batchable <sObject>{
    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        String query = 'SELECT Id,End__c,Live__c FROM Event__c WHERE End__c <= LAST_N_MONTHS:2 AND Live__c = true';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext batchContext, List<Event__c> events) {
         // Delete all the Event records in the current batch
        delete events;
    }
    public void finish(Database.BatchableContext batchContext) {
    // Send email to the admin after the batch has finished executing
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    // Replace with your email address
    String[] toAddresses = new String[]{'ashutosh.singh@mirketa.com'};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Batch Job Completed');
    mail.setPlainTextBody('Execution of the batch has been processed. ');
    Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    for(Messaging.SendEmailResult result: results){
        if(result.isSuccess()){
            System.debug('Email sent successfully.');
        }
        else {
            System.debug('Email could not be sent:' + result.getErrors()[0].getMessage());
        }
    }
}

}