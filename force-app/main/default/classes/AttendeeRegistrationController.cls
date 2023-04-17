public with sharing class AttendeeRegistrationController {
    public Event_Attendee__c evtAttndee{get;set;}
    public Attendee__c attndee{get;set;}
    public Location_Address_Book__c loc{get;set;}
    public String paramValue;
    public Boolean bool{get;set;}
    public AttendeeRegistrationController() {
      paramValue = apexpages.currentpage().getparameters().get('parameter');
      evtAttndee = new Event_Attendee__c();
      attndee = new Attendee__c();
      loc = new Location_Address_Book__c();
      evtAttndee.Event__c = paramValue;

      if(paramValue!=null){
        bool= false;
      }
      else{
        bool = true;
      }
    }
    public void save(){
      insert loc;
      attndee.Location_Address_Book__c = loc.Id;
      loc= new Location_Address_Book__c();
      insert attndee;
      evtAttndee.Attendee__c = attndee.Id;
      attndee=new Attendee__c();
      insert evtAttndee;
      evtAttndee=new Event_Attendee__c();  
 } 
}