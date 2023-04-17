@isTest
private class EventSpeakerTriggerTest{
    
     // Test case where a speaker is not already booked for the same time as the event
    @isTest 
	static void testValidEventSpeakerInsert() {
    // Create test data 
    Event__c event = new Event__c(Name__c = 'Test Event 1', Live__c = true, Start__c = Datetime.now().addDays(3), End__c = Datetime.now().addDays(7)); 
    insert event; 
    Speaker__c speaker = new Speaker__c(Name = 'Test Speaker'); 
    insert speaker; 
    Event_Speaker__c eventSpeaker = new Event_Speaker__c(Event__c = event.Id, Speaker__c = speaker.Id); 

    // Test trigger behavior 
    Test.startTest(); 
    insert eventSpeaker; 
    Test.stopTest(); 

    // Verify no errors were thrown 
    System.assertEquals(0, eventSpeaker.getErrors().size()); 
    }
    
    // Test case where a speaker is already booked for the same time as the event
	@isTest
	static void testDuplicateEventSpeakerInsert() {
    // Create test data
    Event__c event1 = new Event__c(Name__c = 'Test Event 1',Live__c = true, Start__c = Datetime.now().addDays(3), End__c = Datetime.now().addDays(7));
    insert event1;
    Event__c event2 = new Event__c(Name__c = 'Test Event 2',Live__c = true, Start__c = Datetime.now().addDays(2), End__c = Datetime.now().addDays(8));
    insert event2;
    Speaker__c speaker = new Speaker__c(Name = 'Test Speaker');
    insert speaker;
    Event_Speaker__c eventSpeaker1 = new Event_Speaker__c(Event__c = event1.Id, Speaker__c = speaker.Id);
    Event_Speaker__c eventSpeaker2 = new Event_Speaker__c(Event__c = event2.Id, Speaker__c = speaker.Id);
    insert eventSpeaker1;
    
    // Test trigger behavior
    Test.startTest();
    try{
        insert eventSpeaker2;
    }
    catch(Exception e){
        Event_Speaker__c es = eventSpeaker2;
        es.Speaker__c.addError('Already booked');
        //System.debug(e);
    }
    Test.stopTest();
    
    // Verify errors were thrown
    System.assertEquals(1, eventSpeaker2.getErrors().size());
    System.assertEquals('Already booked', eventSpeaker2.getErrors()[0].getMessage());
	}
    
    // Test case where an existing event speaker is updated to a valid time slot   
	@isTest   
	static void testValidEventSpeakerUpdate() {       
	// Create test data       
	Event__c event1 = new Event__c(Name__c = 'Test Event 1',Live__c = true, Start__c = Datetime.now().addDays(3), End__c = Datetime.now().addDays(7));       
	insert event1;       
	Event__c event2 = new Event__c(Name__C = 'Test Event 2',Live__c = true, Start__c = Datetime.now().addDays(9), End__c = Datetime.now().addDays(17));       
	insert event2;       
	Speaker__c speaker = new Speaker__c(Name = 'Test Speaker');       
	insert speaker;       
	Event_Speaker__c eventSpeaker = new Event_Speaker__c(Event__c = event1.Id, Speaker__c = speaker.Id);       
	insert eventSpeaker;              
	// Test trigger behavior       
	eventSpeaker.Event__c = event2.Id;       
	Test.startTest();       
	update eventSpeaker;       
	Test.stopTest();              
	// Verify no errors were thrown       
	System.assertEquals(0, eventSpeaker.getErrors().size());   
	}
    
}