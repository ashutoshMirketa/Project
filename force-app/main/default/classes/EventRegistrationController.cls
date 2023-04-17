public with sharing class EventRegistrationController {

    public Event_Organizer__c evtOrganizer {get;set;}
	public Event__c evt {get;set;}
	public Location_Address_Book__c	 loc {get;set;}

	public EventRegistrationController ()
	{
		evtOrganizer = new Event_Organizer__c();
		evt = new Event__c();
		loc = new Location_Address_Book__c();
	}
	public void save() 
	{
		// insert con;
		insert loc;
        evtOrganizer.Location_Address_Book__c = loc.Id;
        loc=new Location_Address_Book__c();
		
		insert evtOrganizer;
       
        evt.Event_Organizer__c = evtOrganizer.Id;
        evtOrganizer = new Event_Organizer__c();
		evt.Location_Address_Book__c = loc.Id;
		insert evt;
        evt=new Event__c();
		
	}
}