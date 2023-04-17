public with sharing class EventAttendeeTriggerHandler {
    public static void attendeeEmailSend(List<Event_Attendee__c> evtAttendee) {
        List<Id> attendeeId = new List<Id>();
    for(Event_Attendee__c evtAttndee: evtAttendee){
        attendeeId.add(evtAttndee.Attendee__c);
    }
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<Event_Attendee__c > attendee = [Select id, Attendee__r.Email__c,Event__r.Start__c,Event__r.Name__c, Attendee__r.Name, Event__r.Location_Address_Book__r.State__c, Event__r.Event_Organizer__r.Name,Event__r.Location_Address_Book__r.Country__c,Event__r.Location_Address_Book__r.City__c,Event__r.Location_Address_Book__r.Street__c, Event__c from Event_Attendee__c where Attendee__c in :attendeeId];
    for(Event_Attendee__c evtAttndee: attendee){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setToAddresses(''+evtAttndee.Attendee__r.Email__c);
        List<String> sendTo = new List<String>();
        sendTo.add(evtAttndee.Attendee__r.Email__c);
        mail.setToAddresses(sendTo);
        mail.setReplyTo('ashutosh.singh@mirketa.com');
        mail.setSenderDisplayName(evtAttndee.Event__r.Event_Organizer__r.Name);
        mail.setSubject('Pass for the '+evtAttndee.Event__r.Name__c);
        String body = 'Dear '+evtAttndee.Attendee__r.Name +'<br><br>'+'Thank you for registering for '+ evtAttndee.Event__r.Name__c + ' which will be Organized on '+ evtAttndee.Event__r.Start__c +' & will be held in ' +evtAttndee.Event__r.Location_Address_Book__r.Street__c+', '+ evtAttndee.Event__r.Location_Address_Book__r.City__c+', '+evtAttndee.Event__r.Location_Address_Book__r.State__c+', '+evtAttndee.Event__r.Location_Address_Book__r.Country__c+'. <br>We are excited to have you, see you at the event.<br><br>Thanks<br>'+evtAttndee.Event__r.Event_Organizer__r.Name;

        mail.setHtmlBody(body);
        mails.add(mail);
    }
    try{
            
        Messaging.sendEmail(mails, false); 
    }catch(System.Exception e){
        System.debug(e);
    }
        
    }
}