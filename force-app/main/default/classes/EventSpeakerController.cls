public with sharing class EventSpeakerController {

     public Speaker__c spkr{get;set;}
    
     // public Event__c evt{get;set;}
    
     public String paramValue;
    
     public Boolean bool{get;set;}
    
     public Event_Speaker__c evtSpkr{get;set;}
    
     public EventSpeakerController() {
     paramValue = apexpages.currentpage().getparameters().get('parameter');
     spkr = new Speaker__c();
    
     // evt = new Event__c();
    
     evtSpkr = new Event_Speaker__c();
    
     evtSpkr.Event__c = paramValue;
    
     if(paramValue!=null){
    
     bool= false;
    
     }
    
     else{
    
     bool = true;
    
     }
     }

    public void save(){
    
    insert spkr;
    
    evtSpkr.Speaker__c = spkr.Id;
    
    insert evtSpkr;
    
     }
    
    }