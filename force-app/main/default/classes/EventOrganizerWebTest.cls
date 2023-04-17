@isTest
public class EventOrganizerWebTest {
    static testMethod void testGetMethod(){
        Event__c evt =new Event__c();
        Event_Organizer__c evtOrg = new Event_Organizer__c();
        evt.Name__c ='Test Event Web Service 1';
        evt.Start__c=datetime.newInstance(2024,9,15,12,30,0);
        evtOrg.Email__c='abc@avc.com';
        insert evtOrg;
        evt.Event_Organizer__c=evtOrg.Id;
        insert evt;
        RestRequest req =new RestRequest();
        req.requestURI='/services/apexrest/v1/EventOrganizerWeb/';
        req.httpMethod='GET';
        RestContext.request=req;
        Test.startTest();
        List<EventOrganizerWeb.EventWrapper> evnt = EventOrganizerWeb.doGetMethod();
        Test.stopTest();
        System.assert(evnt!=null);
        System.assertEquals('Test Event Web Service 1', evnt.get(0).event.Name__c);


    
    }

}