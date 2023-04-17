@RestResource(urlMapping='/v1/EventOrganizerPost/')
global  class EventOrganizerPost{
        @httpPost
        global static String doPostMethod(String Name, String email, String phone, String company){
        try  
        {
        Speaker__c spkr= new Speaker__c(Name =Name, Email__c = email, Phone__c = phone, Company__c = company);      
        insert spkr;
        return '200';
        }
        catch(Exception e){
        return '400';
        }

    }
}