public with sharing class EventSpeakerDetailsController {
    public string masterID{get;set;}
    public Event__c evt{get;set;}
    public List<Event_Speaker__c> evtSpkr{get;set;}
    public EventSpeakerDetailsController() {
        masterID =apexpages.currentpage().getparameters().get('id');
        evt=[select id,Name__c,Event_Organizer__r.Name,Location_Address_Book__r.Name,Start__c from Event__c where id=:masterID Limit 1];
        evtSpkr=[select id, Event__r.Name__c,Speaker__r.Name,Speaker__r.URL__c,Speaker__r.About_Me__c from Event_Speaker__c where Event__c=:masterID];

    }
    public PageReference saveAsAttendee(){
        return new PageReference('/apex/AttendeRegistration?parameter='+masterID).setRedirect(true);

    }
    public PageReference saveAsSpeaker(){
        return new PageReference('/apex/SpeakerRegistration?parameter='+masterID).setRedirect(true);
        
    }
}