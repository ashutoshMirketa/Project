@isTest
public class EventorganizerPostTest {
    static testMethod void testPostMethod() {
        RestRequest req =new RestRequest();
        req.requestURI='/services/apexrest/v1/EventOrganizerPost/';
        req.httpMethod='POST';
        RestContext.request = req;
        Test.startTest();
        String strId = EventOrganizerPost.doPostMethod('Event Organizer Web Service Test 1','p@p.com','123884245','comp');
        String strId2 = EventOrganizerPost.doPostMethod('Event Organizer Web Service Test 1','pk','123884245','comp');
        Test.stopTest();
        System.assertEquals('200', strId);
        System.assertEquals('400', strId2);

    }
}