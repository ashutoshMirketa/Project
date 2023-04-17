@RestResource(urlMapping='/v1/EventOrganizerWeb/')
global class EventOrganizerWeb {
@httpGet
global static List<EventWrapper> doGetMethod(){
    List<EventWrapper> eventWrappers = new List<EventWrapper>();
    List<Event__c> events = [SELECT Name__c, Start__c, Max_Seats__c,Event_Organizer__r.Name , Event_Organizer__r.Email__c FROM Event__c];
 for (Event__c event : events) {
    EventWrapper eventWrapper = new EventWrapper();
    eventWrapper.event = new Event__c();
    eventWrapper.event.Name__c = event.Name__c;
    eventWrapper.event.Start__c = event.Start__c;
    eventWrapper.event.Max_Seats__c = event.Max_Seats__c;
    eventWrapper.event_organizer = new Event_Organizer__c();
    eventWrapper.event_organizer.Name = event.Event_Organizer__r.Name;
    eventWrapper.event_organizer.Email__c = event.Event_Organizer__r.Email__c;
    eventWrappers.add(eventWrapper);
 }
 return eventWrappers;
 }
 // Wrapper class for events
global class EventWrapper {
    global Event__c event;
    global Event_Organizer__c event_organizer;
 }
}