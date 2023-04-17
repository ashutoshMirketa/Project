@isTest
private class EventAttendeeTriggerTest {
    @isTest
    static void attendeeEmailSendTest() {
        // Setup test data
        Event_Organizer__c org = new Event_Organizer__c(
            Name = 'Test Org',
            Phone__c = '1234567890',
            Email__c = 'ashutosh.singh@mirketa.com'
        );
        insert org;
        Event__c evt = new Event__c(
            Name__c = 'Test Event',
            Event_Organizer__c = org.Id,
            Event_Type__c = 'Virtual',
            Fequency__c = 'Weekly',
            Max_Seats__c = 100,
            Recurring__c = true,
            Live__c = true,
            Start__c = System.now().addDays(1),
            End__c = System.now().addDays(3)
        );
        insert evt;
        Attendee__c att = new Attendee__c(
            Name = 'Test Attendee',
            Email__c = 'aman.kumar@mirketa.com',
            Phone__c = '1234567890'
        );
        insert att;
        Event_Attendee__c evtAtt = new Event_Attendee__c(
            Event__c = evt.Id,
            Attendee__c = att.Id
        );
        insert evtAtt;
        
        // Call the method being tested
        Test.startTest();
        EventAttendeeTriggerHandler.attendeeEmailSend(new List<Event_Attendee__c>{ evtAtt });
        Test.stopTest();
        
        // Verify that an email was sent
        System.assertEquals(1, Limits.getEmailInvocations());
    }
}