@isTest
private class DeleteEventBatchTest {
    @isTest
    static void testDeleteEvents(){
        List<Event__c> eventsToDelete = new List<Event__c>();
        for (Integer i = 0; i < 200; i++) {
             Event__c event = new Event__c();
             event.Name__c = 'Test Event ' + i;
             event.Start__c = Date.today().addMonths(-3);
             event.End__c = Date.today().addMonths(-2);
             event.Live__c = true;
             eventsToDelete.add(event);
        }
        insert eventsToDelete;
        Test.startTest();
        DeleteEventBatch batch = new DeleteEventBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Event__c> remainingEvents = [SELECT Id FROM Event__c];
        System.assertEquals(0, remainingEvents.size(),'Expected Remaining Size is equal to Actual Remaining Size.');
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress FROM EmailMessage WHERE Subject = 'Batch Job Completed'];
        System.assertEquals(1, sentEmails.size(),'Expected Size is equal to Actual Size.');
        System.assertEquals('ashutosh.singh@mirketa.com', sentEmails[0].ToAddress,'Expected Address is matched with Actual Address.');
    }
}