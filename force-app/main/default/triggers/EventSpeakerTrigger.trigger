trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {

    //EventSpeakerTriggerHandler.duplicateSpeaker(Trigger.new);
    Set<Id> eventId = new Set<Id>();
    Set<Id> speakerId = new Set<Id>();
    for(Event_Speaker__c evtSpkr: Trigger.new){
        eventId.add(evtSpkr.Event__c);
        speakerId.add(evtSpkr.Speaker__c);
    }
    Map<Id,Event__c> evtDateTime= new Map<Id, Event__c>([Select id, Start__c,End__c from Event__c where id in :eventId]);

    List<Event_Speaker__c> spkr = [Select id, Event__c ,Speaker__c from Event_Speaker__c where Speaker__c in :speakerId];

    Set<Id> OldEventIds = New Set<Id>();

    for(Event_Speaker__c evtSpkr: spkr){
        OldEventIds.add(evtSpkr.Event__c);
    }
 
    Map<Id,Event__c> OldevtDateTime= new Map<Id, Event__c>([Select id, Start__c,End__c from Event__c where id in :OldEventIds]);

    for(Event_Speaker__c evtSpkr: Trigger.new){
        Event__c evtTime1 = evtDateTime.get(evtSpkr.Event__c);       
        for(Event_Speaker__c checkEvtSpkr: spkr){
            if(checkEvtSpkr.Id == evtSpkr.Id && checkEvtSpkr.Speaker__c == evtSpkr.Speaker__c && checkEvtSpkr.Event__c == evtSpkr.Event__c){
                break;
            }

            Event__c OldEventTime1 = OldevtDateTime.get(checkEvtSpkr.Event__c);
            if(evtSpkr.Speaker__c == checkEvtSpkr.Speaker__c &&  ((evtTime1.Start__c <= OldEventTime1.Start__c && evtTime1.Start__c <= evtTime1.End__c) ||( evtTime1.Start__c <= OldEventTime1.End__c && evtTime1.Start__c <= evtTime1.End__c ))){
                
                evtSpkr.Speaker__c.addError('Already booked');
                evtSpkr.addError('Already Booked');
            }
        }
    }
}